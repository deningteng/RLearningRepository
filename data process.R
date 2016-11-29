# dplyr包是Hadley Wickham创建和维护的�?
# 它包括了几乎全部可以用来加快数据处理进程的内容�?
# 它最有名的是数据探索和数据转换功能。它的链式语法让它使用起来很方便�?
# 它包�?5个主要的数据处理指令�?
# 过滤——集于某一条件过滤数据
# 选择——选出数据集中感兴趣的�?
# 排列——升序或降序排列数据集中的某一个值域
# 变换——从已有变量生成新的变量
# 概括（通过group_by）——提供常用的操作分析，如最小值、最大值、均值等
# 只需要关注这些指令便可以完成很好的数据探索工作�?

library(dplyr)
data("mtcars")
data("iris")

#create a local dataframe. Local data frame are easier to read
mynewdata<-tbl_df(mydata)
myirisdata<-tbl_df(iris)

#use filter to filter data with required condition
filter(mynewdata,cyl>4&gear>4)
filter(myirisdata,Species %in% c('setosa','virginica'))

#use select to pick columns by name
select(mynewdata,cyl,mpg,hp)
select(mynewdata,-cyl,-mpg) 
select(mynewdata,-c(vs,carb))
select(mynewdata,cly:gear)

#chaining or pipelining - a way to perform mutiple operations in one line
mynewdata %>%
  select(cyl,wt,gear)%>%
  filter(wt>2)

#arrange can be used to reorder rows
mynewdata%>%
  select(cyl,wt,gear)%>%
  arrange(wt)

#or
mynewdata%>%
  select(cyl,wt,gear)%>%
  arrange(desc(wt))

#mutate - create new variables
mynewdata%>%
  select(mpg,cyl)%>%
  mutate(mpgXcyl=mpg*cyl)

#or
newvariable<-mynewdata %>% mutate(mpgXcyl=mpg*cyl)

#summarise - this is used to find insights from data
myirisdata %>%
  group_by(Species) %>%
  summarise(Average = mean(Sepal.Length,na.rm=TRUE))

#or use summarise each
myirisdata %>%
  group_by(Species)%>%
  summarise_each(funs(mean,n()),Sepal.Length,Sepal.Width)

#rename the variables
mynewdata %>% rename(mile = mpg)

# data.table放弃选取行或列子集的传统方法，用这个包进行数据处理�?
# 用最少的代码，你可以做最多的事。相比使用data.frame，data.table可以帮助你减少运算时间�?

library(data.table)
#load data
data("airquality")
mydata<-airquality
head(mydata,6)
data("iris")
myiris<-iris
mydata<-data.table(mydata)
mydata

#select rows - select 2nd to 4th row
mydata[2:4,]
#select column with particular values
myiris=data.table(myiris)
myiris[Species == 'setosa']

#select column with multiple values. This will give you columns with Setosa and virginica species
myiris[Species %in% c('setosa','virginica')]
#select column and returns a vector
mydata[,Temp]
mydata[,.(Temp,Month)]

#return sum of selected column
mydata[,sum(Ozone,na.rm = TRUE)]
#return sum and standard deviation
mydata[,.(sum=sum(Ozone,na.rm=TRUE),sd=sd(Ozone,na.rm = TRUE))]
#grouping by a variable
myiris[,.(sepalsum=sum(Sepal.Length)),by=Species]

#select a column for computation, hence need to set the key on column
setkey(myiris,Species)
#selects all the rows associated with this data point
myiris['setosa']
myiris[c('setosa','virginica')]

#ggplot2
library(ggplot2)
library(gridExtra)
library(cowplot)

df<-ToothGrowth
df$dose<-as.factor(df$dose)
head(df)
#boxplot
bp<-ggplot(df,aes(x=dose,y=len,color=dose))+geom_boxplot()+theme(legend.position = 'none')
#add gridlines
bp+background_grid(major="xy",minor="none")
#scatterplot
sp<-ggplot(mpg,aes(x=cty,y=hwy,color=factor(cyl)))+geom_point(size=2.5)
#barplot
bp<-ggplot(diamonds,aes(clarity,fill=cut))+geom_bar()+
  theme(axis.title.x = element_text(angle=70,vjust=0.5))

#compare two plots
plot_grid(sp,bp,labels=c("A","B"),ncol=2,nrow=1)

#histogram
ggplot(diamonds,aes(x=carat))+
  geom_histogram(binwidth = 0.25,fill='steelblue')+
  scale_x_continuous(breaks = seq(0,3,by=0.5))

#reshape2
# 正如这个包的名字所表示的含义，这个包对于重塑数据格式很有用�?
# 我们都知道数据会有很多不同的表现格式�?
# 因此，我们需要根据需要“驯服”它们以为己用�?
# 通常，在R中重塑数据格式非常无聊和麻烦�?
# R基础函数中有一个Aggregation函数，用来缩减并重新排列数据为更短小的格式，
# 但是会大大减少数据包含的信息量。Aggregation包括tapply，by和aggregate基础函数�?
# reshape包会克服这些问题。在这里我们试着把有一样值的特征合并在一起�?
# 它有两个函数，即melt和cast�?

#melt: 这个函数把数据从宽格式转化为长格式�?
#这是一种把多个类别列“融合”为一行的结构重组�?

#create a data
ID<-c(1,2,3,4,5)
Names<-c('Joseph','Matrin','Joseph','James','Matrin')
DateOfBirth<-c(1993,1992,1993,1994,1992)
Subject<-c('Maths','Biology','Science','Psycology','Physics')
thisData<-data.frame(ID,Names,DateOfBirth,Subject)
data.table(thisData)

library(reshape2)
mt<-melt(thisData,id=(c('ID','Names')))

# Cast: 这个函数把数据从长格式转换为宽格式�?
# 它始于融合后的数据，然后把数据重新构造为长格式�?
# 它就是melt函数的反向操作。它包括两个函数，即，dcast和acast�?
# dcast返回数据框作为输出结果。acast返回向量/矩阵/数组作为输出结果�?
mcast<-dcast(mt,DateOfBirth+Subject ~ variable)
dcast(mt,DateOfBirth+variable~Subject)

#reader
# readr用来把不同格式的数据读入R中，通过比传统方法快十倍的速度�?
# 在此，字符型变量不会被转化为因子型变�?
# （所以不再有stringAsFactors = FALSE命令）�?
# 这个包可以代替传统的R基础函数read.csv()和read.table()�?
# 它可以用来读入以下格式的数据�?
# 分隔符文件：read_delim()，read_csv()，read_tsv()和read_csv2()
# 固定宽度文件：read_fwf()和read_table()
# 网络日志文件：read_log()
# 如果数据载入时间超过5秒，函数还会显示进度条�?
# 可以通过命令它为FALSE来禁止进度条出现�?
library(NCmisc)
library(reader)
read_csv("iris.csv",col_types=list(
  Sepal.Length=col_double(),
  Sepal.Width=col_double(),
  Petal.Length=col_double(),
  Petal.Length=col_doubel(),
  Species=col_factor(c("setosa","versicolor","virginica"))
))

read_csv("iris.csv",col_types=list(
  Species=col_factor(c("setosa","versicolor","virginica"))
))

#tidyr
# 这个包可以让你的数据看上去“整洁”�?
# 它主要用四个函数来完成这个任务�?
# 毋庸赘言，当你发现自己在数据探索阶段卡壳的时候，
# 你可以（和dplyr包一起）随时使用这些函数�?
# 这两个包形成了一个实力强大的组合�?
# 它们很好学，代码容易些，应用便捷。这四个函数是：
# 
# gather()——它把多列放在一起，然后转化为key:value对�?
# 这个函数会把宽格式的数据转化为长格式�?
# 它是reshape包中melt函数的一个替代�?
# spread()——它的功能和gather相反，把key:value对转化成不同的列�?
# separate()——它会把一列拆分为多列
# unite()——它的功能和separate相反，把多列合并为一�?
library(tidyr)
names<-c('A','B','C','D','E','A','B')
weight<-c(55,49,76,71,65,44,34)
age<-c(21,20,25,29,33,32,38)
Class<-c('Maths','Science','Social','Physics','Biology','Economics','Accounts')
tdata<-data.frame(names,age,weight,Class)

#using gather function
long_t<-tdata %>% gather(Key,Value,weight:Class)

# 函数separate最适用于有时间变量的数据集�?
# 由于列中包含了很多信息，因此拆分开来并分别使用它们很有必要�?
# 使用以下的代码，把一个列拆分成了日期，月份和年�?
Humidity <- c(37.79, 42.34, 52.16, 44.57, 43.83, 44.59)
Rain <- c(0.971360441, 1.10969716, 1.064475853, 0.953183435, 0.98878849, 0.939676146)
Time <- c("27/01/2015 15:44","23/02/2015 23:24", "31/03/2015 19:15", "20/01/2015 20:52", "23/02/2015 07:46", "31/01/2015 01:55")
d_set<-data.frame(Humidity,Rain,Time)
#using separate function we can separate date, month, year
separate_d <- d_set %>% separate(Time, c('Date', 'Month','Year'))
#using unite function - reverse of separate
unite_d <- separate_d%>% unite(Time, c(Date, Month, Year), sep = "/")
#using spread function - reverse of gather
wide_t <- long_t %>% spread(Key, Value)

#lubridate
# Lubridate包可以减少在R中操作时间变量的痛苦�?
# 此包的内置函数提供了很好的解析日期与时间的便利方法�?
# 这个包常用于包含时间数据的数据集�?
# 在此我展示了Lubridate包中的三个函数�?
# 这三个函数是update，duration和date extraction�?
# 作为一个初学者，了解这三个函数足以让你成为处理时间变量的专家�?
# 尽管R有内置函数来处理日期，这个包的处理方法会更快�?
library(lubridate)
#current date and time
now()
#assigning current date and time to variable n_time
n_time <- now()
#using update function
n_update <- update(n_time, year = 2013, month = 10)

#add days, months, year, seconds
d_time <- now()
d_time + ddays(1)
d_time + dweeks(2)
d_time + dyears(3)
d_time + dhours(2)
d_time + dminutes(50)
d_time + dseconds(60)

#extract date,time
n_time$hour <- hour(now())
n_time$minute <- minute(now())
n_time$second <- second(now())
n_time$month <- month(now())
n_time$year <- year(now())

#check the extracted dates in separate columns
new_data <- data.frame(n_time$hour,
                       n_time$minute, n_time$second,
                       n_time$month, n_time$year)

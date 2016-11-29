library(devtools)
install_github("ramnathv/rCharts@dev")
library(rCharts)
survey<-MASS::survey
hPlot(x ="Wr.Hnd",y ="NW.Hnd",
      data=survey,type = c("scatter"),
      group ="Clap")

hPlot(x = "Wr.Hnd",y = "NW.Hnd",
      data = MASS::survey,type=c("bubble"),
      group="Clap",size ="Age")

hPlot(x ="Wr.Hnd",y ="NW.Hnd",data=MASS::survey,
      type = c("line"),
      group="Clap")

hPlot(x ="Wr.Hnd",y = "NW.Hnd",data=MASS::survey,
      type=c("bar"),group = "Clap")

hPlot(x ="Wr.Hnd",y = "NW.Hnd",data = MASS::survey,
      type = c("column"),group = "Clap")

hPlot(~Clap, data = MASS::survey, type = c("pie"))

hPlot(x="Wr.Hnd",y="NW.Hnd",data=MASS::survey,
      type = c("line","bubble", "scatter"), 
      group = "Clap", size = "Age")
# 热力图，type为heatmap
# 仪表盘, type 为gauge
# 箱线图：type为boxplot
# 瀑布图: type 为waterfall
# 漏斗图: type 为waterfall
# 金字塔图 ： type 为pyramid 此外，highchart还可以画3D图

library(networkD3)
# Create fake data
src <- c("A", "A", "A", "A","B", "B", "C", "C", "D")
target <- c("B", "C", "D", "J","E", "F", "G", "H", "I")
networkData <- data.frame(src, target)
# Plot
simpleNetwork(networkData)

if(!require(devtools)) install.packages("devtools")
#install wordcloud2 from github
devtools::install_github('lchiffon/wordcloud2')
#Data frame included in packages can be used
library(wordcloud2)
wordcloud2(data=demoFreq)
#demoFreq is a data.frame including word and freq in each column.
head(demoFreq)
#Parameters of wordcloud2
# data
# A data frame including word and freq in each column
# size
# Font size, default is 1. The larger size means the bigger word.
# fontFamily
# Font to use.
# fontWeight
# Font weight to use, e.g. normal, bold or 600
# color
# color of the text, keyword ‘random-dark’ and ‘random-light’ can be used. color vector is also supported in this param
# minSize
# A character string of the subtitle
# backgroundColor
# Color of the background.
# gridSize
# Size of the grid in pixels for marking the availability of the canvas the larger the grid size, the bigger the gap between words.
# minRotation
# If the word should rotate, the minimum rotation (in rad) the text should rotate.
# maxRotation
# If the word should rotate, the maximum rotation (in rad) the text should rotate. Set the two value equal to keep all text in one angle.
# rotateRatio
# Probability for the word to rotate. Set the number to 1 to always rotate.
# shape
# The shape of the “cloud” to draw. Can be a keyword present. Available presents are ‘circle’ (default), ‘cardioid’ (apple or heart shape curve, the most known polar equation), ‘diamond’ (alias of square), ‘triangle-forward’, ‘triangle’, ‘pentagon’, and ‘star’.
# ellipticity
# degree of “flatness” of the shape wordcloud2.js should draw.
# figPath
# A fig used for the wordcloud.
# widgetsize
# size of the widgets

#use color and backgroundcolor
wordcloud2(demoFreq, color = "random-light", backgroundColor = "grey")

#use rotations
wordcloud2(demoFreq, minRotation = -pi/6, maxRotation = -pi/6, minSize = 10,
rotateRatio = 1)
#use figure file as a mask
#The picture is in wordclouds packages
figPath = system.file("examples/t.png",package = "wordcloud2")
wordcloud2(demoFreq, figPath = figPath, size = 1.5,color = "skyblue")

# letterCloud function
# letterCloud provide the function to create a wordcloud with a word
# data
# A data frame including word and freq in each column
# word
# A word to create shape for wordcloud.
# wordSize
# Parameter of the size of the word, default is 2.
# letterFont
# Letter font
# ...
# Other parameters for wordcloud2 Go to wordcloud2 in the github 
# to leave a comment or give this package a star.('~')('~')('~')
letterCloud(demoFreq, word = "R", size = 2)
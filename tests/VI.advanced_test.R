library(tidyverse)
library(BrailleR)
library(ggfortify)
library(lfda)
library(ggthemes)

###Test Case 1: Theme interaction with colour, colours sorted by groups.
t1<-ggplot(iris) +
  geom_point(aes(y=Sepal.Width, x=Sepal.Length, col = Species))+
  theme_classic()
t1
VI(t1)

###Test Case 2: Simple interaction with autoplot

df <- iris[c(1, 2, 3)]
t2<-autoplot(prcomp(df))
t2
VI(t2)

###Test Case 3: 'loadings' interaction with autoplot

t3<-autoplot(prcomp(df), data = iris, colour = 'Species',
             loadings = TRUE, loadings.colour = 'blue',
             loadings.label = TRUE, loadings.label.size = 3)
t3
VI(t3)

###Test Case 4: 'frames' interaction with autoplot

model <- lfda(iris[-5], iris[, 5], 4, metric="plain")
t4<-autoplot(model, data = iris, frame = TRUE, frame.colour = 'Species')
VI(t4)
t4

### Test Case 5:basic qplot with theme interaction, small data set and continuous scale

t5<-qplot(hp, mpg, data=mtcars, size=am,
           facets=gear~cyl, main="Scatterplots of MPG vs. Horsepower",
           xlab="Horsepower", ylab="Miles per Gallon")+
  theme_bw()
VI(t5)
t5

### Test Case 6: more complex theme interactions

t6 <- geom_tufteboxplot(median.type = "point", 
                      whisker.type = 'line',
                      hoffset = 0, width = 3)+ 
      theme_economist()
VI(t6)
t6



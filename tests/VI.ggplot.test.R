library(BrailleR)
library(ggplot2)

# Add some factor variables to mtcars
m= within(mtcars,{am = as.factor(ifelse(am,"auto","manual")); cyl = as.factor(cyl)})

# qplot - exercise the various qplot parameters and geoms
VI(qplot(data=m, disp,mpg, facets=.~am, margins=TRUE, 
          geom=c("point","smooth"), main="Cars, cars, cars", xlab="displacement", 
          ylab="Miles per gallon", log="y", xlim=c(90,450)))

VI(qplot(data=m, cyl, mpg, geom="boxplot",main="mpg by cyl"))

VI(qplot(data=economics[1:8,], date, unemploy, geom="line"))

# Add a horizontal line
VI(qplot(data=economics[1:20,], x=date, y=unemploy, geom="line") + 
  geom_hline(yintercept=3000, col="blue"))

# Set some constant aesthetics
VI(qplot(data=m, disp, mpg, shape=I("x"), size=I(5), alpha=I(0.3)))

# With some variable aesthetics
VI(qplot(data=m[1:10,], disp, mpg, mapping=aes(shape=am,size=hp)))

# Categorical axis with not all categories in all facets
VI(qplot(data=m, cyl, mpg) + facet_grid(.~round(disp/100), scales = "free"))
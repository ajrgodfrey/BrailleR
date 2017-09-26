library(BrailleR)
library(ggplot2)

# Add some factor variables to mtcars
m= within(mtcars,{am = as.factor(ifelse(am,"auto","manual")); cyl = as.factor(cyl)})

# qplot - exercise the various qplot parameters and geoms
# points, smoothing, log-transform, xlim
VI(qplot(data=m, disp,mpg, facets=.~am, margins=TRUE, 
          geom=c("point","smooth"), main="Cars, cars, cars", xlab="displacement", 
          ylab="Miles per gallon", log="y", xlim=c(90,450)))

# boxplot, title, subtitle & caption
VI(qplot(data=m, cyl, mpg, geom="boxplot") + 
     labs(title = "MPG by cyl",subtitle="for mtcars dataset",caption="some caption here"))

# line, no annotation
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

# Faceted histogram
VI(qplot(data=m, mpg, facets=.~cyl))

# Test all aesthetics for all supported plot types
# Note: These charts don't necessarily make sense, and some look disgusting.
# They're just to test printing all the aesthetic information
### Points
VI(qplot(data=m[1:10,], mpg, disp, alpha=cyl, colour=mpg, fill=mpg, shape=I(20), size=disp))
### Histogram
VI(qplot(data=m[1:10,], mpg, geom="histogram", bins=5, alpha=am, colour=am, fill=am,
         linetype=am, size=am))
### Boxplots
VI(qplot(data=m, cyl, mpg, geom="boxplot", alpha=am, colour=am, fill=am, linetype=am, size=am))
### Hline
VI(qplot(data=m[1:10,], geom="hline", mapping=aes(yintercept=mpg, alpha=am, colour=am,
         linetype=am, size=am)))
### Line
VI(qplot(data=m[1:10,], geom="line", disp, mpg, alpha=am, colour=am, linetype=am, size=am))

# Test all graph types when number of items exceeds threshold, so no detail printed
VI(qplot(data=m, mpg, disp, geom="point"))
VI(qplot(data=m, mpg, disp, geom="line"))
VI(qplot(data=m, as.factor(mpg), disp, geom="boxplot"))
VI(qplot(data=m, mpg, geom="histogram"))
VI(qplot(data=m, mapping=aes(yintercept=mpg), geom="hline"))
VI(qplot(data=m, mpg, disp, geom="smooth"))


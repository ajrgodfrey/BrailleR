# Exploring Graphs

*Problem*  
Much of statistics course work in your first year will revolve around
making and interpreting graphs. Now for a sighted user R and R studio
with ggplot2 etc it is quite a straight forward procedure. However
without the use of sight this becomes a challenge.

*Solution*  
In BrailleR there are three avenues that can be taken to fix this they
are: [Describe](#describe) is for learning, [VI](#vi) is about getting
quick information and [SVG Plots](#svg-plots) are for a detailed dive
into a plot. Each of these are designed to serve the user and give them
potential to ‘view’ the information a graph has to offer.

*Note*  
All of the code below is run after these ‘setup’ functions

``` r
library(ggplot2)
library(BrailleR)
```

## Describe

This function will take a graph object and give you the non contextual
information about the graph layers.

It is designed as a learning tool to help you understand what a
particular graph is trying to show you. It also provides applicable
information about how this graph type works in ggplot.

An example of this would be something like this

``` r
basicPlot <- ggplot(iris, aes(Sepal.Length, Sepal.Width)) +
  geom_point()

Describe(basicPlot)
```

    ## A geom_point layer created with the ggplot2 framework
    ## 
    ## General Description:
    ## A scatter plot shows the relationship between two variables by plotting a symbol for each observation at the coordinates for the two variables.
    ## 
    ## R hints:
    ## A geom_point by default will by closed black dots. This can be changed with the `shape` parameter, while the size and colour can be changed with the `size` and `colour` parameter. These can be set to categorical variable to visually distinguish the groups

As can be seen there is a title a general description and then some r
hints. This structure is the same for all Describe output expect for
when using it in
[`MakeAccessibleSVG()`](http://ajrgodfrey.github.io/BrailleR/reference/MakeAccessibleSVGMethod.md).
However more can be found about that here: [How to use](#how-to-use)

### Multiple layers

If you have multiple layers in the plot it will default to asking you
what layers you want.

You can always tell it which layer to describe by giving the layer
number or vector of numbers to the `whichLayer` argument. However more
about this can be read in the function documentation.

## VI

This function can be thought of as a text ‘Visual Inspection’ of the
graph. It has enough information that you might be able to draw some
conclusions however it mostly will tell you about the layout of the
graph. This function can also be used to investigate non graph objects
like lm and aov etc. Only the graph application will be discussed here.

### ggplot

There is full support here for many layers as well as faceted displays
(multiple plots in one graph object).

For every graph there will be a few lines at the start telling you the
title subtitle what the axes are and there tick marks. This is the same
across all of the graph printouts. It is the individual layer sections
can be quite different.

The VI function is built into the print function for ggplot objects.
This means anytime you have BrailleR loaded and try to display a ggplot
it will give you the text output.

This effect can be seen below

``` r
basicPlot <- ggplot(iris, aes(Sepal.Length, Sepal.Width)) +
  geom_point()

basicPlot
```

![](ExploringGraphs_files/figure-html/VI%20implicit%20call-1.png)

    ## This is an untitled chart with no subtitle or caption.
    ## It has x-axis '' with labels 5, 6, 7 and 8.
    ## It has y-axis '' with labels 2.0, 2.5, 3.0, 3.5, 4.0 and 4.5.
    ## The chart is a set of 150 big solid circle points of which about 78% can be seen.

However you can also easily call it explicitly without having to print
the graph.

``` r
VI(basicPlot)
```

    ## This is an untitled chart with no subtitle or caption.
    ## It has x-axis '' with labels 5, 6, 7 and 8.
    ## It has y-axis '' with labels 2.0, 2.5, 3.0, 3.5, 4.0 and 4.5.
    ## The chart is a set of 150 big solid circle points of which about 78% can be seen.

Below is not only a list of the supported Geom but also a little
explanation about there printouts.

#### GeomHLine

``` r
hline <- ggplot(mtcars, aes(mpg, cyl)) +
  geom_hline(yintercept = 5)
hline
```

    ## This is an untitled chart with no subtitle or caption.
    ## There is no x-axis.
    ## It has y-axis '' with labels 4.950, 4.975, 5.000, 5.025 and 5.050.
    ## The chart is 1 horizontal line as follows:
    ## Line at y position 5.

As this is quite a simple geom it is quite a simple printout.

It will tell you how many lines and at what height they are at.

#### GeomPoint

``` r
point <- ggplot(mtcars, aes(mpg, cyl)) +
  geom_point()
point
```

    ## This is an untitled chart with no subtitle or caption.
    ## It has x-axis '' with labels 10, 15, 20, 25, 30 and 35.
    ## It has y-axis '' with labels 4, 5, 6, 7 and 8.
    ## The chart is a set of 32 big solid circle points of which about 81% can be seen.

Information will include here the number of points and the shape. There
is also a percentage of approximately how many points can be seen. This
is used to help you understand the over plotting. This is only effective
for when the points sizes are not too big (size \< 18). Don’t worry it
will only show you the percentage if it is accurate.

#### GeomBar / GeomCol

``` r
bar <- ggplot(mtcars, aes(mpg)) +
  geom_histogram()
bar
```

    ## `stat_bin()` using `bins = 30`. Pick better value `binwidth`.

    ## This is an untitled chart with no subtitle or caption.
    ## It has x-axis '' with labels 10, 15, 20, 25, 30 and 35.
    ## It has y-axis '' with labels 0, 1, 2, 3 and 4.
    ## The chart is a bar chart with 30 vertical bars.

Even though there is a geom_histogram, geom_bar and geom_col in the
backend of ggplot it is the same. So for the VI they are treated all
pretty much the same.

There will be information just on the number of bars displayed.

#### GeomLine

``` r
line <- ggplot(mtcars, aes(mpg, wt)) +
  geom_line()
line
```

    ## This is an untitled chart with no subtitle or caption.
    ## It has x-axis '' with labels 10, 15, 20, 25, 30 and 35.
    ## It has y-axis '' with labels 2, 3, 4 and 5.
    ## The chart is a set of 1 line.
    ## Line 1 connects 32 points.

Very similar to the hline it will tell you about how many lines there
are. Then for each line it will tell you the number of points that make
up the line.

#### GeomBoxplot

``` r
boxplot <- ggplot(mtcars, aes(mpg, as.factor(cyl))) +
  geom_boxplot()
boxplot
```

    ## This is an untitled chart with no subtitle or caption.
    ## It has x-axis '' with labels 10, 15, 20, 25, 30 and 35.
    ## It has y-axis '' with labels 4, 6 and 8.
    ## The chart is a boxplot comprised of 3 horizontal boxes with whiskers.
    ## There is a box at y=1.
    ## It has median NA. The box goes from NA to NA, and the whiskers extend to 21.4 and 33.9.
    ## There are 0 outliers for this boxplot.
    ## There is a box at y=2.
    ## It has median NA. The box goes from NA to NA, and the whiskers extend to 17.8 and 21.4.
    ## There are 0 outliers for this boxplot.
    ## There is a box at y=3.
    ## It has median NA. The box goes from NA to NA, and the whiskers extend to 13.3 and 18.7.
    ## There are 1 max and 2 min outliers for this boxplot.

As a boxplot is effectively a 5 number summary with outliers this
printout will include all of that information.

It shall include this summary for each boxplot in the layer.

#### GeomSmooth

``` r
smooth <- ggplot(mtcars, aes(mpg, wt)) +
  geom_smooth()
smooth
```

    ## `geom_smooth()` using method = 'loess' and formula = 'y ~ x'

    ## This is an untitled chart with no subtitle or caption.
    ## It has x-axis '' with labels 10, 15, 20, 25, 30 and 35.
    ## It has y-axis '' with labels 1, 2, 3, 4, 5 and 6.
    ## The chart is a 'lowess' smoothed curve with 95% confidence intervals covering 15% of the graph.

This output tell you the method used to get the smoothed curve and the
confidence interval level which is set.  
It also tells you what percentage of the graph is covered by the CI.
This information can be used to quickly gauge how confident the graph is

#### GeomRibbon / GeomArea

``` r
ribbon <- ggplot(diamonds, aes(x = carat, y = price)) +
  geom_area(aes(y = price))
ribbon
```

    ## This is an untitled chart with no subtitle or caption.
    ## It has x-axis '' with labels 0, 1, 2, 3, 4 and 5.
    ## It has y-axis '' with labels 0.0e+00, 4.0e+06, 8.0e+06 and 1.2e+07.
    ## The chart is a ribbon which is bound on the y axis, with non constant widths: 367, 807, 2593, 6814 and 18531 with centers at: 528.5, 275880, 4469320, 1824600 and 9265.5. The ribbon takes up 0.11% of the graph.

Once again this layer gives you some information about the layers data.
It will tell you whether it is bound on the y or x axis and then if it
is constant or non constant width. For it to be bound on the y axis
means that it covers the whole range of x and vice versa for y.

It includes some widths and centers throughout 5 points in the layer.
The width will either be bottom to top for y bound or left to right for
x bound.

It also includes the area covered statistic found in the smooth layer.

#### GeomBlank

``` r
blank <- ggplot(BOD, aes(x = demand, y = Time)) +
  geom_line() +
  expand_limits(x = c(15, 23, 6), y = c(30))
blank
```

    ## This is an untitled chart with no subtitle or caption.
    ## It has x-axis '' with labels 10, 15 and 20.
    ## It has y-axis '' with labels 0, 10, 20 and 30.
    ## It has 2 layers.
    ## Layer 1 is a set of 1 line.
    ## Line 1 connects 6 points, at (8.3, 1), (10.3, 2), (15.6, 5), (16, 4), (19, 3) and (19.8, 7).
    ## Layer 2 is a expand limits, increasing x axis by 48%, and increasing y axis by 383%.

GeomBlank is made by the expand_limits function. It is a normal layer
like all the others however it just doesn’t have any points to be
displayed.

So what this VI does is explain the effect that this layer had on the
limits. It shall tell you how much larger the x and y axis are.

### Base

Base R graphics support is kept in here and does work to some extant.
However it should be considered deprecated and replaced by the ggplot
graphics.

There is support for the base plots:

- Boxplot
- Dotplot
- Histogram

## SVG Plots

SVG plots in BrailleR are used create webpages that a user can explore
by using arrow keys and some basic navigation buttons.

The
[`MakeAccessibleSVG()`](http://ajrgodfrey.github.io/BrailleR/reference/MakeAccessibleSVGMethod.md)
function is the easiest way to do this. You simply pass it a graph
object and it will create the webpage and load it for you in your
default browser.

The functions that
[`MakeAccessibleSVG()`](http://ajrgodfrey.github.io/BrailleR/reference/MakeAccessibleSVGMethod.md)
uses to create SVGs are
[`SVGThis()`](http://ajrgodfrey.github.io/BrailleR/reference/SVGThis.md),
[`AddXML()`](http://ajrgodfrey.github.io/BrailleR/reference/AddXMLMethod.md)
and
[`BrowseSVG()`](http://ajrgodfrey.github.io/BrailleR/reference/BrowseSVG.md).
These are available to use but really shouldn’t be needed.

There is one last function
[`ViewSVG()`](http://ajrgodfrey.github.io/BrailleR/reference/ViewSVG.md).
This will bring up a webpage that has a list and links of all of the svg
webpages available in the current working directory.

Below is the code used to make the example

``` r
plot.example = ggplot(mtcars, aes(wt, mpg)) +
  geom_point() +
  geom_smooth()
MakeAccessibleSVG(plot.example)
```

[example SVG
webpage](http://ajrgodfrey.github.io/BrailleR/rawHTML/plot.example-SVG.md)

### How to use

Using the function is as simple as passing a graph object to
[`MakeAccessibleSVG()`](http://ajrgodfrey.github.io/BrailleR/reference/MakeAccessibleSVGMethod.md)
like this:

``` r
simplePlot = ggplot(mtcars, aes(mpg, wt)) +
  geom_point()
  
MakeAccessibleSVG(simplePlot)
```

On completion of the function it will open the webpage in your default
web browser.

On the webpage there are 4 sections.

1.  The graph
2.  VI output
3.  List of keys to help explore graph
4.  Describe output.

The VI and Describe output is simply there as convenience.

The VI will look exactly the same as the output to console.

However the describe will look slightly different with that first title
line being changed to just the geom type header. This should help with
it being navigable on the webpage.

#### Graph structure

I will explain a little bit about the structure of the graph and how you
can explore it. The explanations will speak of trees, sub trees,
parents, children and nodes. Hopefully you are familiar with what these
words mean in this context. A quick summary is to think of a family
tree. The root is Adam and Eve. Each of there descendant have there
subtrees. Your parents are the final subtree for your branch and you and
your siblings are all children nodes (assuming you don’t have kids yet).
Every person is a node.

For these accessible svgs the graph is the root. Each section has its
own sub tree. The order of subtrees goes:

1.  title (if present)
2.  x axis
3.  y axis
4.  first ggplot layer
5.  second ggplot layer
6.  etc…

There can be an arbitrary number of ggplot layers. These are just added
in line

#### How to navigate

Navigation around the graph should be somewhat intuitive.

Up arrow to go to you parent.  
Down arrow to go to first child.  
Left and right to go to your siblings.

Other useful keys are:

**X** which will enable the descriptive mode. This simply means you can
get more / different information at any particular node you are at. Note
that not all nodes will have this extra information so don’t be worry if
it doesn’t do anything.  
**A** This activate keyboard exploration so once you have focuses on the
SVG you press A and then are good to with exploring using the arrow
keys.

### ggplot

All of the readouts of plots numbers will be formatted and rounded to
help make it easier to read.

Less geoms are supported as SVGs than are supported by VI. This is
mostly because they have not yet been developed.

In general there will be no more than 5 children nodes to the geom tree.
You might be able to go into each child node of the geom to see more
information or there could be a summary of the section at each child
node.

Below is geom specific information

#### Geom_line

For this layer there we be sub trees for each line.

Within each individual line subtree if the line is disjoint there will
be more subtrees for each continuous section of the line. Once you are
looking at either the continuous section or the whole section you can
click through to actually look at the line.

If there are more than 5 lines then it will summarizes them. If there
are 5 or less then you can press through and individually see the line
start and finish locations.

#### Geom_Point

Geom points is a lot simpler.  
Depending on the number of points the information the children have will
be different. If there are more than 5 points it will display a summary
of the points. If there are 5 or less points you will get a summary of
each individual point.

It is worth noting that due to current technical difficulties the points
will not be highlighted at all. More information can be found at [Github
issue](https://github.com/ajrgodfrey/BrailleR/issues/90)

#### Geom_Bar

This geom is also quite simple. There will be a children node for each
of the bars in the plot.

There is some slight differences between the histograms and the bar
charts. For continuous x axis graphs you get information about the width
of the bar its height and the density. For categorical you will simple
get the the location on x axis and the value on the y axis.

There is no summary as of this moment regardless of how many bars are in
the plot.

#### Geom_Smooth

For the smoother the graph will be split into 5 sections no matter how
few underlying data points there are. This means there are 5 children to
the geoms node.

Each child will either have one or two children. The first child will be
the line and the second child would be the confidence interval if it is
present in the graph (This is determined by the `se` argument in
[`geom_smooth()`](https://ggplot2.tidyverse.org/reference/geom_smooth.html))  
You can however see simple information about the line and confidence
interval from the section nodes description.

### Base R

Like with VI there is some support for base r graphics however all of
this support could be considered deprecated.

These are:

- Dotplot
- Boxplot
- Scatterplot
- Histogram
- Tsplot


## The BrailleR package is a collection of tools to make use of R a happier experience for blind people.


### Blind people's use of R

Blind people cannot use RStudio and depending on the combination of operating system and screen reading software we choose to use, we might have differing levels of success with the standard R GUI.

R is perhaps the most blind-friendly statistical software option because all scripts are written in plain text, using the text editor a user prefers, and all output can be saved in a wide range of file formats. The advent of R markdown and other reproducible research techniques can offer the blind user a degree of efficiency that is not offered in many other statistical software options.


###  Specific objectives of BrailleR

1. Make accessing output simpler.
2. Gain access to the content depicted in a graph.
3. Help get into R markdown easier.
5. Replace the tasks other users can do quickly using the RStudio IDE.

### You can help

Any assistance to fill in the numerous gaps in what BrailleR delivers will be most gratefully received. As the primary developer of this package is himself blind, attempts to find out if the tools being created actually do replace visual elements or tasks requires a sighted person to sit alongside to offer commentary.


### Wish list

Some issues to resolve:

1. storing the graphical parameters in ScatterPlot() etc. does not necessarily get the right ones slected. Need to replace this by somehow keeping the ... arguments supplied by the user. Tested using col and pch in FittedLinePlot()
2. Get extra bits of information for WTF() coming through, such as other shapes, lines etc.
1. get VI.ggplot() doing more; see vignette
2. ascertain which shiny app widgets are useful for blind users' screen reading software.
3. link various plot objects to sonify package.
2. get more graphics ready for making into SVG for use on Tiger products; mostly in SVGThis() method
3. Get more Graph types working with the additional XML to make them interactive.
1. fix background of all code chunks in slides being made. This is probably an issue in the css file.
2. get graph files named properly by TwoFactors(); including  boxplots etc vs each factor not both.
3. In OneFactor() and TwoFactors(): ensure that boxplots are created for each factor unless a level is short of reps.
4. WTF() doesn't pick up multiple outliers in boxplot() as more than one point
6. fix VI.lm to cater for the weighted lm case.
4. check the css is working for VI.lm()
5. work out how to change colours in R console for low vision users
6. create function to re-create vignettes from Rnw source into HTML
5. Multiple language support was started but is in serious need of some love.
7. Functions for the VI method to be completed include: VI.prcomp(), VI.factanal(), VI.glm(), VI.htest()?
4. add functionality to compile all Rmd files in the current directory. Request from JYS



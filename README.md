# The BrailleR package is a collection of tools to make use of R a happier experience for blind people.



BrailleR version numbers are of the form a.b.c, where a is the major version b is the minor version, and c is the pactch version. From July 2023, the version number starts with a 1 because development over ten years means we believe the package delivers on the original aims of the BrailleR Project. The minor version is odd for development and even for CRAN releases. Patch version increments just help track progress.

The BrailleR package does have dependencies, all of which are available on CRAN. 
<!-- badges: start -->
[![Dependencies](https://tinyverse.netlify.com/badge/BrailleR)](https://cran.r-project.org/package=BrailleR)

[![Github version](https://img.shields.io/badge/devel%20version-0.32.1-blue.svg)](https://github.com/ajrgodfrey/BrailleR)

[![Last commit badge](https://img.shields.io/github/last-commit/ajrgodfrey/BrailleR.svg)](https://github.com/ajrgodfrey/BrailleR/commits/blue)

[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/BrailleR)](https://cran.r-project.org/package=BrailleR)  

[![CRAN checks](https://cranchecks.info/badges/summary/BrailleR)](https://cran.r-project.org/web/checks/check_results_BrailleR.html)

[![Downloads per month](http://cranlogs.r-pkg.org/badges/last-month/BrailleR?color=green)](https://cran.r-project.org/package=BrailleR)

[![Release version](https://www.r-pkg.org/badges/version/BrailleR?color=black)](https://cran.r-project.org/package=BrailleR)

[![R build status](https://github.com/ajrgodfrey/BrailleR/workflows/R-CMD-check/badge.svg)](https://github.com/ajrgodfrey/BrailleR/actions)
<!-- badges: end -->

### Blind people's use of R

Blind people cannot use RStudio and depending on the combination of operating system and screen reading software we choose to use, we might have differing levels of success with the standard R GUI.

R is perhaps the most blind-friendly statistical software option because all scripts can be written in plain text, using the text editor a user prefers, and all output can be saved in a wide range of file formats. The advent of R markdown and other reproducible research techniques can offer the blind user a degree of efficiency that is not offered in many other statistical software options. In addition, the processed Rmd files are usually HTML which are the best supported files in terms of screen reader development.


###  Specific objectives of BrailleR

1. Make accessing output simpler.
2. Gain access to the content depicted in a graph.
3. Make it easier for blind users to create their own R markdown documents.
5. Replace the tasks other users can do quickly using the RStudio IDE.

If these criteria are all met, then the `BrailleR` package can support blind people through their first courses in statistics, and perhaps/hopefully into second or third courses.

### Installation of BrailleR

Use the following commands if using the CRAN version of BrailleR:

```
chooseCRANmirror(ind=1)
install.packages("BrailleR")
```

Or, if the CRAN version is not recent enough or your liking:


```
chooseCRANmirror(ind=1)
install.packages("remotes")
remotes::install_github("ajrgodfrey/BrailleR", upgrade=TRUE, quiet=TRUE)
```

### You can help

Any assistance to fill in the numerous gaps in what BrailleR delivers will be most gratefully received. As the primary developer of this package is himself blind, attempts to find out if the tools being created actually do replace visual elements or tasks requires a sighted person to sit alongside to offer commentary.

### Code of Conduct

Please note that this project is released with a [Contributor Code of Conduct.](CONDUCT.md)
By participating in the BrailleR Project, you are agreeing to this code of conduct. Please check you agree with its terms before participating.

### Wish list

Some issues to resolve:

1. Get extra bits of information for WTF() coming through, such as other shapes, lines etc.
2. ascertain which shiny app widgets are useful for blind users' screen reading software.
3. link various plot objects to sonify package.
2. get more graphics ready for making into SVG for use on Tiger products; mostly in SVGThis() method
3. Get more Graph types working with the additional XML to make them interactive.
2. get graph files named properly by TwoFactors(); including  boxplots etc vs each factor not both.
3. In OneFactor() and TwoFactors(): ensure that boxplots are created for each factor unless a level is short of reps.
4. WTF() doesn't pick up multiple outliers in boxplot() as more than one point
6. fix VI.lm to cater for the weighted lm case.
4. check the css is working for VI.lm()
5. work out how to change colours in R console for low vision users as commands and/or settings 
6. create function to re-create vignettes from Rnw source into HTML
5. Multiple language support was started but is in serious need of some love.
7. Functions for the VI method to be completed include: VI.prcomp(), VI.factanal(), VI.glm(), VI.htest()?




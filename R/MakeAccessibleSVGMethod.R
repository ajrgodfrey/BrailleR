
MakeAccessibleSVG <- function(x, file = paste0(deparse(substitute(x)), "-SVG"), view = interactive(), cleanup = TRUE, ...) {
  UseMethod("MakeAccessibleSVG")
}

MakeAccessibleSVG.default <-
  function(x, file = paste0(deparse(substitute(x)), "-SVG"), view = interactive(), cleanup = TRUE, ...) {
    svgfile <- SVGThis(x, paste0(file, ".svg"))
    xmlfile <- AddXML(x, paste0(file, ".xml"))
    BrowseSVG(file = file, view = view, ...)
    .SVGAndXMLMade()
    if (cleanup) {
      unlink(paste0(file, ".xml"))
      unlink(paste0(file, ".svg"))
    }
    return(invisible(NULL))
  }

MakeAccessibleSVG.histogram <- MakeAccessibleSVG.scatterplot <- MakeAccessibleSVG.default

MakeAccessibleSVG.tsplot <-
  function(x, file = paste0(deparse(substitute(x)), "-SVG"), view = interactive(), cleanup = TRUE, ...) {
    svgfile <- SVGThis(x, paste0(file, ".svg"))
    if (x$Continuous) {
      .RewriteSVG.tsplot(x, paste0(file, ".svg"))
    }
    xmlfile <- AddXML(x, paste0(file, ".xml"))
    BrowseSVG(file = file, view = view, ...)
    .SVGAndXMLMade()
    if (cleanup) {
      unlink(paste0(file, ".xml"))
      unlink(paste0(file, ".svg"))
    }
    return(invisible(NULL))
  }

MakeAccessibleSVG.ggplot <-
  function(x, file = paste0(deparse(substitute(x)), "-SVG"), view = interactive(), cleanup = TRUE, VI_and_Describe = TRUE, ...) {
    pdf(NULL) # create non-displaying graphics device for SVGThis and AddXML
    svgfile <- SVGThis(x, paste0(file, ".svg"), createDevice = FALSE)
    xmlfile <- AddXML(x, paste0(file, ".xml"))
    dev.off() # destroy graphics device, now that we're done with it

    if (VI_and_Describe) {
      BrowseSVG(file = file, view = view, ggplot_object = x, ...)
    } else {
      BrowseSVG(file = file, view = view, ...)
    }


    .SVGAndXMLMade()

    if (cleanup) {
      unlink(paste0(file, ".xml"))
      unlink(paste0(file, ".svg"))
    }
    return(invisible(NULL))
  }

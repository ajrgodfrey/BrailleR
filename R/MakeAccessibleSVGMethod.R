
MakeAccessibleSVG = function(x, file = "test", view=interactive(), ...) {
            UseMethod("MakeAccessibleSVG")
          }

MakeAccessibleSVG.default =
    function(x, file = "test", view=interactive(), ...) {
      svgfile = SVGThis(x, paste0(file, ".svg"))
      xmlfile = AddXML(x, paste0(file, ".xml"))
      if (view) {
          BrowseSVG(file=file, view=view, ...)
      }
      message("SVG and XML files created successfully")
      return(invisible(NULL))
}

MakeAccessibleSVG.histogram = MakeAccessibleSVG.scatterplot =
    function(x, file = "test", view=interactive(), ...) {
      svgfile = SVGThis(x, paste0(file, ".svg"))
      xmlfile = AddXML(x, paste0(file, ".xml"))
      if (view) {
          BrowseSVG(file=file, view=view, ...)
      }
      message("SVG and XML files created successfully")
      return(invisible(NULL))
}

MakeAccessibleSVG.tsplot =
    function(x, file = "test", view=interactive(), ...) {
      svgfile = SVGThis(x, paste0(file, ".svg"))
      if (x$Continuous) {
        .RewriteSVG.tsplot(x, paste0(file, ".svg"))
      }
      xmlfile = AddXML(x, paste0(file, ".xml"))
      if (view) {
          BrowseSVG(file=file, view=view, ...)
      }
      message("SVG and XML files created successfully")
      return(invisible(NULL))
}

MakeAccessibleSVG.ggplot =
    function(x, file = "test", view=interactive(), ...) {
      pdf(NULL)  # create non-displaying graphics device for SVGThis
      svgfile = SVGThis(x, paste0(file, ".svg"),createDevice=FALSE)
      xmlfile = AddXML(x, paste0(file, ".xml"))  # needs device to do grid.grep()
      dev.off()  # destroy graphics device, now that we're done with it
      
      if (view) {
        BrowseSVG(file=file, view=view, ...)
      }
      message("SVG and XML files created successfully")
      return(invisible(NULL))
}
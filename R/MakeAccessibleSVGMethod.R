
MakeAccessibleSVG = function(x, file = "test") {
            UseMethod("MakeAccessibleSVG")
          }

MakeAccessibleSVG.default =
    function(x, file = "test") {
      svgfile = SVGThis(x, paste0(file, ".svg"))
      xmlfile = AddXML(x, paste0(file, ".xml"))
      message("SVG and XML files created successfully")
      return(invisible(NULL))
}

MakeAccessibleSVG.histogram =
    function(x, file = "test") {
      svgfile = SVGThis(x, paste0(file, ".svg"))
      xmlfile = AddXML(x, paste0(file, ".xml"))
      message("SVG and XML files created successfully")
      return(invisible(NULL))
}

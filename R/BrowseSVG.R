# Currently only supports working the current directory.
BrowseSVG = function(file="test", key=TRUE, footer=TRUE, view=interactive()) {
  # Required file for correct execution
  xmlFileName = paste0(file, ".xml")
  svgFileName = paste0(file, ".svg")
  
  if (!(file.exists(xmlFileName) && file.exists(svgFileName))) {
    warning("You do not have both a svg and xml file in current wd. Please create these with SVGThis()/AddXML() or use MakeAccessibleSVG()")
    return(invisible())
  }
  
  # Read and clean xml file
  xmlString = xmlFileName |>
    readLines() |>
    gsub("sre:", "", x=_) |>
    gsub(" *<[a-zA-Z]+/>", "", x=_)
  
  # Read svg file
  svgString = svgFileName |>
    readLines()
  
  
  # Whiskers prep and rendering
  data = list(xml = xmlString,
              svg = svgString,
              footer = footer,
              key = key,
              title = file)
  
  htmlTemplate = system.file("whisker/SVG/template.html", package = "BrailleR") |>
    readLines()
  
  renderedText = whisker.render(htmlTemplate, data = data) |>
    #Remove odd commas added by the rendering. Not sure why they are there.
    gsub("(> *)(,)( *<)", "\\1\\3", x = _)
  
  # Write the rendered text to html file
  fileName = paste0(file, ".html")
  writeLines(renderedText, con = paste0(file, ".html"))
  close(file(fileName))
  
  if (view) {
    browseURL(fileName)
  }
}
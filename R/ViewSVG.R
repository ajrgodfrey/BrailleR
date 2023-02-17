#TODO add support for using an arbitary directory
ViewSVG = function(file = "index"){
  # Getting links
  svgHTMLFiles = .GetSVGLinks()
  
  # Get data and render whisker template
  data = list(
    files = svgHTMLFiles
  )
  
  htmlTemplate = system.file("whisker/SVG/ViewSVG.html", package = "BrailleR") |>
    readLines()
  
  renderedText = whisker.render(htmlTemplate, data = data)
  
  # Write rendered html to file
  fileName = paste0(file, ".html")
  writeLines(renderedText, con = fileName)
  close(file(fileName))
  
  
  if(interactive()){
    browseURL(fileName) 
  }
  
  return(invisible(NULL))
}

.GetSVGLinks = function() {
  htmlFiles = list.files(pattern = ".html")
  svgHTMLFiles = list()
  for (file in htmlFiles) {
    # Search file to see if it is a svg html file.
    # This should always get it right as it is from the template file
    # It will need to be updated if the template file is updated.
    searchResult = readLines(file) |>
      grep('<div class="svg">', x = _, Value = TRUE)
    if(length(searchResult) >= 1) {
      svgHTMLFiles[[length(svgHTMLFiles) + 1]] = list(file=file)
    }
  }
  svgHTMLFiles
}

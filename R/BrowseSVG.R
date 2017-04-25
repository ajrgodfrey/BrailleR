# note that the only directory this is currently implemented for is the current working directory.

BrowseSVG = function(file="test", dir=".", key=TRUE) {
  if (!interactive()) {
    return(invisible(NULL))    
  }
  xmlString <- .CleanXml(file=file, dir=dir)
  svgFile <- paste0(file, ".svg")
  svgString <- readChar(svgFile, file.info(svgFile)$size)
  htmlFile <- paste0(file, ".html")
  .AddHeader(file=htmlFile, dir=dir)
  .WriteContainer(svgString, xmlString, file=htmlFile, dir=dir)
  if (key) {
    .AddKey(file=htmlFile, dir=dir)
  }
  .AddFooter(file=htmlFile, dir=dir)
  browseURL(htmlFile) 
  return(invisible(NULL))
}


.CleanXml = function(file="test", dir=".") {
  fileName <- paste0(file, ".xml")
  xmlString <- readChar(fileName, file.info(fileName)$size)
  xmlString <- gsub("sre:", "", xmlString)
  gsub(" *<[a-zA-Z]+/>\n", "", xmlString)
}


.WriteContainer = function(svg, xml, file="test.html", dir=".") {
  cat('
    <div class="container">
      <div class="content">
        <div class="ChemAccess-element" id="mole1" tabindex="0" role="application">',
    file=file, append=TRUE)
  .WriteSVG(svg, file=file, dir=dir)
  .WriteXML(xml, file=file, dir=dir)
  cat('
        </div>
      </div>
    </div>',
    file=file, append=TRUE)
}


.WriteSVG = function(svg, file="test.html", dir=".") {
  cat('          <div class="svg">\n', file=file, append=TRUE)
  cat(svg, file=file, append=TRUE)
  ## writeLines(svg, con=file)
  cat('          </div>\n', file=file, append=TRUE)
}


##vs Adapt class in both cacc and here.
.WriteXML = function(xml, file="test.html", dir=".") {
  cat('          <div class="cml">\n', file=file, append=TRUE)
  cat(xml, file=file, append=TRUE)
  ## writeLines(xml, con=file)
  cat('          </div>\n', file=file, append=TRUE)
}


##vs Currently minimalistic!
.AddHeader = function(file="test.html", dir=".") {
  cat('<html>
  <head><title>Accessible Statistics</title></head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script type="text/javascript" src="https://code.jquery.com/jquery-2.1.4.min.js" defer></script>
    <script type="text/javascript" src="cacc.js" defer></script>
    <script type="text/javascript" defer>
          document.addEventListener("DOMContentLoaded", function() {
            cacc.Base.getInstance().init();
          });
    </script>
  </head>
  <body>',
  file=file)
}


.AddKey = function(file="test.html", dir=".") {
  cat('        <p>Tab to or mouseclick on the diagram and use the following keys for
        interactive exploration:</p>
        <table>
        <tr><th>Key:</th><th></th></tr>
        <tr><td>A</td><td>Activate keyboard driven exploration</td></tr>
        <tr><td>B</td><td>Activate menu driven exploration</td></tr>
        <tr><td>Escape</td><td>Leave exploration mode</td></tr>
        <tr><td>&emsp;</td></tr>
        <tr><td>Cursor down</td><td>Explore next lower level</td></tr>
        <tr><td>Cursor up</td><td>Explore next upper level</td></tr>
        <tr><td>Cursor right</td><td>Explore next element on level</td></tr>
        <tr><td>Cursor left</td><td>Explore previous element on level</td></tr>
        <tr><td>&emsp;</td></tr>
        <tr><td>X</td><td>Toggle description mode</td></tr>
        <tr><td>M</td><td>De/activate direct magnification</td></tr>
        <tr><td>N</td><td>De/activate stepwise magnification</td></tr>
        <tr><td>S</td><td>Toggle subtitles</td></tr>
        <tr><td>C</td><td>Cycle contrast settings</td></tr>
        <tr><td>T</td><td>Monochrome colours</td></tr>
        <tr><td>L</td><td>Toggle language (if available)</td></tr>
        </table>\n', 
      file=file, append=TRUE)
}


.AddFooter = function(file="test.html", dir=".") {
  cat('        <div class="footer">
        <p style="text-align: center; font-size: 10px;">&copy; Progressive Accessibility Solutions 2017</p>
      </div>
  </body>
</html>',
file=file, append=TRUE)
}



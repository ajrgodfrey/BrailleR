
BrowseSVG = function(file="test", dir=".", key=TRUE, view=interactive()) {
  xmlString <- .CleanXml(file=file, dir=dir)
  svgFile <- paste0(file, ".svg")
  svgString <- readLines(svgFile)
  htmlFile <- paste0(file, ".html")
  .AddHeader2HTML(file=htmlFile, dir=dir)
  .AddContainer2HTML(svgString, xmlString, file=htmlFile, dir=dir)
  if (key) {
    .AddKey2HTML(file=htmlFile, dir=dir)
  }
  .AddFooter2HTML(file=htmlFile, dir=dir)
    .CopyLibrary(dir=dir)
  if (view) {
    browseURL(htmlFile) 
  }
  return(invisible(NULL))
}


.CleanXml = function(file="test", dir=".") {
  fileName <- paste0(file, ".xml")
  xmlString <- readLines(fileName)
  xmlString <- gsub("sre:", "", xmlString)
  gsub(" *<[a-zA-Z]+/>", "", xmlString)
}


.AddContainer2HTML = function(svg, xml, file="test.html", dir=".") {
  cat('
    <div class="container">
      <div class="content">
        <div class="ChemAccess-element" id="mole1" tabindex="0" role="application">',
    file=file, append=TRUE)
  .AddSVG2HTML(svg, file=file, dir=dir)
  .AddXML2HTML(xml, file=file, dir=dir)
  cat('
        </div>
      </div>
    </div>',
    file=file, append=TRUE)
}


.AddSVG2HTML = function(svg, file="test.html", dir=".") {
  cat('          <div class="svg">\n', file=file, append=TRUE)
  cat(svg, file=file, append=TRUE)
  cat('          </div>\n', file=file, append=TRUE)
}


##vs Adapt class in both cacc and here.
.AddXML2HTML = function(xml, file="test.html", dir=".") {
  cat('          <div class="cml">\n', file=file, append=TRUE)
  cat(xml, file=file, append=TRUE)
  cat('          </div>\n', file=file, append=TRUE)
}


##vs Currently minimalistic!
.AddHeader2HTML = function(file="test.html", dir=".") {
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


.AddKey2HTML = function(file="test.html", dir=".") {
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


.AddFooter2HTML = function(file="test.html", dir=".") {
  cat('        <div class="footer">
        <p style="text-align: center; font-size: 10px;">&copy; Progressive Accessibility Solutions 2017</p>
      </div>
  </body>
</html>',
file=file, append=TRUE)
}


.CopyLibrary = function(dir="."){
  if(!file.exists(file.path(dir, "cacc.js"))){
    file.copy(file.path(system.file(package = "BrailleR"), "Web", c("cacc.js")), dir)
  }
  return(invisible(NULL))
}

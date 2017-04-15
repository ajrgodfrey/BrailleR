# note that the only directory tis is currently implemented for is the current working directory.

ViewSVG = function(dir="."){

.AddIndexHead()
.AddSVGLinks()
.AddIndexTail()
rmarkdown::render("index.md")
.CopyVSFiles()
browseURL("index.html") 
return(invisible(NULL))
}

.AddIndexHead = function(file="index.md", dir="."){
cat("---
keywords: |
    Progressive Accessibility Solutions STEM Chemistry Mathematics
    Statistics
title: Accessible Statistics Diagrams
viewport: 'width=device-width, initial-scale=1.0'
---

",'<div id="main">

<div id="site_content">

<div class="content">

Accessible Statistics Diagrams
==============================

Important note: SVG files are not rendered properly in all browsers, notably Internet Explorer. We recommend use of Firefox or Google Chrome if you are working in  Windows.

Please click on one of the examples below to get to the demo:', file=file)
return(invisible(NULL))
}

.AddSVGLinks=function(file="index.md", dir="."){
SVGFiles = list.files(pattern=".svg")
XMLFiles = sub(".svg", ".xml", SVGFiles)
FileSet = sub(".svg", "", SVGFiles[file.exists(XMLFiles)])
LinkText=paste0("\n[", FileSet, "](generic.html?mole=", FileSet, ")\n")
cat(LinkText, file=file, append=TRUE) 
return(invisible(NULL))
}

.AddIndexTail=function(file="index.md", dir="."){
cat("\n</div>\n\n</div>\n\n</div>\n", file=file, append=TRUE)
return(invisible(NULL))
}

.CopyVSFiles =function(dir="."){
return(invisible(NULL))
}


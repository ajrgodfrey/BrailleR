RewriteSVG = function(x, file) {
  UseMethod("RewriteSVG")
}

RewriteSVG.default = function(x, file) {
  return(invisible("nothing done"))
}


RewriteSVG.tsplot = function(x, file) {
  svgDoc <- XML::xmlParseDoc(file) ## "Temperature.svg"
  nodes <- XML::getNodeSet(svgDoc,
                      '//*[@id="graphics-plot-1-lines-1.1"]')
  if (length(nodes) == 0) {
    return(invisible("Something went wrong!"))
  }
  .SplitPolyline(x$GroupSummaries$N, nodes[[1]])
  XML::saveXML(svgDoc, file=file)
  return(invisible(NULL))
}

#vs Currently we hardcode the attributes. Should simply be copied.
.SplitPolyline = function(points, root, start=0, child=1) {
  children <- XML::getNodeSet(root, '//*[@points]')
  polyline <- children[[child]]
  attr <- XML::xmlGetAttr(polyline, 'points')
  coordinates <- strsplit(attr, " ")[[1]]
  count <- 1
  ## result <- list()
  for (i in 1:length(points)) {
    node <- XML::newXMLNode('polyline', parent=root)
    end <- count+points[i]
    segment <- coordinates[count:end]
    XML::addAttributes(
           node,
           id = paste("graphics-plot-1-lines-1.1.1", intToUtf8(utf8ToInt('a') + (i - 1)) , sep=""),
           points = paste(segment[!is.na(segment)], collapse=" "),
           "stroke-dasharray"="none",
           stroke="rgb(0,0,0)",
           "stroke-width"="1",
           "stroke-linecap"="round",
           "stroke-miterlimit"="10",
           "stroke-linejoin"="round",
           "stroke-opacity"="1",
           fill="none")
    XML::addChildren(root, node, at = i + (child - 1))
    count <- end
  }
  XML::removeChildren(root, polyline)
  return(invisible(NULL))
}




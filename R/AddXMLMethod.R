AddXML = function(x, file) {
            UseMethod("AddXML")
          }

AddXML.default =
    function(x, file) {
return(invisible("nothing done"))
}

AddXML.boxplot = function(x, file) {
    doc = .AddXMLDocument("boxplot")
    root = XML::xmlRoot(doc)
    annotations = .AddXMLAddNode(root, "annotations")
    .AddXMLAddXAxis(annotations, label=x$xlab)
    .AddXMLAddYAxis(annotations, label=x$ylab)
    XML::saveXML(doc=doc, file=file)
}

AddXML.dotplot = function(x, file) {
    doc = .AddXMLDocument("dotplot")
    root = XML::xmlRoot(doc)
    annotations = .AddXMLAddNode(root, "annotations")
    .AddXMLAddXAxis(annotations, label=x$xlab)
    .AddXMLAddYAxis(annotations, label=x$ylab)
    XML::saveXML(doc=doc, file=file)
}


AddXML.eulerr = function(x, file) {
    doc = .AddXMLDocument("eulerr")
    root = XML::xmlRoot(doc)
    annotations = .AddXMLAddNode(root, "annotations")
    XML::saveXML(doc=doc, file=file)
}

AddXML.ggplot = function(x, file) {
    doc = .AddXMLDocument("ggplot")
    root = XML::xmlRoot(doc)
    annotations = .AddXMLAddNode(root, "annotations")
    .AddXMLAddXAxis(annotations, label=x$xlab)
    .AddXMLAddYAxis(annotations, label=x$ylab)
    XML::saveXML(doc=doc, file=file)
}

AddXML.histogram = function(x, file) {

# first line might be unnecessary
#    .AddXMLcomponents <<- list()
 # was <<- which is frowned on
#jg assign(".AddXMLcomponents",list(), envir=BrailleR)
ComponentSet = list()


    doc = .AddXMLDocument("histogram")
    root = XML::xmlRoot(doc)
    annotations = .AddXMLAddNode(root, "annotations")

    xValues <- x$xTicks
    yValues <- x$yTicks

    title = .AddXMLAddTitle(annotations, title=x$main)
    xAxis = .AddXMLAddXAxis(annotations, label=x$xlab, values=xValues)
    yAxis = .AddXMLAddYAxis(annotations, label=x$ylab, values=yValues)

    ## That's probably the part that is diagram dependent.
    center = .AddXMLAddHistogramCenter(
        annotations, mids=x$mids, counts=x$counts, density=x$density, breaks=x$breaks)
    values = 
    .AddXMLAddChart(annotations, type="Histogram",
                    speech=paste("Histogram of", x$xlab),
                    speech2=paste("Histogram of", x$xlab, "with values from", min(x$breaks),  "to",
                                  max(x$breaks), "and", x$ylab, "from 0 to",
                                  yValues[length(yValues)]),
                    children=list(title, xAxis, yAxis, center))

#    doc = .AddXMLhistogram(x)
    XML::saveXML(doc=doc, file=file)
}


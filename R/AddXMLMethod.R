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
# ComponentSet = list()


    doc = .AddXMLDocument("histogram")
    root = XML::xmlRoot(doc)
    annotations = .AddXMLAddNode(root, "annotations")

    title = .AddXMLAddTitle(annotations, title=x$main)

    xValues <- x$xTicks
    XMax = max(x$breaks, x$xTicks)
    xAxis = .AddXMLAddXAxis(annotations, label=x$xlab, values=xValues, speechLong=paste("x axis", x$xlab, "ranges from 0 to", XMax))

    AboveY = x$yTicks
    for(i in 1:length(x$yTicks)){
        AboveY[i] = length(x$counts[x$counts > x$yTicks[i] ])
    }
    yValues <- x$yTicks
    DetYValues <- paste(x$yTicks, ":", AboveY, "of the", x$NBars, "bars exceed this point")
    YMax = max(x$counts, x$yTicks)
    yAxis = .AddXMLAddYAxis(annotations, label=x$ylab, values=yValues, detailedValues=DetYValues, speechLong=paste("y axis", x$ylab, "ranges from 0 to", YMax))

    ## That's probably the part that is diagram dependent.
    center = .AddXMLAddHistogramCenter(annotations,hist=x)
    values = 
    .AddXMLAddChart(annotations, type="Histogram",
                    speech=paste("Histogram of", x$xlab),
                    speech2=paste("Histogram of", x$xlab, "with values from", min(x$breaks),  "to",
                                  max(x$breaks), "and", x$ylab, "from 0 to",
                                  x$yTicks[length(x$yTicks)]),
                    children=list(title, xAxis, yAxis, center))

#    doc = .AddXMLhistogram(x)
    XML::saveXML(doc=doc, file=file)
    return(invisible(NULL))
}


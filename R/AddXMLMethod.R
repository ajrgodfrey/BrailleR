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
if(x$horizontal){
    .AddXMLAddXAxis(annotations, label=x$xlab)
}
else {
    .AddXMLAddYAxis(annotations, label=x$ylab)
}
# in here we put the added text for each boxplot which is the short/long text returned by looping over each boxplot and passing the fivenum and outliers to
# .BoxplotText(fivenum, outliers, horizontal=x$horizontal)

    XML::saveXML(doc=doc, file=file)
    return(invisible(NULL))
}

AddXML.dotplot = function(x, file) {
    doc = .AddXMLDocument("dotplot")
    root = XML::xmlRoot(doc)
    annotations = .AddXMLAddNode(root, "annotations")
    .AddXMLAddXAxis(annotations, label=x$xlab)
    .AddXMLAddYAxis(annotations, label=x$ylab)
    XML::saveXML(doc=doc, file=file)
    return(invisible(NULL))
}


AddXML.eulerr = function(x, file) {
    doc = .AddXMLDocument("eulerr")
    root = XML::xmlRoot(doc)
    annotations = .AddXMLAddNode(root, "annotations")
    XML::saveXML(doc=doc, file=file)
    return(invisible(NULL))
}

AddXML.ggplot = function(x, file) {
    doc = .AddXMLDocument("ggplot")
    root = XML::xmlRoot(doc)
    annotations = .AddXMLAddNode(root, "annotations")
    .AddXMLAddXAxis(annotations, label=x$xlab)
    .AddXMLAddYAxis(annotations, label=x$ylab)

    XML::saveXML(doc=doc, file=file)
    return(invisible(NULL))
}

AddXML.histogram = function(x, file) {
    doc = .AddXMLDocument("histogram")
    root = XML::xmlRoot(doc)
    annotations = .AddXMLAddNode(root, "annotations")

# still need to allow for main and sub titles
    title = .AddXMLAddTitle(annotations, title=x$main)

    xValues <- x$xTicks
    XMax = max(x$breaks, x$xTicks)
    xAxis = .AddXMLAddXAxis(annotations, label=x$xlab, values=xValues, speechLong=paste("x axis", x$xlab, "ranges from 0 to", XMax))

    AboveY = x$yTicks
    for(i in 1:length(x$yTicks)){
        AboveY[i] = length(x$counts[x$counts > x$yTicks[i] ])
    }
    yValues <- x$yTicks
    DetYValues <- paste(AboveY, "of the", x$NBars, "bars exceed the", x$ylab, x$yTicks)
    YMax = max(x$counts, x$yTicks)
    yAxis = .AddXMLAddYAxis(annotations, label=x$ylab, values=yValues, detailedValues=DetYValues, speechLong=paste("y axis", x$ylab, "ranges from 0 to", YMax))

    center = .AddXMLAddHistogramCenter(annotations,hist=x)

    .AddXMLAddChart(annotations, type="Histogram",
                    speech=paste("Histogram of", x$xlab),
                    speech2=paste("Histogram showing ", x$NBars, "bars for ", x$xlab, "over the range", min(x$breaks),  
                            "to",max(x$breaks), "and", x$ylab, "from 0 to", max(x$counts)), # must allow for density
                    children=list(title, xAxis, yAxis, center))

    XML::saveXML(doc=doc, file=file)
    return(invisible(NULL))
}

AddXML.tsplot = function(x, file) {
    doc = .AddXMLDocument("timeseriesplot")
    root = XML::xmlRoot(doc)
    annotations = .AddXMLAddNode(root, "annotations")

# still need to allow for main and sub titles
    title = .AddXMLAddTitle(annotations, title=x$main)

    xValues <- x$xTicks
    XMin = min(x$xTicks)
    XMax = max(x$xTicks)
    xAxis = .AddXMLAddXAxis(annotations, label=x$xlab, values=xValues, speechLong=paste("x axis", x$xlab, "ranges from", XMin, "to", XMax))

   yValues <- x$yTicks
    YMin = min(x$yTicks)
    YMax = max(x$yTicks)
    yAxis = .AddXMLAddYAxis(annotations, label=x$ylab, values=yValues, speechLong=paste("y axis", x$ylab, "ranges from", YMin, "to", YMax))

    ## now to add the other content related bits
    print(x)
    
    center = .AddXMLAddTimeseriesCenter(annotations,ts=x)

    .AddXMLAddChart(annotations, type="TimeSeriesPlot",
                    speech=paste("Time series plot of", x$ylab),
                    speech2=paste("Time series plot showing ", x$ylab, "over the range", YMin,  "to", YMax,  "for", x$ylab,
                        "which ranges from", XMin,  "to", XMax), 
                    children=list(title, xAxis, yAxis, center)) # until center defined..., center))

    XML::saveXML(doc=doc, file=file)
    return(invisible(NULL))
}


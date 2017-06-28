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

    title = .AddXMLAddTitle(annotations, title=x$ExtraArgs$main)

    if (x$horizontal) {
      xValues <- x$xTicks
      yValues <- x$names
      YMin = min(xValues)
      YMax = max(xValues)
    } else {
      xValues <- x$names
      yValues <- x$yTicks
      YMin = min(yValues)
      YMax = max(yValues)
    }
    if (x$horizontal) {
      xSpeech <- paste("x axis", x$ExtraArgs$xlab, "ranges from", YMin, "to", YMax)
      ySpeech <- paste("y axis with values", paste(yValues, collapse=", "))
    } else {
      xSpeech <- paste("x axis with values", paste(xValues, collapse=", "))
      ySpeech <- paste("y axis", x$ExtraArgs$ylab, "ranges from", YMin, "to", YMax)
    }


    xAxis = .AddXMLAddXAxis(annotations, label=x$ExtraArgs$xlab, values=xValues, speechLong=xSpeech)

    yAxis = .AddXMLAddYAxis(annotations, label=x$ExtraArgs$ylab, values=yValues, speechLong=ySpeech)

    center = .AddXMLAddBoxplotCenter(annotations,boxplot=x)

    chart <- .AddXMLAddChart(annotations, type="BoxPlot",
                    speech=paste(x$Boxplots, "for", x$ExtraArgs$main),
                    speech2=paste(x$Boxplots, "for", x$ExtraArgs$xlab, paste(x$names, collapse=", ")),
                    children=list(title, xAxis, yAxis, center))
    .AddXMLAddComponents(chart, list(title, xAxis, yAxis, center))
    XML::saveXML(doc=doc, file=file)
    return(invisible(NULL))
}


AddXML.dotplot = function(x, file) {
    doc = .AddXMLDocument("dotplot")
    root = XML::xmlRoot(doc)
    annotations = .AddXMLAddNode(root, "annotations")
    .AddXMLAddXAxis(annotations, label=x$ExtraArgs$xlab)
    .AddXMLAddYAxis(annotations, label=x$ExtraArgs$ylab)
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
    .AddXMLAddXAxis(annotations, label=x$ExtraArgs$xlab)
    .AddXMLAddYAxis(annotations, label=x$ExtraArgs$ylab)

    XML::saveXML(doc=doc, file=file)
    return(invisible(NULL))
}

AddXML.histogram = function(x, file) {
    doc = .AddXMLDocument("histogram")
    root = XML::xmlRoot(doc)
    annotations = .AddXMLAddNode(root, "annotations")

# still need to allow for main and sub titles
    title = .AddXMLAddTitle(annotations, title=x$ExtraArgs$main)

    xValues <- x$xTicks
    XMax = max(x$breaks, x$xTicks)
    xAxis = .AddXMLAddXAxis(annotations, label=x$ExtraArgs$xlab, values=xValues,
                            speechLong=paste("x axis", x$ExtraArgs$xlab, "ranges from 0 to", XMax))

    AboveY = x$yTicks
    for(i in 1:length(x$yTicks)){
        AboveY[i] = length(x$counts[x$counts > x$yTicks[i] ])
    }
    yValues <- x$yTicks
    DetYValues <- paste(AboveY, "of the", x$NBars, "bars exceed the", x$ExtraArgs$ylab, x$yTicks)
    YMax = max(x$counts, x$yTicks)
    yAxis = .AddXMLAddYAxis(annotations, label=x$ExtraArgs$ylab,
                            values=yValues, detailedValues=DetYValues,
                            speechLong=paste("y axis", x$ExtraArgs$ylab, "ranges from 0 to", YMax))

    center = .AddXMLAddHistogramCenter(annotations,hist=x)

    chart <- .AddXMLAddChart(annotations, type="Histogram",
                    speech=paste("Histogram of", x$ExtraArgs$xlab),
                    speech2=paste("Histogram showing ", x$NBars, "bars for ",
                                  x$ExtraArgs$xlab, "over the range", min(x$breaks),  
                                  "to",max(x$breaks), "and", x$ExtraArgs$ylab,
                                  "from 0 to", max(x$counts)), # must allow for density
                    children=list(title, xAxis, yAxis, center))
    .AddXMLAddComponents(chart, list(title, xAxis, yAxis, center))

    XML::saveXML(doc=doc, file=file)
    return(invisible(NULL))
}

AddXML.scatterplot = AddXML.tsplot = function(x, file) {
    doc = .AddXMLDocument("timeseriesplot")
    root = XML::xmlRoot(doc)
    annotations = .AddXMLAddNode(root, "annotations")

# still need to allow for main and sub titles
    title = .AddXMLAddTitle(annotations, title=x$ExtraArgs$main)

    xValues <- x$xTicks
    XMin = min(x$xTicks)
    XMax = max(x$xTicks)
    xAxis = .AddXMLAddXAxis(
        annotations, label=x$ExtraArgs$xlab, values=xValues,
        speechLong=paste("x axis", x$ExtraArgs$xlab, "ranges from", XMin, "to", XMax))

   yValues <- x$yTicks
    YMin = min(x$yTicks)
    YMax = max(x$yTicks)
    yAxis = .AddXMLAddYAxis(
        annotations, label=x$ExtraArgs$ylab, values=yValues,
        speechLong=paste("y axis", x$ExtraArgs$ylab, "ranges from", YMin, "to", YMax))

    ## now to add the other content related bits
    center = .AddXMLAddTimeseriesCenter(annotations,ts=x)

    chart <- .AddXMLAddChart(annotations, type="TimeSeriesPlot",
                    speech=paste("Time series plot of", x$ExtraArgs$ylab),
                    speech2=paste("Time series plot showing ",
                                  x$ExtraArgs$ylab, "over the range", YMin,
                                  "to", YMax,  "for", x$ExtraArgs$ylab,
                                  "which ranges from", XMin,  "to", XMax), 
                    children=list(title, xAxis, yAxis, center))
    .AddXMLAddComponents(chart, list(title, xAxis, yAxis, center))

    XML::saveXML(doc=doc, file=file)
    return(invisible(NULL))
}

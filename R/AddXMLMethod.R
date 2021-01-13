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
    grid.force()
    xs = .VIstruct.ggplot(x)
    doc = .AddXMLDocument("ggplot")
    root = XML::xmlRoot(doc)
    annotations = .AddXMLAddNode(root, "annotations")
    components = list()
    backgroundGrob = grid.grep(gPath("panel.background..rect"), grep=TRUE)
    titleGrob = grid.grep(gPath("title", "text"), grep=TRUE)
    if (length(titleGrob) > 0) {
      titleId = paste0(titleGrob$name, ".1")
      title = .AddXMLAddTitle(annotations, title=xs$title, id=titleId)
      components[[length(components) + 1]] = title
    }
    xAxisLabelGrob = paste0(grid.grep(gPath("xlab-b", "text"), grep=TRUE)$name, ".1")
    xAxisTickLabelGrob = paste0(grid.grep(gPath("axis-b", "axis", "axis", "text"), grep = TRUE)$name, ".1")
    xAxis = .AddXMLAddXAxis(annotations, label=xs$xaxis$xlabel$x_lab, values=xs$xaxis$xticklabels,
                            fullLabelId=xAxisLabelGrob, fullTickLabelId=xAxisTickLabelGrob)
    components[[length(components) + 1]] = xAxis
    yAxisLabelGrob = paste0(grid.grep(gPath("ylab-l", "text"), grep=TRUE)$name, ".1")
    yAxisTickLabelGrob = paste0(grid.grep(gPath("axis-l", "axis", "axis", "text"), grep = TRUE)$name, ".1")
    yAxis = .AddXMLAddYAxis(annotations, label=xs$yaxis$ylabel$ylab, values=xs$yaxis$yticklabels,
                            fullLabelId=yAxisLabelGrob, fullTickLabelId=yAxisTickLabelGrob)
    components[[length(components)+1]] = yAxis
    if (xs$npanels == 1) {
          for (layerNum in 1:xs$nlayers) {
            layer = .AddXMLAddGGPlotLayer(annotations, xs$panels[[1]]$panellayers[[layerNum]])    
            components[[length(components) + 1]] = layer
          }
    } 
    # Else, should warn about not handling faceted charts -- or else handle them!
    chart <- .AddXMLAddChart(annotations, type="Chart",
                             speech=paste(ifelse(is.null(xs$title), "Chart",
                                                 paste("Chart with title ", xs$title)),
                                          " with x-axis ", xs$xaxis$xlabel,
                                          " and y-axis ",xs$yaxis$ylabel),
                             # Currently speech2 is same as speech
                             speech2=paste(ifelse(is.null(xs$title), "Chart",
                                                 paste("Chart with title ", xs$title)),
                                          " with x-axis ", xs$xaxis$xlabel,
                                          " and y-axis ",xs$yaxis$ylabel),  
                             children=components)
    .AddXMLAddComponents(chart, components)
    
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

AddXML.scatterplot = function(x, file) {
    doc = .AddXMLDocument("scatterplot")
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
    center = .AddXMLAddScatterCenter(annotations, sp=x)

    chart <- .AddXMLAddChart(annotations, type="ScatterPlot",
                    speech=paste("Scatter plot of", x$ExtraArgs$ylab),
                    speech2=paste("Scatter plot showing ",
                                  x$ExtraArgs$ylab, "over the range", YMin,
                                  "to", YMax,  "for", x$ExtraArgs$ylab,
                                  "which ranges from", XMin,  "to", XMax), 
                    children=list(title, xAxis, yAxis, center))
    .AddXMLAddComponents(chart, list(title, xAxis, yAxis, center))

    XML::saveXML(doc=doc, file=file)
    return(invisible(NULL))
}

AddXML.tsplot = function(x, file) {
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

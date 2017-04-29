### This file is for internal functions that may be re-used by a variety of graph types.

## Annotating different types of diagrams.
##
## Histogram annotation.
# removed .AddXMLhistogram = function(diag) {
#        doc
#}

## Annotating title elements
.AddXMLAddTitle = function(root, title="", longTitle = paste("Title:", title)) {
    annotation = .AddXMLAddAnnotation(root, position=1, .AddXMLmakeId("main", "1.1"), kind="active")
    XML::addAttributes(annotation$root, speech=paste("Title:", title), speech2=longTitle, type="Title")
    return(invisible(annotation))
}

## Annotating axes
##
## Generic axis annotation function.
.AddXMLAddAxis = function(root, values, label, groupPosition, name, groupId, labelId, lineId, ...) {
    position = 0
    labelNode = .AddXMLAxisLabel(root, label=label, position=position <- position + 1,
                     id=labelId, axis=groupId)
    lineNode = .AddXMLAxisLine(root, id=lineId, axis=groupId)
    tickNodes = .AddXMLAxisValues(root, values=values,
                              position=position <- position + 1, id=lineId, axis=groupId, ...)
    annotations = c(list(labelNode, lineNode), tickNodes)
    .AddXMLAxisGroup(root, groupId, name, values=values, label=label,
                     annotations=annotations, position=groupPosition, ...)
}

## Parameterisation for x-axis
.AddXMLAddXAxis = function(root, values=NULL, label="", groupPosition=2, ...) {
    .AddXMLAddAxis(root, values, label, groupPosition, "x axis:", "xaxis", "xlab", "bottom", ...)
}

## Parameterisation for y-axis
.AddXMLAddYAxis = function(root, values=NULL, label="", groupPosition=3, ...) {
    .AddXMLAddAxis(root, values, label, groupPosition, "y axis:", "yaxis", "ylab", "left", ...)
}


## Aux method for axis group
.AddXMLAxisGroup = function(root, id, name, values=NULL, label="", annotations=NULL, position=1, speechShort=paste(name, label), speechLong=paste(name, label, "with values from", values[1], "to", values[length(values)]), ...) {
    annotation = .AddXMLAddAnnotation(root, position=position, id=id, kind="grouped")
    .AddXMLAddComponents(annotation, annotations)
    .AddXMLAddChildren(annotation, annotations)
    .AddXMLAddParents(annotation, annotations)
    XML::addAttributes(annotation$root, speech=speechShort,
                       speech2=speechLong,
                       type="Axis")
    return(invisible(annotation))
}


## Aux methods for axes annotation.
##
## Axis labelling
.AddXMLAxisLabel = function(root, label="", position=1, id="", axis="", speechShort=paste("Label", label), speechLong=speechShort) {
    annotation = .AddXMLAddAnnotation(root, position=position,
                                      id=.AddXMLmakeId(id, "1.1"), kind="active")
    XML::addAttributes(annotation$root, speech=speechShort, speech2=speechLong, type="Label")
    return(invisible(annotation))
}

## Axis line
.AddXMLAxisLine = function(root, position=1, id="", axis="") {
    annotation = .AddXMLAddAnnotation(root, position=position,
                                      id=.AddXMLmakeId(id, "axis", "line", "1.1"), kind="passive")
    XML::addAttributes(annotation$root, type="Line")
    return(invisible(annotation))
}

## Axis values and ticks
.AddXMLAxisValues = function(root, values=NULL, detailedValues=values, position=1, id="", axis="", ...) {
    annotations <- list()
    if (length(values) <= 0) return(invisible(annotations))
    for (i in 1:length(values)) {
        valueId = .AddXMLmakeId(id, "axis", "labels", paste("1.1", i, sep="."))
        value = .AddXMLAddAnnotation(root, position=position + i - 1,
                                     id=valueId, kind="active")
        XML::addAttributes(value$root, speech=paste("Tick mark", values[i]), speech2=detailedValues[i], type="Value")
       
        tickId = .AddXMLmakeId(id, "axis", "ticks", paste("1.1", i, sep="."))
        tick = .AddXMLAddAnnotation(root, id=tickId, kind="passive")
        XML::addAttributes(tick$root, type="Tick")
        .AddXMLAddNode(value$component, "passive", tickId)
        .AddXMLAddNode(tick$component, "active", valueId)
        annotations[[2 * i - 1]] = value
        annotations[[2 * i]] = tick
    }
    return(invisible(annotations))
}

## Constructs the center of the histogram 
.AddXMLAddHistogramCenter = function(root, hist=NULL) {
    annotation = .AddXMLAddAnnotation(root, position=4, id="center", kind="grouped")
    XML::addAttributes(annotation$root, speech="Histogram bars",
                       speech2=paste("Histogram with", length(hist$mids), "bars"),
                       type="Center")
    annotations <- list()
    for (i in 1:length(hist$mids)) {
        annotations[[i]] = .AddXMLcenterBar(root, position=i, mid=hist$mids[i],
                                            count=hist$counts[i], density=hist$density[i],
                                            start=hist$breaks[i], end=hist$breaks[i + 1])
    }
    .AddXMLAddComponents(annotation, annotations)
    .AddXMLAddChildren(annotation, annotations)
    .AddXMLAddParents(annotation, annotations)
    return(invisible(annotation))
}


.AddXMLcenterBar = function(root, position=1, mid=NULL, count=NULL, density=NULL, start=NULL, end=NULL) {
    annotation = .AddXMLAddAnnotation(root, position=position,
                                      id=.AddXMLmakeId("rect", paste("1.1", position, sep=".")),
                                      kind="active")
    XML::addAttributes(annotation$root,
                       speech=paste("Bar", position, "at", mid, "with value", count),
                       speech2=paste("Bar", position, "between x values", start,
                                     "and", end, " with y value", count, "and density", signif(density,3)),
                       type="Bar")
    return(invisible(annotation))
}


## Auxiliary methods for annotations
##
## Construct a gridSVG id.
.AddXMLmakeId = function(...) {
    paste("graphics-plot-1", ..., sep="-")
}

## Construct an SRE annotation element.
.AddXMLAddAnnotation = function(root, position=1, id="", kind="active") {
    annotation = .AddXMLAddNode(root, "annotation")
    element = .AddXMLAddNode(annotation, kind, id)
    ## This should be changed!
    node = list(root = annotation,
                element = element,
                position = .AddXMLAddNode(annotation, "position", content=position),
                parents = .AddXMLAddNode(annotation, "parents"),
                children = .AddXMLAddNode(annotation, "children"),
                component = .AddXMLAddNode(annotation, "component"),
                neighbours = .AddXMLAddNode(annotation, "neighbours"))
#jg    .AddXMLstoreComponent(id, node)
    return(invisible(node))
}

## Construct the basic XML annotation document.
.AddXMLDocument = function(tag = "histogram") {
    doc = XML::newXMLDoc()
    top = XML::newXMLNode(tag, doc = doc)
    XML::ensureNamespace(top, c(sre = "http://www.chemaccess.org/sre-schema"))
    return(invisible(doc))
}

## Add a new node with tag name and optionally text content to the given root.
.AddXMLAddNode = function(root, tag, content="") {
    node = XML::newXMLNode(paste("sre:", tag, sep=""), parent = root)
    if (content != "") {
        XML::newXMLTextNode(content, parent=node)
    }
    return(invisible(node))
}

# A shallow clone function for leaf nodes only. Avoids problems with duplicating
# namespaces.
.AddXMLclone = function(root, node) {
    newNode = XML::newXMLNode(XML::xmlName(node, full=TRUE), parent = root)
    XML::newXMLTextNode(XML::xmlValue(node), parent=newNode)
    return(invisible(newNode))
}

## Add components to an annotation
.AddXMLAddComponents = function(annotation, nodes) {
    clone <- function(x) if (XML::xmlName(x$element) != "grouped") {
                             .AddXMLclone(annotation$component, x$element)   
                         }
    lapply(nodes, clone)
}

## Add children to an annotation
.AddXMLAddChildren = function(annotation, nodes) {
    clone <- function(x) if (XML::xmlName(x$element) != "passive") {
                             .AddXMLclone(annotation$children, x$element)   
                         }
    lapply(nodes, clone)
}


## Add parent to annotations
.AddXMLAddParents = function(parent, nodes) {
    clone <- function(x) .AddXMLclone(x$parents, parent$element)
    lapply(nodes, clone)
}


## Store components for top level Element
# moved into the XML.histogram()
#  assign(".AddXMLcomponents",list(), envir=BrailleR)
# not allowed.

.AddXMLStoreComponent = function(CompSet, id, element) {
    CompSet[[id]] = element
    return(invisible(CompSet))
}



#jg .AddXMLstoreComponent = function(id, element) {
#jg     assign(".AddXMLcomponents[[id]]", element, envir = BrailleR)
#jg }

#vs We need to get the components into the topmost element.
.AddXMLAddChart = function(root, children=NULL, speech="", speech2="", type="") {
    annotation = .AddXMLAddAnnotation(root, id="chart", kind="grouped")
    XML::addAttributes(annotation$root, speech=speech, speech2=speech2, type=type)
#jg     .AddXMLAddComponents(annotation, get(.AddXMLcomponents, envir=BrailleR))
    .AddXMLAddChildren(annotation, children)
    .AddXMLAddParents(annotation, children)
    return(invisible(annotation))
}


## Constructs the center of the timeseries
.AddXMLAddTimeseriesCenter = function(root, ts=NULL) {
  annotation = .AddXMLAddAnnotation(root, position=4, id="center", kind="grouped")
  gs = ts$GroupSummaries
  len = length(gs$N)
  if (ts$Continuous) {
    XML::addAttributes(
           annotation$root, speech="Timeseries graph",
           speech2=paste("Continuous timeseries graph divided into",
                         len, "sub intervals of equal length"),
           type="Center")
  } else {
    XML::addAttributes(
           annotation$root, speech="Timeseries graph",
           speech2=paste("Timeseries graph with", len, "discrete segments"),
           type="Center")
  }
  annotations <- list()
  for (i in 1:len) {
    annotations[[i]] = .AddXMLtimeseriesSegment(
      root, position=i, mean=gs$Mean[i], median=gs$Median[i], sd=gs$SD[i], n=gs$N[i])
  }
  annotations[[i + 1]] = .AddXMLAddAnnotation(
    root, position=0, id=.AddXMLmakeId("box", "1.1.1"), kind="passive")
  .AddXMLAddComponents(annotation, annotations)
  .AddXMLAddChildren(annotation, annotations)
  .AddXMLAddParents(annotation, annotations)
  return(invisible(annotation))
}


.AddXMLtimeseriesSegment =
  function(root, position=1, mean=NULL, median=NULL, sd=NULL, n=NULL) {
    annotation = .AddXMLAddAnnotation(
      root, position=position,
      id=.AddXMLmakeId("lines", paste("1.1.1", intToUtf8(utf8ToInt('a') + (position - 1)) , sep="")),
      kind="active")
    speech2 = paste("Segment", position, "with", n, "data points, mean", signif(mean, 3),
                    "and median", signif(median, 3))
    if (!is.na(sd)) {
      speech2 = paste(speech2, "and standard deviation", signif(sd, 3))
    }
    XML::addAttributes(annotation$root,
                       speech=paste("Segment", position, "with mean", signif(mean, 3)),
                       speech2=speech2, type="Segment")
    return(invisible(annotation))
  }


## Constructs the center of the histogram 
.AddXMLAddBoxplotCenter = function(root, boxplot=NULL) {
  annotation = .AddXMLAddAnnotation(root, position=4, id="center", kind="grouped")
  ##vs sort out grammar:
  ##    singular vs plural with $IsAre,
  ##    sequence with commata and "and"
  XML::addAttributes(annotation$root, speech=boxplot$Boxplots,
                     speech2=paste(boxplot$Boxplots, "for", paste(boxplot$names, collapse=", ")),
                     type="Center")
  annotations <- list()
  lastPos <- 8
  i <- 0
  for (i in 1:boxplot$NBox) {
    quartiles <- boxplot$stats[, c(i)]
    outliers <- boxplot$out[boxplot$group == i]
    annotations[[i]] = .AddXMLAddSingleBoxplot(root, position=i, counter=lastPos,
                                               quartiles=quartiles, outliers=outliers,
                                               datapoints=boxplot$n[i],
                                               name=boxplot$names[i])
    lastPos <- ifelse(length(outliers) == 0, lastPos + 6, lastPos + 8)
  }
  annotations[[i + 1]] = .AddXMLAddAnnotation(
    root, position=0, id=.AddXMLmakeId("box", "1.1.1"), kind="passive")
  .AddXMLAddComponents(annotation, annotations)
  .AddXMLAddChildren(annotation, annotations)
  .AddXMLAddParents(annotation, annotations)
  return(invisible(annotation))
}



.AddXMLAddSingleBoxplot =
  function(root, position=1, counter=8, quartiles=NULL, outliers=NULL, datapoints=0, name="") {
    ## Position counting:
    ## We go via the root element.
    ##
    ## We start at 8, always. Then count up 6 or 8 elements, depending on whether
    ## outliers a present.
    ##
    ## 1. Middle bar (median)
    ## 2. omitted
    ## 3. dashed bar 
    ## 4. end bars
    ## 5. inner box
    ## 6. omitted
    ## 7. outliers (if present)
    ## 8. omitted  (if 7 present)
    annotation = .AddXMLAddAnnotation(root, position=position,
                                      id=paste0("boxplot", position),
                                      kind="active")
    annotations <- list()
    annotations[[1]] <- .AddXMLAddAnnotation(
      root, position=3, id=paste0("graphics-root.", counter), kind="passive")
    annotations[[2]] <- .AddXMLAddAnnotation(
      root, position=1,  id=paste0("graphics-root.", counter + 2), kind="passive")
    annotations[[3]] <- .AddXMLAddAnnotation(
      root, position=2, id=paste0("graphics-root.", counter + 3), kind="passive")
    annotations[[4]] <- .AddXMLAddAnnotation(
      root, position=4, id=paste0("graphics-root.", counter + 4), kind="passive")
    speech <- paste("Boxplot", ifelse(name == "", "", paste("for", name)),
                    "and quartiles in", paste(quartiles, collapse=", "))
    speech2 <- paste("Boxplot", ifelse(name == "", "", paste("for", name)),
                     "for", datapoints, "datapoints.",
                     "Quartile one from", quartiles[1], "to", quartiles[2], ".",
                     "Quartile two from", quartiles[2], "to", quartiles[3], ".",
                     "Quartile three from", quartiles[3], "to", quartiles[4], ".",
                     "Quartile four from", quartiles[4], "to", quartiles[5], "."
                     )
    if (length(outliers) > 0) {
      ## Add outliers
      annotations[[5]] <- .AddXMLAddAnnotation(
        root, position=5, id=paste0("graphics-root.", counter + 6), kind="passive")
      speech <- paste(speech, "and", length(outliers), "outliers")
      speech2 <- paste(speech2, length(outliers), "outliers at", paste(outliers, collapse=", "))
    } else {
      speech2 <- paste(speech2, "No outliers")
    }
    XML::addAttributes(annotation$root, speech=speech, speech2=speech2, type="boxplot")
    .AddXMLAddComponents(annotation, annotations)
    .AddXMLAddChildren(annotation, annotations)
    .AddXMLAddParents(annotation, annotations)
    return(invisible(annotation))
  }

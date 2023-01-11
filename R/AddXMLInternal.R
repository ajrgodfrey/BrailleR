### This file is for internal functions that may be re-used by a variety of graph types.

## Annotating different types of diagrams.
##
## Histogram annotation.
# removed .AddXMLhistogram = function(diag) {
#        doc
# }

## Annotating title elements
.AddXMLAddTitle <- function(root, title = "", longTitle = paste("Title:", title), id = NULL) {
  titleId <- ifelse(is.null(id), .AddXMLmakeId("main", "1.1"), id)
  annotation <- .AddXMLAddAnnotation(root, position = 1, titleId, kind = "active")
  XML::addAttributes(annotation$root, speech = paste("Title:", title), speech2 = longTitle, type = "Title")
  return(invisible(annotation))
}

## Annotating axes
##
## Add axis to XML it is important that you give it a correct axis
.AddXMLAddAxis <- function(root, values = NULL, label = "", groupPosition = ifelse(axis == "x", 2, 3), axis, name = paste(axis, "axis:"), groupId = paste0(axis, "axis"), labelId = paste0(axis, "lab"), lineId = ifelse(axis == "x", "bottom", "left"), ...) {
  position <- 0
  labelNode <- .AddXMLAxisLabel(root,
    label = label, position = position <- position + 1,
    id = labelId, axis = groupId, ...
  )
  # Shouldn't try to add lineNode if this is a ggplot
  lineNode <- .AddXMLAxisLine(root, id = lineId, axis = groupId)
  tickNodes <- .AddXMLAxisValues(root,
    values = values,
    position = position <- position + 1, id = lineId, axis = groupId, ...
  )
  annotations <- c(list(labelNode, lineNode), tickNodes)
  .AddXMLAxisGroup(root, groupId, name,
    values = values, label = label,
    annotations = annotations, position = groupPosition, ...
  )
}

## Aux method for axis group
.AddXMLAxisGroup <- function(root, id, name, values = NULL, label = "", annotations = NULL, position = 1, speechShort = paste(name, label), speechLong = paste(name, label, "with values from", values[1], "to", values[length(values)]), ...) {
  annotation <- .AddXMLAddAnnotation(root, position = position, id = id, kind = "grouped")
  .AddXMLAddComponents(annotation, annotations)
  .AddXMLAddChildren(annotation, annotations)
  .AddXMLAddParents(annotation, annotations)
  XML::addAttributes(annotation$root,
    speech = speechShort,
    speech2 = speechLong,
    type = "Axis"
  )
  return(invisible(annotation))
}


## Aux methods for axes annotation.
##
## Axis labelling
.AddXMLAxisLabel <- function(root, label = "", position = 1, id = "", axis = "", speechShort = paste("Label", label),
                             speechLong = speechShort, fullLabelId = NULL, ...) {
  labelId <- ifelse(is.null(fullLabelId), .AddXMLmakeId(id, "1.1"), fullLabelId)
  annotation <- .AddXMLAddAnnotation(root, position = position, id = labelId, kind = "active")
  XML::addAttributes(annotation$root, speech = speechShort, speech2 = speechLong, type = "Label")
  return(invisible(annotation))
}

## Axis line
.AddXMLAxisLine <- function(root, position = 1, id = "", axis = "") {
  annotation <- .AddXMLAddAnnotation(root,
    position = position,
    id = .AddXMLmakeId(id, "axis", "line", "1.1"), kind = "passive"
  )
  XML::addAttributes(annotation$root, type = "Line")
  return(invisible(annotation))
}

## Axis values and ticks
.AddXMLAxisValues <- function(root, values = NULL, detailedValues = values, position = 1, id = "", axis = "",
                              fullTickLabelId = NULL, ...) {
  annotations <- list()
  if (length(values) <= 0) {
    return(invisible(annotations))
  }
  for (i in 1:length(values)) {
    valueId <- ifelse(is.null(fullTickLabelId),
      .AddXMLmakeId(id, "axis", "labels", paste("1.1", i, sep = ".")),
      paste(fullTickLabelId, i, sep = ".")
    )
    value <- .AddXMLAddAnnotation(root,
      position = position + i - 1,
      id = valueId, kind = "active"
    )
    XML::addAttributes(value$root, speech = paste("Tick mark", values[i]), speech2 = detailedValues[i], type = "Value")

    tickId <- .AddXMLmakeId(id, "axis", "ticks", paste("1.1", i, sep = "."))
    tick <- .AddXMLAddAnnotation(root, id = tickId, kind = "passive")
    XML::addAttributes(tick$root, type = "Tick")
    .AddXMLAddNode(value$component, "passive", tickId)
    .AddXMLAddNode(tick$component, "active", valueId)
    annotations[[2 * i - 1]] <- value
    annotations[[2 * i]] <- tick
  }
  return(invisible(annotations))
}

## Constructs the center of the histogram
.AddXMLAddHistogramCenter <- function(root, hist = NULL) {
  annotation <- .AddXMLAddAnnotation(root, position = 4, id = "center", kind = "grouped")
  XML::addAttributes(annotation$root,
    speech = "Histogram bars",
    speech2 = paste("Histogram with", length(hist$mids), "bars"),
    type = "Center"
  )
  annotations <- list()
  for (i in 1:length(hist$mids)) {
    annotations[[i]] <- .AddXMLcenterBar(root,
      position = i, mid = hist$mids[i],
      count = hist$counts[i], density = hist$density[i],
      start = hist$breaks[i], end = hist$breaks[i + 1]
    )
  }
  .AddXMLAddComponents(annotation, annotations)
  .AddXMLAddChildren(annotation, annotations)
  .AddXMLAddParents(annotation, annotations)
  return(invisible(annotation))
}

## Constructs a ggplot layer
.AddXMLAddGGPlotLayer <- function(root, x = NULL, panel = 1) {
  annotation <- .AddXMLAddAnnotation(root,
    position = 4,
    id = paste("center", panel, x$layernum, sep = "-"), kind = "grouped"
  )
  # TODO:  For all layer types:  need heuristic to avoid trying to describe
  # individual data points if there are thousands of them
  # This is the same structure as found in the VI method for ggplots.
  if (x$type == "bar") { # Bar chart
    barCount <- nrow(x$data)
    barGrob <- grid.grep(gPath("geom_rect"), grep = TRUE)
    XML::addAttributes(annotation$root,
      speech = "Histogram bars",
      speech2 = paste("Histogram with", barCount, "bars"),
      type = "Center"
    )
    annotations <- list()
    chartData <- x$data
    for (i in 1:barCount) {
      barId <- paste(barGrob$name, "1", i, sep = ".")
      # TODO: histogram bars have density but other geom_bar objects won't
      # Need to not fail if density not present
      # Generally, need to deal with missing values better

      # If no density values then assume it's a categorical x-axis
      if (is.null(chartData$density)) {
        annotations[[i]] <- .AddXMLcategoricalBar(
          root,
          position = i,
          x = signif(chartData$x[i], 4),
          count = chartData$ymax[i] - chartData$ymin[i],
          id = barId
        )
      } else {
        annotations[[i]] <- .AddXMLcenterBar(
          root,
          position = i,
          mid = signif(chartData$x[i], 4),
          count = chartData$ymax[i] - chartData$ymin[i],
          density = ifelse(is.null(chartData$density), NA, chartData$density[i]),
          start = signif(chartData$xmin[i], 4),
          end = signif(chartData$xmax[i], 4),
          id = barId
        )
      }
    }
  } else if (x$type == "line") { # Line chart
    segmentCount <- nrow(x$data) - 1 # One less than the number of points
    # For now, assume that all layers are this layer type
    # TODO:  Fix this
    lineGrobs <- grid.grep(gPath("panel", "panel-1", "GRID.polyline"), grep = TRUE, global = TRUE)
    lineGrob <- lineGrobs[[x$layernum]]
    XML::addAttributes(annotation$root,
      speech = "Line graph",
      speech2 = paste("Line graph with", segmentCount, "segments"),
      # Better to report #lines or #segs?
      # Line can be discontinuous (comprised of polylines 1a, 1b, ...)
      type = "Center"
    )
    annotations <- list()

    data <- x$data
    numberOfLines <- length(x$lines)

    lineId <- paste(lineGrob$name, "1", sep = ".") # ID of the polyline

    for (lineNum in 1:numberOfLines) {
      lineId <- paste(lineGrob$name, lineNum, sep = ".") # ID of the polyline

      lineData <- x$lines[[lineNum]]$scaledata
      lineCount <- nrow(lineData) - 1
      # Summarizing the data
      maxItems <- 5
      if (lineCount > maxItems) {
        min <- min(lineData$x)
        max <- max(lineData$x)
        breaks <- seq(min, max, length.out = maxItems + 1)
        mins <- breaks[1:(maxItems)]
        maxs <- breaks[2:(maxItems + 1)]
        meansAndSD <- mapply(
          function(min, max) {
            sectionData <- lineData$y[lineData$x < max & lineData$x >= min]
            list(
              mean = mean(sectionData),
              sd = ifelse(is.na(sd(sectionData)), 0, sd(sectionData))
            )
          },
          mins, maxs
        )
        summarised <- TRUE
        lineCount <- maxItems
      } else {
        summarised <- FALSE
      }

      for (i in 1:(lineCount)) {
        if (summarised) {
          desc <- paste(
            .AddXMLFormatNumber(meansAndSD[, i]$mean),
            "mean with sd",
            .AddXMLFormatNumber(meansAndSD[, i]$sd),
            "going from",
            .AddXMLFormatNumber(mins[i]),
            "to",
            .AddXMLFormatNumber(maxs[i])
          )
        } else {
          desc <- paste(
            .AddXMLFormatNumber(lineData$y[i]),
            "at",
            .AddXMLFormatNumber(lineData$x[i]),
            ifelse(i < segmentCount, " line start", " line end"),
            i
          )
        }
        annotations[[i]] <- .AddXMLPoint(root, position = i, id = lineId, speech = desc)
        # TODO:  Not correctly handling NA or out-of-range data values, nor dates
        # Should check for dates with inherit(,"Date") -- but looks like I
        # need to do that on the main data not the layer data
      }
    }
  } else { # TODO:  warn about layer types we don't recognize
    return(NULL)
  }
  .AddXMLAddComponents(annotation, annotations)
  .AddXMLAddChildren(annotation, annotations)
  .AddXMLAddParents(annotation, annotations)
  return(invisible(annotation))
}

.AddXMLcenterBar <- function(root, position = 1, mid = NULL, count = NULL, density = NULL, start = NULL, end = NULL,
                             id = NULL) {
  rectId <- ifelse(is.null(id), .AddXMLmakeId("rect", paste("1.1", position, sep = ".")), id)
  annotation <- .AddXMLAddAnnotation(root,
    position = position,
    id = rectId,
    kind = "active"
  )
  XML::addAttributes(annotation$root,
    speech = paste("Bar", position, "at", mid, "with value", count),
    speech2 = paste(
      "Bar", position, "between x values", start,
      "and", end, " with y value", count, "and density", signif(density, 3)
    ),
    type = "Bar"
  )
  return(invisible(annotation))
}
.AddXMLcategoricalBar <- function(root, position = 1, x = NULL, count = NULL, id = NULL) {
  rectId <- ifelse(is.null(id), .AddXMLmakeId("rect", paste("1.1", position, sep = ".")), id)
  annotation <- .AddXMLAddAnnotation(root,
    position = position,
    id = rectId,
    kind = "active"
  )
  XML::addAttributes(annotation$root,
    speech = paste("Bar", position, "at", x, "with value", count),
    speech2 = paste("Bar", position, "at x value", x, " with y value", count),
    type = "Bar"
  )
  return(invisible(annotation))
}
# Polyline is problematic as we can't highlight each segment visually, but still want
# to describle them separately
# Current fudge for this -- define each segment with a dummy name that doesn't actually
# exist in the SVG.  Then give it a passive child which is the whole
# polyline.  This keeps the whole line visible while individual segments are described
.AddXMLPoint <- function(root, position = 1, x, y, id = NULL, speech = paste0("(", signif(x), ",", signif(y), ") number ", position)) {
  fakeSegmentId <- paste(id, position, sep = ".")
  annotation <- .AddXMLAddAnnotation(root, position = position, id = fakeSegmentId, kind = "active")
  dummyAnnotation <- list(.AddXMLAddAnnotation(root, position = position, id = id, kind = "passive"))
  XML::addAttributes(annotation$root, speech = speech, speech2 = speech)
  .AddXMLAddComponents(annotation, dummyAnnotation)
  .AddXMLAddChildren(annotation, dummyAnnotation)
  .AddXMLAddParents(annotation, dummyAnnotation)
  return(invisible(annotation))
}


## Auxiliary methods for annotations
##
## Construct a gridSVG id.
.AddXMLmakeId <- function(...) {
  paste("graphics-plot-1", ..., sep = "-")
}

## Construct an SRE annotation element.
.AddXMLAddAnnotation <- function(root, position = 1, id = "", kind = "active") {
  annotation <- .AddXMLAddNode(root, "annotation")
  element <- .AddXMLAddNode(annotation, kind, id)
  ## This should be changed!
  node <- list(
    root = annotation,
    element = element,
    position = .AddXMLAddNode(annotation, "position", content = position),
    parents = .AddXMLAddNode(annotation, "parents"),
    children = .AddXMLAddNode(annotation, "children"),
    component = .AddXMLAddNode(annotation, "component"),
    neighbours = .AddXMLAddNode(annotation, "neighbours")
  )
  # jg    .AddXMLstoreComponent(id, node)
  return(invisible(node))
}

## Construct the basic XML annotation document.
.AddXMLDocument <- function(tag = "histogram") {
  doc <- XML::newXMLDoc()
  top <- XML::newXMLNode(tag, doc = doc)
  XML::ensureNamespace(top, c(sre = "http://www.chemaccess.org/sre-schema"))
  return(invisible(doc))
}

## Add a new node with tag name and optionally text content to the given root.
.AddXMLAddNode <- function(root, tag, content = "") {
  node <- XML::newXMLNode(paste("sre:", tag, sep = ""), parent = root)
  if (content != "") {
    XML::newXMLTextNode(content, parent = node)
  }
  return(invisible(node))
}

# A shallow clone function for leaf nodes only. Avoids problems with duplicating
# namespaces.
.AddXMLclone <- function(root, node) {
  newNode <- XML::newXMLNode(XML::xmlName(node, full = TRUE), parent = root)
  XML::newXMLTextNode(XML::xmlValue(node), parent = newNode)
  return(invisible(newNode))
}

## Add components to an annotation
.AddXMLAddComponents <- function(annotation, nodes) {
  clone <- function(x) {
    if (XML::xmlName(x$element) != "grouped") {
      .AddXMLclone(annotation$component, x$element)
    } else {
      .AddXMLAddBaseComponents(annotation, x)
    }
  }
  lapply(nodes, clone)
}

.AddXMLAddBaseComponents <- function(annotation, node) {
  clone <- function(x) .AddXMLclone(annotation$component, x)
  lapply(xmlChildren(node$component), clone)
}

## Add children to an annotation
.AddXMLAddChildren <- function(annotation, nodes) {
  clone <- function(x) {
    if (XML::xmlName(x$element) != "passive") {
      .AddXMLclone(annotation$children, x$element)
    }
  }
  lapply(nodes, clone)
}


## Add parent to annotations
.AddXMLAddParents <- function(parent, nodes) {
  clone <- function(x) .AddXMLclone(x$parents, parent$element)
  lapply(nodes, clone)
}


## Store components for top level Element
# moved into the XML.histogram()
#  assign(".AddXMLcomponents",list(), envir=BrailleR)
# not allowed.

.AddXMLStoreComponent <- function(CompSet, id, element) {
  CompSet[[id]] <- element
  return(invisible(CompSet))
}



# jg .AddXMLstoreComponent = function(id, element) {
# jg     assign(".AddXMLcomponents[[id]]", element, envir = BrailleR)
# jg }

# vs We need to get the components into the topmost element.
.AddXMLAddChart <- function(root, children = NULL, speech = "", speech2 = "", type = "") {
  annotation <- .AddXMLAddAnnotation(root, id = "chart", kind = "grouped")
  XML::addAttributes(annotation$root, speech = speech, speech2 = speech2, type = type)
  # jg     .AddXMLAddComponents(annotation, get(.AddXMLcomponents, envir=BrailleR))
  .AddXMLAddChildren(annotation, children)
  .AddXMLAddParents(annotation, children)
  return(invisible(annotation))
}


## Constructs the center of the timeseries
.AddXMLAddTimeseriesCenter <- function(root, ts = NULL) {
  annotation <- .AddXMLAddAnnotation(root, position = 4, id = "center", kind = "grouped")
  gs <- ts$GroupSummaries
  len <- length(gs$N)
  if (ts$Continuous) {
    XML::addAttributes(
      annotation$root,
      speech = "Timeseries graph",
      speech2 = paste(
        "Continuous timeseries graph divided into",
        len, "sub intervals of equal length"
      ),
      type = "Center"
    )
  } else {
    XML::addAttributes(
      annotation$root,
      speech = "Timeseries graph",
      speech2 = paste("Timeseries graph with", len, "discrete segments"),
      type = "Center"
    )
  }
  annotations <- list()
  for (i in 1:len) {
    annotations[[i]] <- .AddXMLtimeseriesSegment(
      root,
      position = i, mean = gs$Mean[i], median = gs$Median[i], sd = gs$SD[i], n = gs$N[i]
    )
  }
  annotations[[i + 1]] <- .AddXMLAddAnnotation(
    root,
    position = 0, id = .AddXMLmakeId("box", "1.1.1"), kind = "passive"
  )
  .AddXMLAddComponents(annotation, annotations)
  .AddXMLAddChildren(annotation, annotations)
  .AddXMLAddParents(annotation, annotations)
  return(invisible(annotation))
}


.AddXMLtimeseriesSegment <-
  function(root, position = 1, mean = NULL, median = NULL, sd = NULL, n = NULL) {
    annotation <- .AddXMLAddAnnotation(
      root,
      position = position,
      id = .AddXMLmakeId("lines", paste("1.1.1", intToUtf8(utf8ToInt("a") + (position - 1)), sep = "")),
      kind = "active"
    )
    speech2 <- paste(
      "Segment", position, "with", n, "data points, mean", signif(mean, 3),
      "and median", signif(median, 3)
    )
    if (!is.na(sd)) {
      speech2 <- paste(speech2, "and standard deviation", signif(sd, 3))
    }
    XML::addAttributes(annotation$root,
      speech = paste("Segment", position, "with mean", signif(mean, 3)),
      speech2 = speech2, type = "Segment"
    )
    return(invisible(annotation))
  }


## Constructs the center of the histogram
.AddXMLAddBoxplotCenter <- function(root, boxplot = NULL) {
  annotation <- .AddXMLAddAnnotation(root, position = 4, id = "center", kind = "grouped")
  ## vs sort out grammar:
  ##    singular vs plural with $IsAre,
  ##    sequence with commata and "and"
  XML::addAttributes(annotation$root,
    speech = paste(boxplot$Boxplots, boxplot$VertHorz),
    speech2 = paste(
      boxplot$Boxplots, boxplot$VertHorz,
      "for", paste(boxplot$names, collapse = ", ")
    ),
    type = "Center"
  )
  annotations <- list()
  lastPos <- 8
  i <- 0
  outCount <- 1
  for (i in 1:boxplot$NBox) {
    quartiles <- boxplot$stats[, c(i)]
    outliers <- boxplot$out[boxplot$group == i]
    annotations[[i]] <- .AddXMLAddSingleBoxplot(root,
      position = i, counter = lastPos,
      quartiles = quartiles, outliers = outliers,
      datapoints = boxplot$n[i], outCount = outCount,
      name = boxplot$names[i]
    )
    lastPos <- ifelse(length(outliers) == 0, lastPos + 6, lastPos + 8)
    outCount <- outCount + ifelse(length(outliers) > 0, 2, 1)
  }
  annotations[[i + 1]] <- .AddXMLAddAnnotation(
    root,
    position = 0, id = .AddXMLmakeId("box", "1.1.1"), kind = "passive"
  )
  .AddXMLAddComponents(annotation, annotations)
  .AddXMLAddChildren(annotation, annotations)
  .AddXMLAddParents(annotation, annotations)
  return(invisible(annotation))
}



.AddXMLAddSingleBoxplot <-
  function(root, position = 1, counter = 8, quartiles = NULL, outliers = NULL, datapoints = 0, name = "", outCount = 1) {
    ## Speech computations
    ## q1: Minimum or lower whisker
    ## q2: Lower Quartile
    ## q3: Median
    ## q4: Upper Quartile
    ## q5: Maximum or upper whisker
    ##
    ## References:
    ## http://www.bbc.co.uk/schools/gcsebitesize/maths/statistics/representingdata3hirev6.shtml
    ## https://www.khanacademy.org/math/probability/data-distributions-a1/box--whisker-plots-a1/v/reading-box-and-whisker-plots
    q1 <- ifelse(suppressWarnings(min(outliers)) < quartiles[1],
      paste("Lower whisker", quartiles[1]),
      paste("Minimum", quartiles[1])
    )
    q2 <- paste("Lower quartile", quartiles[2])
    q3 <- paste("Median", quartiles[3])
    q4 <- paste("Upper quartile", quartiles[4])
    q5 <- ifelse(suppressWarnings(max(outliers)) > quartiles[5],
      paste("Upper whisker", quartiles[5]),
      paste("Maximum", quartiles[5])
    )
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
    annotation <- .AddXMLAddAnnotation(root,
      position = position,
      id = paste0("boxplot", position),
      kind = "grouped"
    )
    annotations <- list()
    annotations[[1]] <- .AddXMLAddAnnotation(
      root,
      position = 1, id = paste0("graphics-root.", counter), kind = "active"
    )
    XML::addAttributes(annotations[[1]]$root, speech = q3, type = "component")
    annotations[[2]] <- .AddXMLAddAnnotation(
      root,
      position = 2, id = paste0("graphics-root.", counter + 2), kind = "passive"
    )
    annotations[[3]] <- .AddXMLAddAnnotation(
      root,
      position = 3, id = paste0("graphics-root.", counter + 4), kind = "active"
    )
    XML::addAttributes(annotations[[3]]$root,
      speech = paste0(paste(q2, "and", q4), "."),
      type = "component"
    )
    annotations[[4]] <- .AddXMLAddAnnotation(
      root,
      position = 4, id = paste0("graphics-root.", counter + 3), kind = "active"
    )
    XML::addAttributes(annotations[[4]]$root,
      speech = paste0(paste(q1, "and", q5), "."),
      type = "component"
    )
    speech <- paste(
      "Boxplot", ifelse(name == "", "", paste("for", name)),
      "and quartiles in", paste(quartiles, collapse = ", ")
    )
    speech2 <- paste(
      "Boxplot", ifelse(name == "", "", paste("for", name)),
      "for", datapoints, "datapoints.",
      paste0(paste(q1, q2, q3, q4, q5, sep = ", "), ".")
    )
    if (length(outliers) > 0) {
      ## Add outliers
      if (length(outliers) > 1) {
        annotations[[5]] <- .AddXMLAddAnnotation(root,
          position = 5,
          id = paste0("outliers", position),
          kind = "grouped"
        )
        .AddXMLOutliers(root, annotations[[5]], outliers, position = 1, outCount = outCount + 1)
        name <- "outliers"
      } else {
        annotations[[5]] <- .AddXMLAddAnnotation(
          root,
          position = 5, id = paste0("graphics-root.", counter + 6), kind = "active"
        )
        name <- "outlier"
      }
      speech <- paste(speech, "and", length(outliers), name)
      descr <- paste(length(outliers), name, "at", paste(outliers, collapse = ", "))
      speech2 <- paste(speech2, descr)
      XML::addAttributes(annotations[[5]]$root, speech = descr, type = "component")
    } else {
      speech2 <- paste(speech2, "No outliers")
    }
    XML::addAttributes(annotation$root, speech = speech, speech2 = speech2, type = "boxplot")
    .AddXMLAddComponents(annotation, annotations)
    .AddXMLAddChildren(annotation, annotations)
    .AddXMLAddParents(annotation, annotations)
    return(invisible(annotation))
  }


.AddXMLOutliers <- function(root, parent, outliers, position = 1, id = "", outCount = 1) {
  annotations <- list()
  sortOut <- sort(outliers)
  for (v in sortOut) {
    annotation <- .AddXMLAddAnnotation(
      root,
      position = position,
      id = .AddXMLmakeId("points", paste(outCount, "1", match(v, outliers), sep = ".")),
      kind = "active"
    )
    XML::addAttributes(annotation$root,
      speech = v,
      speech2 = paste("Outlier", v), type = "point"
    )
    annotations <- append(annotations, list(annotation))
  }
  .AddXMLAddComponents(parent, annotations)
  .AddXMLAddChildren(parent, annotations)
  .AddXMLAddParents(parent, annotations)
  return(invisible(annotations))
}

.AddXMLFormatNumber <- function(x) {
  if ((x > 9999 | x < 0.001) & !is.nan(x)) {
    useScientific <- TRUE
  } else {
    useScientific <- FALSE
  }
  format(x, digits = 4, scientific = useScientific)
}

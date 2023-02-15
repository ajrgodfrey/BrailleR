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
    annotations[[i]] <- .AddXMLGGplotGeomItem.bar(root,
      position = i, x = hist$mids[i],
      count = hist$counts[i], density = hist$density[i],
      start = hist$breaks[i], end = hist$breaks[i + 1],
      categorical = FALSE
    )
  }
  .AddXMLAddComponents(annotation, annotations)
  .AddXMLAddChildren(annotation, annotations)
  .AddXMLAddParents(annotation, annotations)
  return(invisible(annotation))
}

#' Summarise a ggplot layer data.
#'
#' This will create a list with a elements that summarise a certain section of data.
#' It uses the .SplitData function which is also used by the RewriteSVG function so
#' it should all line up.
#'
#' You will know the element names of each of the section elements in the returned list
#' as you will have given the function that processes the dfs.
#'
#' @param data The data for particular layer
#' @param FUN The function which will summarise the certain sections of data
#' @param overlap Whether the data sections should have overlapping elements at their ends.
#' It is used for GeomLines and such where they are connected.
#'
#' @return A list of length <= 5 that has each element as summary of the section of data.
.AddXMLSummariseGGPlotLayer <- function(data, FUN = function(x) x, overlap = FALSE) {
  .SplitData(seq_along(data$x), overlapping = overlap) |>
    lapply(function(indexs) {
      data |>
        dplyr::slice(indexs) |>
        tidyr::drop_na(x, y) |>
        dplyr::distinct() |>
        FUN()
    })
}

#' Add XML elements to make it work with a ggplot layers svg elements
#'
#' The layer classes it uses are the ones which are given by the VIstruct command.
#' So rather then GeomLine it line and GeomPoint is point etc.
#'
#' @param root the XML annotation tag root.
#' @param layerRoot The root of this layer annotation used to add the speech to it which is layer  specific.
#' @param graphObjectStruct This is the struct that is produced by sending the ggplot graph to VIstruct
#' It should only be for the specific layer.
#' @param geomID This is the geomID and should match the SVG element ID that encompasses
#' All of the individual layer svg elements
#' @param panel The panel of te plot this is on. There is currently no implementation
#' that supports the panel
#' @param summarisedSections How many sections data should be summarised to.
#' This is also the max amount of data that can exist before it is summarised
#' @param ... These can be passed on to specific layer geoms.
#' However due to how this is called in the AddXML it isnt used.
#'
#' @return The annotation that covers this graph layer
.AddXMLAddGGPlotLayer <- function(root, layerRoot, graphObjectStruct, geomID, panel = 1, summarisedSections = 5, ...) {
  UseMethod(".AddXMLAddGGPlotLayer", graphObjectStruct)
}

.AddXMLAddGGPlotLayer.point <- function(root, layerRoot, graphObjectStruct, geomID, panel = 1, summarisedSections = 5, ...) {
  # Rmeove all the NAs in the data
  data <- graphObjectStruct$data |>
    tidyr::drop_na(x, y)

  numberOfPoints <- nrow(data)

  XML::addAttributes(layerRoot,
    speech = "Point graph",
    speech2 = paste("Point graph with", numberOfPoints, "points"),
    type = "Center"
  )

  # Going to provide warning about using unknown shapes
  if (!all(data$shape %in% c(16, 19))) {
    warning("You are using a non default point shape. Currently the location of that point in the webpage is incorrect. The summaring information is unaffected.")
  }

  # Summarise into section when greater than 10 points
  if (numberOfPoints > 5) {
    mean_sd_num <- data |>
      arrange(x) |>
      .AddXMLSummariseGGPlotLayer(function(data) {
        data |>
          dplyr::summarise(mean = mean(y), sd = ifelse(is.na(sd(y)), 0, sd(y)), count = n())
      })

    # Get the order of points
    orderOfIDs <- data.frame(x = data$x, id = 1:length(data$x)) |>
      dplyr::arrange(x) |>
      select(id) |>
      unlist()
    pointGroups <- .SplitData(1:numberOfPoints)

    # For each summarized section create a annotation and return the list of annotations
    mapply(
      function(summarizedSectionNum, summarisedData) {
        # Add summarized section
        desc <- paste(
          "mean:", .AddXMLFormatNumber(summarisedData$mean),
          "sd:", .AddXMLFormatNumber(summarisedData$sd),
          "n:", .AddXMLFormatNumber(summarisedData$count)
        )

        summarizedSectionAnnotation <- .AddXMLAddAnnotation(root,
          summarizedSectionNum,
          id = paste(geomID, letters[summarizedSectionNum], sep = "."),
          kind = "grouped",
          attributes = list(speech = desc)
        )

        # Add individual points
        # Only do so if there are less than 100 points
        # This is because the time taken to add all of the annotations is too long.
        # TODO:: optimize XML interactions to allow more data to be handled.
        if (length(data$x) < 100) {
          pointsNumberToAdd <- orderOfIDs[pointGroups[[summarizedSectionNum]]]
          pointAnnotations <- list()

          pointAnnotations <- lapply(pointsNumberToAdd, function(pointID) {
            i <- match(pointID, pointsNumberToAdd)
            shape <- data$shape[pointID]
            colour <- data$fill[pointID]
            if (is.na(colour)) colour <- "black"
            size <- data$size[pointID]
            desc2 <- paste("Shape:", shape, "colour:", colour[1], "size:", .AddXMLFormatNumber(size))
            .AddXMLAddAnnotation(root,
              position = i,
              id = paste(geomID, pointID, sep = "."),
              attributes =
                list(
                  speech = paste0("(", data$x[pointID], ", ", data$y[pointID], ")"),
                  speech2 = desc2
                )
            )
          })

          .AddXMLAddChildren(summarizedSectionAnnotation, pointAnnotations)
          .AddXMLAddComponents(summarizedSectionAnnotation, pointAnnotations)
          .AddXMLAddParents(summarizedSectionAnnotation, pointAnnotations)
        }
        summarizedSectionAnnotation
      },
      summarizedSectionNum = seq_along(mean_sd_num),
      summarisedData = mean_sd_num,
      SIMPLIFY = FALSE
    )
  } else {
    # If there a so few points just create annotatino for each point and return list
    mapply(
      function(pointNum, pointData) {
        desc <- paste0(
          "(", .AddXMLFormatNumber(pointData$x),
          .AddXMLFormatNumber(pointData$y), ")"
        )
        .AddXMLGGplotGeomItem(root,
          graphObjectStruct,
          position = pointNum,
          id = paste(geomID, pointNum, sep = "."),
          speech = desc
        )
      },
      pointNum = seq_along(data$x),
      pointData = data,
      SIMPLIFY = FALSE
    )
  }
}

.AddXMLAddGGPlotLayer.smooth <- function(root, layerRoot, graphObjectStruct, geomID, panel = 1, summarisedSections = 5, ...) {
  data <- graphObjectStruct$data

  XML::addAttributes(layerRoot,
    speech = "Smoother graph",
    speech2 = paste0("Smoother graph", ifelse(graphObjectStruct$ci, paste(" with", graphObjectStruct$level, "confidence bands"), ""), ""),
    type = "Center"
  )

  if (!graphObjectStruct$ci) {
    data$ymin <- 0
    data$ymax <- 0
  }
  summarisedData <- .AddXMLSummariseGGPlotLayer(data, function(data) {
    data |>
      dplyr::mutate(startX = x, endX = lead(x), startY = y, endY = lead(y)) |>
      dplyr::mutate(CIWidth = ymax - ymin) |>
      tidyr::drop_na() |>
      dplyr::mutate(slope = (startY - endY) / (startX - endX)) |>
      dplyr::summarise(
        min = min(slope), max = max(slope),
        mean = mean(slope), median = median(slope),
        avg_width = mean(CIWidth), median_width = median(CIWidth),
        rangeCI = max(CIWidth) - min(CIWidth)
      ) |>
      as.list()
  })
  # Go thorugh each summarised section and create a annotation for it.
  mapply(
    function(summarisedSectionData, i) {
      sectionDesc <- paste(
        "average slope: ", .AddXMLFormatNumber(summarisedSectionData$mean),
        ifelse(graphObjectStruct$ci, paste("CI width:", .AddXMLFormatNumber(summarisedSectionData$avg_width), ""), "")
      )

      lineDesc <- paste(
        "slope range:", paste0("(", .AddXMLFormatNumber(summarisedSectionData$min), ",", .AddXMLFormatNumber(summarisedSectionData$max), ")"),
        "median slope:", .AddXMLFormatNumber(summarisedSectionData$median)
      )

      ciDesc <- ifelse(graphObjectStruct$ci,
        paste(
          "median CI width:", .AddXMLFormatNumber(summarisedSectionData$median_width),
          "width range:", .AddXMLFormatNumber(summarisedSectionData$rangeCI)
        ), ""
      )


      .AddXMLGGplotGeomItem(root,
        graphObjectStruct,
        position = i,
        id = geomID,
        speech = sectionDesc,
        lineDesc = lineDesc,
        ciDesc = ciDesc,
        layer = graphObjectStruct$layernum
      )
    },
    summarisedSectionData = summarisedData,
    i = seq_along(summarisedData),
    SIMPLIFY = FALSE
  )
}

.AddXMLAddGGPlotLayer.line <- function(root, layerRoot, graphObjectStruct, geomID, panel = 1, summarisedSections = 5, ...) {
  numberOfLines <- length(graphObjectStruct$lines)

  XML::addAttributes(layerRoot,
    speech = "Line graph",
    speech2 = paste("Line graph with", numberOfLines, "lines"),
    # Better to report #lines or #segs?
    # Line can be discontinuous (comprised of polylines 1a, 1b, ...)
    type = "Center"
  )
  # Loop through each line in the layer and create a annotation for each one of them.
  mapply(
    function(lineNum, lineData) {
      lineData <- lineData$scaledata
      disjointLine <- .IsGeomLineDisjoint(lineData)

      # ID of the line g tag
      lineGTagID <- .CreateID(geomID, lineNum)

      ## Create line g tag annotation with descriptions
      lineGTagAnnotation <- .AddXMLAddAnnotation(root,
        position = lineNum,
        id = lineGTagID, kind = "grouped"
      )

      XML::addAttributes(lineGTagAnnotation$root,
        speech = paste("Line", lineNum),
        speech2 = ifelse(disjointLine,
          paste("Line", lineNum, "is disjoint"),
          paste("Line", lineNum, "with", lineData$x |> length() - 1, "segments")
        ),
        type = "Center"
      )


      # Test if the lineData has na and by extension if there will be disjointness
      if (disjointLine) {
        # This bit of code was made iwth help from SO:
        # https://stackoverflow.com/questions/75379649/split-a-df-into-a-list-with-groups-of-values-withouts-nas
        disjointLines <- lineData |>
          group_by(group = cumsum(is.na(y))) |>
          filter(!(is.na(y) & n() > 1)) |>
          group_split() |>
          Filter(function(x) nrow(x) >= 2, x = _)

        numOfDisjointLines <- length(disjointLines)
        lineSeq <- seq_along(disjointLines)
      } else {
        lineSeq <- c(1)
      }

      # Make sure there are enough points to consitute a line
      # If there are then loop through each of the disjoint lines
      # When the line is whole it is simply treated as a special case of a single disjoint line.
      segmentAnnotations <- if (disjointLine && numOfDisjointLines == 0) {
        noLineAnnotation <- .AddXMLAddAnnotation(root,
          position = 1,
          id = geomID, kind = "active"
        )
        XML::addAttributes(noLineAnnotation,
          speech = "There are not enough points for this line to actually be drawn.",
          speech2 = "This means there are less than 2 points without that are sequential to each other in the data"
        )
        noLineAnnotation
      } else {
        # Create annotation for each disjoint line or single whole line
        mapply(
          function(disjointLineIndex) {
            if (disjointLine) {
              lineData <- disjointLines[[disjointLineIndex]]
              lineCount <- lineData$x |> length() - 1

              disjointLineGTag <- paste(geomID, paste0(lineNum, letters[disjointLineIndex]), sep = ".")
              disjointLineAnnotation <- .AddXMLAddAnnotation(root,
                position = disjointLineIndex,
                id = disjointLineGTag, kind = "grouped"
              )
              XML::addAttributes(disjointLineAnnotation$root,
                speech = paste("Disjoint Line", disjointLineIndex),
                speech2 = paste(
                  "Disjoint Line", disjointLineIndex,
                  "with", lineCount, "segments"
                )
              )
            } else {
              lineCount <- nrow(lineData) - 1
            }

            if (lineCount > summarisedSections) {
              slope_Range_Median <- .AddXMLSummariseGGPlotLayer(lineData, function(data) {
                data |>
                  dplyr::mutate(startX = x, endX = lead(x), startY = y, endY = lead(y)) |>
                  tidyr::drop_na() |>
                  dplyr::select(matches("(start|end)\\w")) |>
                  dplyr::mutate(slope = (startY - endY) / (startX - endX)) |>
                  dplyr::summarise(min = min(slope), max = max(slope), median = median(slope)) |>
                  as.list()
              }, overlap = TRUE)
              summarised <- TRUE
              lineCount <- summarisedSections
            } else {
              summarised <- FALSE
              # This just needs some value for the mapply to loop through correctly
              slope_Range_Median <- 1:lineCount
            }

            splitData <- lineData$x |>
              seq_along() |>
              .SplitData(overlapping = TRUE)

            subLineSegmentsAnnotations <- mapply(
              function(i, splitIndices, lineData, summary) {
                if (summarised) {
                  desc <- paste(
                    "slope range",
                    .AddXMLFormatNumber(summary$min),
                    "to",
                    .AddXMLFormatNumber(summary$max),
                    "with median",
                    .AddXMLFormatNumber(summary$median)
                  )
                  desc2 <- paste(
                    "x from ",
                    lineData$x[splitIndices[1]],
                    "to",
                    lineData$x[splitIndices |> tail(n = 1)],
                    "y from ",
                    lineData$y[splitIndices[1]],
                    "to",
                    lineData$y[splitIndices |> tail(n = 1)]
                  )
                } else {
                  desc <- paste(
                    .AddXMLFormatNumber((lineData$y[i + 1] - lineData$y[i]) / (lineData$x[i + 1] - lineData$x[i])),
                    "slope from x",
                    .AddXMLFormatNumber(lineData$x[i]),
                    "to x",
                    .AddXMLFormatNumber(lineData$x[i + 1])
                  )
                  desc2 <- paste0(
                    "line from (",
                    .AddXMLFormatNumber(lineData$x[i]),
                    ",",
                    .AddXMLFormatNumber(lineData$y[i]),
                    ") to (",
                    .AddXMLFormatNumber(lineData$x[i + 1]),
                    ",",
                    .AddXMLFormatNumber(lineData$y[i + 1]),
                    ")"
                  )
                }
                .AddXMLGGplotGeomItem(root,
                  graphObjectStruct,
                  position = i,
                  id = .CreateID(ifelse(disjointLine, disjointLineGTag, lineGTagID), letters[i]),
                  speech = desc, speech2 = desc2
                )
              },
              i = if (summarised) seq_along(splitData) else 1:lineCount,
              splitIndices = splitData,
              summary = slope_Range_Median,
              MoreArgs = list(lineData = lineData),
              SIMPLIFY = FALSE
            ) |>
              suppressWarnings()


            # If there are disjoint lines this loop through mutliple times
            # If not this will looop through once and so it needs to just return the one element
            if (disjointLine) {
              .AddXMLAddComponents(disjointLineAnnotation, subLineSegmentsAnnotations)
              .AddXMLAddChildren(disjointLineAnnotation, subLineSegmentsAnnotations)
              .AddXMLAddParents(disjointLineAnnotation, subLineSegmentsAnnotations)
              disjointLineAnnotation
            } else {
              subLineSegmentsAnnotations
            }
          },
          disjointLineIndex = lineSeq,
          SIMPLIFY = FALSE
        )
      }

      # This is to effectivly delist the segment annotation.
      if (!disjointLine) {
        segmentAnnotations <- segmentAnnotations[[1]]
      }

      .AddXMLAddComponents(lineGTagAnnotation, segmentAnnotations)
      .AddXMLAddChildren(lineGTagAnnotation, segmentAnnotations)
      .AddXMLAddParents(lineGTagAnnotation, segmentAnnotations)
      lineGTagAnnotation
    },
    lineNum = seq_along(graphObjectStruct$lines),
    lineData = graphObjectStruct$lines,
    SIMPLIFY = FALSE
  )
}

.AddXMLAddGGPlotLayer.bar <- function(root, layerRoot, graphObjectStruct, geomID, panel = 1, summarisedSections = 5, ...) {
  data <- graphObjectStruct$data

  barCount <- nrow(data)

  XML::addAttributes(layerRoot,
    speech = "Bar graph",
    speech2 = paste("Bar graph with", barCount, "bars"),
    type = "Center"
  )

  # TODO: histogram bars have density but other geom_bar objects won't
  # Need to not fail if density not present
  # Generally, need to deal with missing values better
  mapply(
    function(i, x, y, ymax, ymin, xmin, xmax, density) {
      barId <- .CreateID(geomID, i)
      # If no density values then assume it's a categorical x-axis
      .AddXMLGGplotGeomItem(
        root,
        graphObjectStruct,
        position = i,
        x = signif(x, 4),
        count = ymax - ymin,
        density = ifelse(is.null(density), NA, density[i]),
        start = signif(xmin, 4),
        end = signif(xmax, 4),
        id = barId,
        categorical = is.null(density)
      )
    },
    i = seq_along(data$y),
    x = data$x,
    y = data$y,
    ymax = data$ymax, ymin = data$ymin,
    xmax = data$xmax, xmin = data$xmin,
    MoreArgs = (list(density = data$density)),
    SIMPLIFY = FALSE
  )
}

.AddXMLAddGGPlotLayer.default <- function(root, layerRoot, graphObjectStruct, geomID, panel = 1, summarisedSections = 5, ...) {
  warning("This layer type: ", class(graphObjectStruct), " is not supported by MakeAccessibleSVG")
  return(invisible())
}


#' Add geom item to the XML
#'
#' These functions are used by the .AddXMLAddGGplotLayer functions
#' There should be one function for each of the layer types.
#'
#' For some of them they are quite simple so they are defered to other types.
#' For other ones they can be quite complex.
#'
#' @param root This the the annotation root of the document
#' @param position The position of the item
#' @param id the text which will be in the first element which is a active/grouped etc tag.
#' @param speech The first description of the annotation
#' @param speech2 The second slightly more detailed description. Or it can be used to tell different information.
#' @param ... Extra parameters for particular types.
#' @param graphObject This is what the dispatch is run on.
#'
#' @return Wil return invisibly the annotation object as there are cases where it is
#' just the side effects you are after.
.AddXMLGGplotGeomItem <- function(root, graphObject, position = 1, id = NULL, speech, speech2 = speech, ...) {
  UseMethod(".AddXMLGGplotGeomItem", graphObject)
}

.AddXMLGGplotGeomItem.default <- function(root, graphObject, position = 1, id = NULL, speech, speech2 = speech, ...) {
  stop("This type is not supported: ", class(graphObject))
}

.AddXMLGGplotGeomItem.smooth <- function(root, graphObject, position = 1, id = NULL, speech, speech2 = speech, lineDesc, ciDesc, layer) {
  annotation <- .AddXMLAddAnnotation(root, position = position, id = paste(id, letters[position], sep = "."), kind = "grouped")
  XML::addAttributes(annotation$root, speech = speech, speech2 = speech2)

  # Add in a reference to the seGrob if it exists
  items <- .AddXMLAddAnnotation(root, 1,
    id = .CreateID(layer, "smoother_line", letters[position]),
    attributes = list(speech = lineDesc)
  ) |>
    list()
  if (ciDesc != "") {
    items <- .AddXMLAddAnnotation(root, 2,
      id = .CreateID(layer, "smoother_ci", letters[position]),
      attributes = list(speech = ciDesc)
    ) |>
      list() |>
      append(items, values = _)
  }

  .AddXMLAddChildren(annotation, items)
  .AddXMLAddComponents(annotation, items)
  .AddXMLAddParents(annotation, items)

  return(invisible(annotation))
}

.AddXMLGGplotGeomItem.point <- function(root, graphObject, position = 1, id = NULL, speech, speech2 = speech, ...) {
  annotation <- .AddXMLAddAnnotation(root, position = position, id = id, kind = "active")
  XML::addAttributes(annotation$root, speech = speech, speech2 = speech)
  return(invisible(annotation))
}

.AddXMLGGplotGeomItem.bar <- function(root, graphObject, position = 1, id = NULL, speech, speech2 = speech,
                                      x = NULL, count = NULL, density = NULL, start = NULL, end = NULL,
                                      categorical = TRUE) {
  rectId <- ifelse(is.null(id), .AddXMLmakeId("rect", .CreateID("1.1", position)), id)
  annotation <- .AddXMLAddAnnotation(root,
    position = position,
    id = rectId,
    kind = "active"
  )

  if (categorical) {
    XML::addAttributes(annotation$root,
      speech = paste("Bar", position, "at", x, "with value", count),
      speech2 = paste("Bar", position, "at x value", x, " with y value", count),
      type = "Bar"
    )
  } else {
    XML::addAttributes(annotation$root,
      speech = paste("Bar", position, "at", x, "with value", count),
      speech2 = paste(
        "Bar", position, "between x values", start,
        "and", end, " with y value", count, "and density", signif(density, 3)
      ),
      type = "Bar"
    )
  }
  return(invisible(annotation))
}

.AddXMLGGplotGeomItem.line <- function(root, graphObject, position = 1, id = NULL, speech, speech2 = speech) {
  return(.AddXMLGGplotGeomItem.point(root, graphObject, position, id, speech, speech2))
}

## Auxiliary methods for annotations
##
## Construct a gridSVG id.
.AddXMLmakeId <- function(...) {
  paste("graphics-plot-1", ..., sep = "-")
}

## Construct an SRE annotation element.
.AddXMLAddAnnotation <- function(root, position = 1, id = "", kind = "active", attributes = NULL) {
  children <- list(
    element = .AddXMLAddNode(NULL, kind, id),
    position = .AddXMLAddNode(NULL, "position", position),
    parents = .AddXMLAddNode(NULL, "parents"),
    children = .AddXMLAddNode(NULL, "children"),
    component = .AddXMLAddNode(NULL, "component"),
    neighbours = .AddXMLAddNode(NULL, "neighbours")
  )

  annotation <- .AddXMLAddNode(root, "annotation", children = children, attrs = attributes)

  node <- list(
    root = annotation,
    element = children$element,
    position = children$position,
    parents = children$parents,
    children = children$children,
    component = children$component,
    neighbours = children$neighbours
  )

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
.AddXMLAddNode <- function(root, tag, content = NULL, children = list(content), attrs = NULL) {
  node <- XML::newXMLNode(paste("sre:", tag, sep = ""),
    content,
    parent = root,
    .children = children,
    attrs = attrs
  )
  return(invisible(node))
}

# A shallow clone function for leaf nodes only. Avoids problems with duplicating
# namespaces.
.AddXMLclone <- function(root, node) {
  newNode <- XML::newXMLNode(XML::xmlName(node, full = TRUE), XML::xmlValue(node), parent = root)
  return(invisible(newNode))
}

## Add components to an annotation
.AddXMLAddComponents <- function(annotation, nodes) {
  clone <- function(x) {
    .AddXMLclone(annotation$component, x$element)
  }
  lapply(nodes, clone)
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
  if (!is.nan(x) & ifelse(abs(x) < 1, nchar(as.character((abs(x)))) - 2, nchar(as.character((abs(x))))) > 8) {
    useScientific <- TRUE
  } else {
    useScientific <- FALSE
  }
  format(x, digits = 4, scientific = useScientific)
}

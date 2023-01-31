#' Rewrite a SVG so that it cna be properly explored with diagcess via the XML.
#'
#' @param x The graph object that the svg comes from
#' @param file The file of the SVG
#' @param type This should be a ojbect of the class of geom you are trying to rewrite
#' the svg for.
#' @return NULL
#'
.RewriteSVG <- function(x, file, type, ...) {
  UseMethod(".RewriteSVG", type)
}

.RewriteSVG.default <- function(x, file, type, ...) {
  # Nothing is to be done by deafult
}

.RewriteSVG.GeomLine <- function(x, file, type, layer = 1) {
  parentPolylineID <- .GetGeomID(type)
  svgDoc <- XML::xmlParseDoc(file)
  parentPolyline <- XML::getNodeSet(
    svgDoc,
    paste0('//*[@id="', parentPolylineID, '"]')
  )[[1]]

  # Need to figure out how many lines there are
  struct <- .VIstruct.ggplot(x)
  numLines <- struct[["panels"]][[1]][["panellayers"]][[layer]][["lines"]] |> length()

  for (lineNum in 1:numLines) {
    # Will grab the correct polyline as there will be a text and polyline for each line.
    # The poly line gets deleted at end of this loop
    # So the next polyine will always be + 1 the line number
    actualPolyLine <- XML::xmlChildren(parentPolyline)[[lineNum + 1]]

    # Get the g tag for the line for the segments to go into
    segmentParentGTag <- XML::newXMLNode("g",
      parent = parentPolyline,
      attrs = list(id = paste(parentPolylineID, lineNum, sep = "."))
    )
    XML::addChildren(parentPolyline, segmentParentGTag)

    # Split the line into smaller polylines

    ## Copy attributes from the original segment
    lineAttr <- XML::xmlAttrs(actualPolyLine)
    lineAttr <- lineAttr[!(names(lineAttr) %in% c("id", "points"))]
    lineAttr <- split(lineAttr, names(lineAttr))

    ## Get the line points
    coordinates <- XML::xmlGetAttr(actualPolyLine, "points") |>
      strsplit(" ") |>
      unlist()

    ## There could a unknown number of points
    mins_maxs <- length(coordinates) |>
      .GetSummarizedAmounts()

    numberOfBreaks <- mins_maxs$min |> length() + 1
    ## For each segment add in a new poly line with all the correct attributes
    1:(numberOfBreaks - 1) |>
      lapply(function(i) {
        segmentCoords <- coordinates[mins_maxs$mins[i]:mins_maxs$maxs[i]]

        args <- lineAttr
        args$id <- paste(parentPolylineID, lineNum, letters[i], sep = ".")
        args$`fill-opacity` <- "0"
        args$points <- paste(segmentCoords, collapse = " ")

        newPolyline <- XML::newXMLNode("polyline", parent = segmentParentGTag, attrs = args)

        XML::addChildren(segmentParentGTag, newPolyline)
      })

    # Remove old line
    XML::removeChildren(parentPolyline, actualPolyLine)
  }
  # Save modified svg doc
  XML::saveXML(svgDoc, file = file)
}

.RewriteSVG.GeomPoint <- function(x, file, type, layer = 1) {
  svgDoc <- XML::xmlParseDoc(file)

  parentgeomPointID <- .GetGeomID(type)

  parentGTag <- XML::getNodeSet(
    svgDoc,
    paste0('//*[@id="', parentgeomPointID, '"]')
  )[[1]]

  pointNodes <- XML::xmlChildren(parentGTag)

  structLayer <- .VIstruct.ggplot(x)[["panels"]][[1]][["panellayers"]][[layer]][["scaledata"]]
  numPoints <- structLayer$x |> length()

  orderOfIDs <- data.frame(x = structLayer$x, id = 1:numPoints) |>
    dplyr::arrange(x) |>
    select(id) |>
    unlist()

  mins_maxs <- .GetSummarizedAmounts(numPoints)
  numberOfSummarizedSections <- mins_maxs$mins |> length()
  # Only summarized the points if there are atelast 5 summarized secionts
  if (numPoints > 5) {
    # For each section go through get all of the use tags that should be in
    # The section and move them there
    for (sectionNum in 1:numberOfSummarizedSections) {
      # Create new section tag
      newSectionGTag <- XML::newXMLNode("g",
        parent = parentGTag,
        attrs = list(id = paste(parentgeomPointID, letters[sectionNum], sep = "."))
      )
      XML::addChildren(parentGTag, newSectionGTag)
      for (pointNum in orderOfIDs[mins_maxs$min[sectionNum]:mins_maxs$max[sectionNum]]) {
        # Move node
        pointNode <- pointNodes[[pointNum * 2]]
        XML::addChildren(newSectionGTag, pointNode)
      }
    }
  }
  # Save modified svg doc
  XML::saveXML(svgDoc, file = file)
}

.RewriteSVG.tsplot <- function(x, file) {
  svgDoc <- XML::xmlParseDoc(file) ## "Temperature.svg"
  nodes <- XML::getNodeSet(
    svgDoc,
    '//*[@id="graphics-plot-1-lines-1.1"]'
  )
  if (length(nodes) == 0) {
    return(invisible("Something went wrong!"))
  }
  .SplitPolyline(x$GroupSummaries$N, nodes[[1]])
  XML::saveXML(svgDoc, file = file)
  return(invisible(NULL))
}

# vs Currently we hardcode the attributes. Should simply be copied.
.SplitPolyline <- function(points, root, start = 0, child = 1) {
  children <- XML::getNodeSet(root, "//*[@points]")
  polyline <- children[[child]]
  attr <- XML::xmlGetAttr(polyline, "points")
  coordinates <- strsplit(attr, " ")[[1]]
  count <- 1
  ## result <- list()
  for (i in 1:length(points)) {
    node <- XML::newXMLNode("polyline", parent = root)
    end <- count + points[i]
    segment <- coordinates[count:end]
    XML::addAttributes(
      node,
      id = paste("graphics-plot-1-lines-1.1.1", intToUtf8(utf8ToInt("a") + (i - 1)), sep = ""),
      points = paste(segment[!is.na(segment)], collapse = " "),
      "stroke-dasharray" = "none",
      stroke = "rgb(0,0,0)",
      "stroke-width" = "1",
      "stroke-linecap" = "round",
      "stroke-miterlimit" = "10",
      "stroke-linejoin" = "round",
      "stroke-opacity" = "1",
      fill = "none"
    )
    XML::addChildren(root, node, at = i + (child - 1))
    count <- end
  }
  XML::removeChildren(root, polyline)
  return(invisible(NULL))
}

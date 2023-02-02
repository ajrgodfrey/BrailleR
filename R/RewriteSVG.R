#' Rewrite a SVG so that it cna be properly explored with diagcess via the XML.
#' @rdname .RewriteSVG
#' The Rewrite SVG is a wrapper around the .RewrtieSVGGeom function. THis function provides
#' the actual work of the rewriting.
#'
#' @param x The graph object that the svg comes from
#' @param file The file of the SVG
#' @param type This should be a ojbect of the class of geom you are trying to rewrite
#' the svg for.
#' @return NULL
#'
.RewriteSVG <- function(x, file, type, ...) {
  svgDoc <- XML::xmlParseDoc(file)

  geomGTagID <- .GetGeomID(type)
  if (is.null(geomGTagID)) {
    return()
  }
  geomGTag <- XML::getNodeSet(
    svgDoc,
    paste0('//*[@id="', geomGTagID, '"]')
  )[[1]]

  .RewriteSVGGeom(x, type, geomGTagID, geomGTag, ...)

  XML::saveXML(svgDoc, file = file)

  return(invisible())
}

.RewriteSVGGeom.default <- function(x, type, geomGTagID, geomGTag, ...) {
  # Nothing is to be done by deafult
}

#' @rdname .RewriteSVG
#'
#' The internal workhorse of the RewriteSVG function. These functions have all the specific
#' things that need to be done with the SVG to make it properly accessible.
#' Most of these functions have something has to line up with the AddXML internal functions.
#'
#' @param geomGTagID Id of the geomGTag
#' @param geomGTag This is the g tag with which all of this layers geom tags are inside
#' @param ... Any other variables needed by the function.
#'
.RewriteSVGGeom <- function(x, type, geomGTagID, geomGTag, ...) {
  UseMethod(".RewriteSVGGeom", type)
}

.RewriteSVGGeom.GeomLine <- function(x, type, geomGTagID, geomGTag, layer = 1) {
  # Need to figure out how many lines there are
  numLines <- .VIstruct.ggplot(x)[["panels"]][[1]][["panellayers"]][[layer]][["lines"]] |>
    length()

  for (lineNum in 1:numLines) {
    # Will grab the correct polyline as there will be a text and polyline for each line.
    # The poly line gets deleted at end of this loop
    # So the next polyine will always be + 1 the line number
    actualPolyLine <- XML::xmlChildren(geomGTag)[[lineNum + 1]]

    # Get the g tag for the line for the segments to go into
    segmentParentGTagID <- paste(geomGTagID, lineNum, sep = ".")
    segmentParentGTag <- XML::newXMLNode("g",
      parent = geomGTag,
      attrs = list(id = segmentParentGTagID)
    )
    XML::addChildren(geomGTag, segmentParentGTag)

    # Split the line into smaller polylines
    .RewriteSVG_SplitPoly(segmentParentGTag,
      actualPolyLine,
      id = segmentParentGTagID
    )
  }
}

.RewriteSVGGeom.GeomPoint <- function(x, type, geomGTagID, geomGTag, layer = 1) {
  pointNodes <- XML::xmlChildren(geomGTag)

  structLayer <- .VIstruct.ggplot(x)[["panels"]][[1]][["panellayers"]][[layer]][["scaledata"]]
  numPoints <- structLayer$x |> length()

  orderOfIDs <- data.frame(x = structLayer$x, id = 1:numPoints) |>
    dplyr::arrange(x) |>
    select(id) |>
    unlist()

  pointGroups <- .SplitData(orderOfIDs)
  # Only summarized the points if there are atelast 5 summarized secionts
  if (numPoints > 5) {
    # For each section go through get all of the use tags that should be in
    # The section and move them there
    for (sectionNum in 1:length(pointGroups)) {
      # Create new section tag
      newSectionGTag <- XML::newXMLNode("g",
        parent = geomGTag,
        attrs = list(id = paste(
          geomGTagID,
          letters[sectionNum],
          sep = "."
        ))
      )

      pointNodes[pointGroups[[sectionNum]] * 2] |>
        XML::addChildren(newSectionGTag, kids = _)
    }
  }
}

.RewriteSVGGeom.GeomSmooth <- function(x, type, geomGTagID, geomGTag, layer = 1) {
  ribbonAndLine <- XML::xmlChildren(geomGTag)
  ## Checking to see if it has a SE ribbon around the fitted line.
  if (length(ribbonAndLine) == 3) {
    hasCI <- FALSE
  } else {
    hasCI <- TRUE
    ## Split up the CI polygon into 5 polygons
    ribbonGTag <- ribbonAndLine[[2]]

    polygonGTag <- XML::xmlChildren(ribbonGTag)[[2]]
    polygonGTagID <- XML::xmlGetAttr(polygonGTag, "id")

    polygonTag <- XML::xmlChildren(polygonGTag)$polygon
    # Update the stroke so that when it is changed colour by Diagcess on selection
    # it will actually be highlighted
    XML::`xmlAttrs<-`(polygonTag, value = c(`stroke-opacity` = 0.4, `stroke-width` = 0.4))

    .RewriteSVG_SplitPoly(polygonGTag, polygonTag, id = "ci", type = "polygon")

    ## Move polygon to base geomGTag
    XML::addChildren(geomGTag, polygonGTag)
    XML::removeChildren(geomGTag, ribbonGTag)
  }


  ## Split up the line into subparts
  polylineGTag <- ribbonAndLine[[ifelse(hasCI, 4, 2)]]
  polylineGTagID <- XML::xmlGetAttr(polylineGTag, "id")

  polylineTag <- XML::xmlChildren(polylineGTag)$polyline

  .RewriteSVG_SplitPoly(polylineGTag, polylineTag, id = "line")

  ## Take the 2 g tag with 5 polygon/polyline tags inside each of them.
  ## I want to zip them together so that I have 5 g tags with a polyline and polygon in each of them.
  if (hasCI) {
    # There are always two text elements at the start of the list. These ought
    # to be removed
    polygons <- XML::xmlChildren(polygonGTag)[3:7]
    polylines <- XML::xmlChildren(polylineGTag)[3:7]

    mapply(
      function(index, polygon, polyline, parentGTag, IDBase) {
        # New node as child of the Geom g tag
        XML::newXMLNode("g",
          polygon, polyline,
          attrs = list(id = paste(IDBase, letters[index], sep = ".")),
          parent = parentGTag
        )
      },
      1:length(polygons), polygons, polylines,
      MoreArgs = list(parentGTag = geomGTag, IDBase = geomGTagID)
    )

    # Remove the old polygon and polyline
    XML::removeChildren(geomGTag, polylineGTag, polygonGTag)
  }
}


#' @rdname .RewriteSVG
#'
#' This is used to split both polylines and polygons. It will behave slightly differently depending on the parameter.
#' However by default it will split a polyline.
#'
#' @param parentGTag This is the parent g tag which the new polylines will be children of
#' @param id The id of the new polyline. The id of these new polylines will be the argument with a letter added to end.
#' @param originalPoly original poly that you wish to split up.
#' @param type Type of the poly it is currently only support for polygon and polyline
#'
#' @return Returns nothing
#'
.RewriteSVG_SplitPoly <- function(parentGTag, originalPoly, id = "", type = "polyline") {
  ## Copy attributes from the original segment
  lineAttr <- XML::xmlAttrs(originalPoly)
  lineAttr <- lineAttr[!(names(lineAttr) %in% c("id", "points"))]
  lineAttr <- split(lineAttr, names(lineAttr))

  ## Get the line points
  points <- originalPoly |>
    XML::xmlGetAttr("points") |>
    strsplit(" ") |>
    unlist()
  nSections <- ifelse(length(points) > 5, 5, length(points))

  if (type == "polyline") {
    pointsSplit <- .SplitData(points, overlapping = TRUE)
  } else if (type == "polygon") {
    # Polygon points start and work there way round the outside
    # I will split this into top and bottom
    pointsTopAndBottom <-
      # Split the data into top and bottom
      split(
        points,
        cut(seq_along(points),
          2,
          labels = FALSE,
          include.lowest = TRUE
        )
      ) |>
      # Split each top and bottom section into sections
      lapply(function(points) {
        split(
          points,
          cut(seq_along(points),
            nSections,
            labels = FALSE,
            include.lowest = TRUE
          )
        )
      }) |>
      # Go through the top and bottom and add one point from the next seciton
      # This is so there will be a continous polygon
      lapply(function(pointsCollection) {
        pointsCollection |>
          seq_along() |>
          lapply(function(i) {
            if (i != length(pointsCollection)) {
              c(pointsCollection[[i]], pointsCollection[[i + 1]][1])
            } else {
              pointsCollection[[i]]
            }
          })
      })

    # As the points go aroudn the permiter the top needs to be reversed so that
    # it starts at the lower end.
    pointsTopAndBottom[[2]] <- rev(pointsTopAndBottom[[2]])

    # Combine the top and bottom sections so that you just have nsection number
    # of sections with top and bottom coordinates
    pointsSplit <- mapply(c,
      pointsTopAndBottom[[1]],
      pointsTopAndBottom[[2]],
      SIMPLIFY = FALSE
    )
  } else {
    warning(paste("Sorry type '", type, "' is not supported yet"))
  }


  ## For each segment add in a new poly with all the correct attributes
  seq_along(pointsSplit) |>
    lapply(function(i) {
      args <- lineAttr
      args$id <- paste(id, letters[i], sep = ".")
      if (type == "polyline") args$`fill-opacity` <- "0"
      args$points <- paste(pointsSplit[[i]], collapse = " ")

      newPolyline <- XML::newXMLNode(type, parent = parentGTag, attrs = args)

      XML::addChildren(parentGTag, newPolyline)
    })

  ## Remove old line
  XML::removeNodes(originalPoly)

  return(invisible())
}

# vs Currently we hardcode the attributes. Should simply be copied.
# Old functions only held for backwards support with base R
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

.RewriteSVGGeom.tsplot <- function(x, file) {
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

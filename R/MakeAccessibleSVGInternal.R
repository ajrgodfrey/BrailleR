#' This r file is to be a store for all of the fucntions that are used when making
#' the xml and svg then putting it togather. It is only for functions that are
#' used by both the svg and xml pathways


#' Search graphic for ID of Geom
#' @rdname MakeAccessibleSVGInternal
#' This can be used by the AddXML function as well as SVG functions to know how to
#' modify and create the XML / svg. These IDs are the link that is between the XML and the SVG
#'
#' It is very important to remember that the graph must be current plotted for the
#' grid.grep style commands to work
#'
#' @param graphObject The graph object you want to be getting the id from
#' @param layer Which layer is this geom.
#'
#' @return A ID string that is the overall string needed in the svg and xml
#' If there are many elements then it is the most overarching selection
.GetGeomID <- function(graphObject, layer = 1) {
  graphLayers <- graphObject$layers

  thisLayerIDBase <- graphLayers[[layer]]$geom |>
    .GetGeomIDBase()

  if (is.null(thisLayerIDBase)) {
    return()
  }

  geomGrobs <- grid.grep(gPath("panel", "panel-1", thisLayerIDBase), grep = TRUE, global = TRUE) |>
    Filter(function(element) {
      element$n == 4
    }, x = _)

  numberOfPreviousMatches <- if (layer == 1) {
    # No previous matches if this is the first layer
    0
  } else {
    graphLayers[1:(layer - 1)] |>
      lapply(function(layer) {
        thisLayerIDBase == .GetGeomIDBase(layer$geom)
      }) |>
      unlist() |>
      sum()
  }
  geomGrob <- geomGrobs[[numberOfPreviousMatches + 1]]

  # Always need to add the .1 to the end.
  .CreateID(geomGrob$name, "1")
}
#' @rdname MakeAccessibleSVgInternal
#'
#' This is more or less a dictionary that will return what the base g tag
#' Id for the geom will start with.
#'
#' For Example a geom_line layer will have a g tag that starts with GRID.poyline
#' This function is used by the .GetGeomID to get the correct layers base g tag id.
#'
#' @param layerClass The geom object that has the layer class.
#'
.GetGeomIDBase <- function(layerClass) {
  UseMethod(".GetGeomIDBase")
}

.GetGeomIDBase.default <- function(layerClass) {
  # Nothing to happen on return
}

.GetGeomIDBase.GeomLine <- function(layerClass) {
  return("GRID.polyline")
}

.GetGeomIDBase.GeomPoint <- function(layerClass) {
  return("geom_point")
}

.GetGeomIDBase.GeomSmooth <- function(layerClass) {
  return("geom_smooth")
}

.GetGeomIDBase.GeomBar <- function(layerClass) {
  return("geom_rect")
}

#' @rdname MakeAccessibleSVGInternal
#'
#' Split a vector into a certain number of sections with either overlapping or not.
#'
#' @param overlapping Whether the data should overlap on the upper breaks.
#' This is needed by the svg tags.
#' @param dataToBeSplit A vector of numbers to be split
.SplitData <- function(dataToBeSplit, overlapping = FALSE) {
  nSections <- 5
  pointsSplit <- split(
    dataToBeSplit,
    cut(seq_along(dataToBeSplit),
      nSections,
      labels = FALSE,
      include.lowest = TRUE
    )
  )
  if (overlapping) {
    pointsSplit |>
      seq_along() |>
      lapply(function(i) {
        if (i != length(pointsSplit)) {
          c(pointsSplit[[i]], pointsSplit[[i + 1]][1])
        } else {
          pointsSplit[[i]]
        }
      })
  } else {
    pointsSplit
  }
}

#' Create label from parts
#'
#' This shold be used rather than doing a manual paste to help prevent any changes
#' in the future from being to damaging.
#'
#' @param ... These should be strings to be added togather
.CreateID <- function(...) {
  paste(..., sep = ".")
}

#' Find out if a GeomLine line is disjoint
#'
#' Given the scale data for a line find out if it is disjoint or not.
#'
#' @param scaleData Scale data from the ggplot_build object. Can easily be retirieved
#' from the .VIStruct
#'
#' @return A Boolean value as to whether this line from the line data is disjoint.
.IsGeomLineDisjoint <- function(scaledata) {
  any(is.na(scaledata$y))
}

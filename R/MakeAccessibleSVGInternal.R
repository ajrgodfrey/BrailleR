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
#' @param x This is the object with the class you want to use
#' @param layer Which layer is this geom.
#' @param ...  These are extra paramter that might be needed for particular geoms
#'
#' @return A ID string that is the overall string needed in the svg and xml
#' If there are many elements then it is the most overarching selection
.GetGeomID <- function(x, layer = 1, ...) {
  UseMethod(".GetGeomID")
}

.GetGeomID.default <- function(x, layer = 1, ...) {
  # By default we dont know what it is
}

.GetGeomID.GeomLine <- function(x, layer = 1, ...) {
  lineGrob <- grid.grep(gPath("panel", "panel-1", "GRID.polyline"), grep = TRUE, global = TRUE)[[1]]
  paste(lineGrob$name, "1", sep = ".")
}

.GetGeomID.GeomPoint <- function(x, layer = 1, ...) {
  pointGrob <- grid.grep(gPath("panel", "panel-1", "geom_point"), grep = TRUE, global = TRUE)[[layer]]
  paste(pointGrob$name, "1", sep = ".")
}

.GetGeomID.GeomSmooth <- function(x, layer = 1, ...) {
  smoothGrob <- grid.grep(gPath("panel", "panel-1", "geom_smooth"), grep = TRUE, global = TRUE)[[layer]]
  paste(smoothGrob$name, "1", sep = ".")
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

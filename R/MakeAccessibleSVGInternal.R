#' This r file is to be a store for all of the fucntions that are used when making
#' the xml and svg then putting it togather. It is only for functions that are
#' used by both the svg and xml pathways


#' Search graphic for ID of Geom
#'
#' This can be used by the AddXML function as well as SVG functions to know how to
#' modify and create the XML / svg. These IDs are the link that is between the XML and the SVG
#'
#' It is very important to remember that the graph must be current plotted for the
#' grid.grep style commands to work
#'
#' @param x This is the object with the class you want to use
#'
#' @return A ID string that is the overall string needed in the svg and xml
#' If there are many elements then it is the most overarching selection
.GetGeomID <- function(x, ...) {
  UseMethod(".GetGeomID")
}

.GetGeomID.GeomLine <- function(x, ...) {
  # Currently hard coded to get the first layer will need to change later
  lineGrob <- grid.grep(gPath("panel", "panel-1", "GRID.polyline"), grep = TRUE, global = TRUE)[[1]]
  paste(lineGrob$name, "1", sep = ".")
}


#' Get summarized counts for a length
#'
#' @param numberOfDataPoints This is the number of data points that are to be
#' put into groups
#'
#' @return A list with 2 vectors. There is a mins and a max vecotr. These vectors
#' are where the sections start and stop. The max will be the same as the next min.
#' Theses numbers will be returned as rank indices rather than the actual data.
#'
#'

.GetSummarizedAmounts <- function(numberOfDataPoints, numberOfSections = 5) {
  UseMethod(".GetSummarizedAmounts")
}

.GetSummarizedAmounts.default <- function(numberOfDataPoints, numberOfSections = 5) {
  if (numberOfDataPoints > 5) {
    breaks <- seq(1, numberOfDataPoints, length.out = numberOfSections + 1)
    mins <- breaks[1:(numberOfSections)]
    maxs <- breaks[2:(numberOfSections + 1)]

    list(mins = mins, maxs = maxs) |> lapply(round)
  } else {
    list(mins = 1:(numberOfDataPoints - 1), maxs = 2:numberOfDataPoints)
  }
}

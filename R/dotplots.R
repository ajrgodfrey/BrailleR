dotplot = function(x, ...) {
            UseMethod("dotplot")
          }

dotplot.default =
    function(x, ...) {
      warning(
          "The dotplot command is a wrapper for stripchart, and is not a base R function.")
      MC <- match.call(expand.dots = TRUE)
      MC[[1L]] <- quote(graphics::stripchart)
      names(MC)[2] = ""
      Out <- eval(MC, parent.frame())
      if (length(MC$vertical) > 0) {
        Out$vertical = as.logical(MC$vertical)
      } else {
        Out$vertical = FALSE
      }
      Out$vals = list(sort(x))
      Out$main = as.character(MC$main)
      # then overwrite if user has specified (even if in error)
      if (length(MC$group.names) > 0)
        Out$group.names = as.character(MC$group.names)
      if (length(MC$dlab) > 0) Out$dlab = as.character(MC$dlab)
      if (length(MC$glab) > 0) Out$glab = as.character(MC$glab)
      if (length(MC$xlab) > 0) Out$xlab = as.character(MC$xlab)
      if (length(MC$ylab) > 0) Out$ylab = as.character(MC$ylab)
      Out$call = MC
      Out$xaxp = par()$xaxp
      Out$yaxp = par()$yaxp
      class(Out) = "dotplot"
      return(invisible(Out))
    }


dotplot.formula =
    function(x, ...) {
      warning(
          "The dotplot command is a wrapper for stripchart, and is not a base R function.")
      MC <- match.call(expand.dots = TRUE)
      MC[[1L]] <- quote(graphics::stripchart)
      names(MC)[2] = ""
      Out <- eval(MC, parent.frame())
      if (length(MC$vertical) > 0) {
        Out$vertical = as.logical(MC$vertical)
      } else {
        Out$vertical = FALSE
      }
      Temp = aggregate(x, FUN = sort)
      Out$vals = Temp[[2]]
      names(Out$vals) = Temp[[1]]
      # formula assigns glab which is old school
      Out$main = as.character(MC$main)
      # then overwrite if user has specified (even if in error)
      if (length(MC$group.names) > 0)
        Out$group.names = as.character(MC$group.names)
      if (length(MC$dlab) > 0) Out$dlab = as.character(MC$dlab)
      if (length(MC$glab) > 0) Out$glab = as.character(MC$glab)
      if (length(MC$xlab) > 0) Out$xlab = as.character(MC$xlab)
      if (length(MC$ylab) > 0) Out$ylab = as.character(MC$ylab)
      Out$call = MC
      Out$xaxp = par()$xaxp
      Out$yaxp = par()$yaxp
      class(Out) = "dotplot"
      return(invisible(Out))
    }


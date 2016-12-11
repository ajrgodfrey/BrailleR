boxplot =
    function(x, ...) {
      MC <- match.call(expand.dots = TRUE)
      MC[[1L]] <- quote(graphics::boxplot)
      names(MC)[2] = ""
      Out <- eval(MC, parent.frame())
      Out$main = as.character(MC$main)
      if (length(MC$horizontal) > 0) {
        Out$horizontal = as.logical(MC$horizontal)
      } else {
        Out$horizontal = FALSE
      }
      # then overwrite if user has specified (even if in error)
      if (length(MC$xlab) > 0) Out$xlab = as.character(MC$xlab)
      if (length(MC$ylab) > 0) Out$ylab = as.character(MC$ylab)
      Out$call = MC
      class(Out) = "boxplot"
      Out=Augment(Out)
      return(invisible(Out))
    }


hist = function(x, ...) {
         MC <- match.call(expand.dots = TRUE)
         MC[[1L]] <- quote(graphics::hist)
         Out <- eval(MC, parent.frame())
         if (length(MC$main) > 0) Out$main = as.character(MC$main)
         if (length(MC$xlab) > 0) Out$xlab = as.character(MC$xlab)
         if (length(MC$ylab) > 0) Out$ylab = as.character(MC$ylab)
         Out=Augment(Out)
         return(invisible(Out))
       }

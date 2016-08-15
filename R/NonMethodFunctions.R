
VI.hist =
    function(...) {
      args = list(...)
      VI(hist(...))
      if (!is.null(args$xlab)) {
        cat(paste("N.B. The default text for the x axis has been replaced by: ",
                  args$xlab, "\n", sep = ""))
        cat("\n")
      }
      if (!is.null(args$ylab)) {
        cat(paste("N.B. The default text for the y axis has been replaced by: ",
                  args$ylab, "\n", sep = ""))
        cat("\n")
      }
    }

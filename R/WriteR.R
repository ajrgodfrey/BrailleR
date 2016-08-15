# Running the WriteR application
# only for Windows users at present.

WriteR =
    function(file = NULL, math = c("webTeX", "MathJax")) {
      if (interactive()) {
        if (.Platform$OS.type == "windows") {
          if (Sys.which("python") != "") {
            if (!is.null(file)) {
              if (!file.exists(file)) {
                cat("Starting new file\n", file = file)
              }
            }
            shell(paste(file.path(system.file(
                            "Python/WriteR/WriteR.pyw", package = "BrailleR")),
                        ifelse(is.null(file), "", file)))
          } else {
            warning(
                "This function requires an installation of Python 2.7 and wxPython 2.8.\n")
          }
        } else {
          warning(
              "This function is for users running R under the Windows operating system.\n")
        }
      } else {
        warning("This function is meant for use in interactive mode only.\n")
      }
      return(invisible(NULL))
    }


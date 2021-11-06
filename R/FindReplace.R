FindReplace =
    function(file, find, replace) {
      if (file.exists(file)) {
        cat("\n", file = file, append = TRUE)  # otherwise warnings returned on
                                               # readLines() below
        OldText <- readLines(con = file)
        NoLines = length(OldText)
        if (NoLines > 2) {
          if (all(OldText[c(NoLines - 1, NoLines)] == "\n")) {
            NoLines = NoLines - 1
          }
        }
        writeLines(gsub(find, replace, OldText, fixed=TRUE)[1:NoLines], con = file)
      } else {
        .FileNotFound()
      }
      return(invisible(NULL))
    }

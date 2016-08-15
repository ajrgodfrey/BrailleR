#' @rdname FindReplace
#' @title Find/Replace text in a file
#' @aliases FindReplace
#' @description  A simple wrapper function to make it easier to replace the text in a file, perhaps due to spelling errors.
#' @details Obviously the file must exist for this function to work.
#' @return NULL; this function is purely intended for use on an external file.
#' @author A. Jonathan R. Godfrey
#' @export FindReplace
#' @param file The external (text) file to be updated.
 #' @param find The text to remove.
 #' @param replace The text to insert.

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
        writeLines(gsub(find, replace, OldText)[1:NoLines], con = file)
      } else {
        warning(
            "The specified file does not exist.\nNo action has been taken.\n")
      }
      return(invisible(NULL))
    }

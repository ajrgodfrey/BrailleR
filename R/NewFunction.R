
NewFunction =
    function(FunctionName, args = NULL, NArgs = 0) {
      if (is.numeric(args[1])) {
        NArgs = args[1]
        args = NULL
      }
      if (is.null(args)) {
        args = rep("", NArgs)
      } else {
        NArgs = length(args)
      }
      Filename = paste0(FunctionName, ".R")
      cat(paste0(
              "#' @rdname ", FunctionName, "\n#' @title
\n#' @aliases ",
              FunctionName,
              "
\n#' @description
\n#' @details
\n#' @return
\n#' @seealso
\n#' @author ",
              getOption("BrailleR.Author"),
              "
\n#' @references
\n#' @examples
\n#' @export ", FunctionName,
              "

"), file = Filename, append = FALSE)
      if (NArgs > 0) {
        cat(paste("#' @param", args, "\n"), file = Filename, append = TRUE)
      }

      cat(paste0("\n", FunctionName, "= function(",
                 paste(args, collapse = ", "), "){

}
"), file = Filename,
          append = TRUE)
      return(
          message(
              "Script file successfully created in current working directory.\n"))
    }

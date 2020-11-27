#' @rdname NewFunction
#' @title Create a template for a new function
#' @aliases NewFunction
#' @description  An R script for a new function is created in the working directory. It includes Roxygen commented lines for the documentation with sensible defaults where possible.
#' @details The file still needs serious editing before insertion into a package.
#' @return Nothing in the workspace. Only outcome is the template file.
#' @seealso \code{\link{MakePkg}}
#' @author A. Jonathan R. Godfrey.
#' @export NewFunction
#' @param FunctionName The name of the function and file to create.
#' @param args a vector of argument names
#' @param NArgs an integer number of arguments to assign to the function.
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


#' @rdname MakeReadable
#' @title Convert line breaks in vignette documentation
#' @aliases MakeReadable
#' @description  The Rnw files used for vignettes use Linux style line breaks that make reading vignette source files difficult for Windows users. A Python script is called which converts the line breaks and saves the vignette source in the user's MyBrailleR folder.

#' @details Must have Python installed for this function to work.
#' @return Nothing in the workspace. All files are stored in a vignettes folder within MyBrailleR.
#' @author A. Jonathan R. Godfrey
#' @export MakeReadable
#' @param pkg The package to investigate for vignette source files.

MakeReadable =
    function(pkg) {
      if (.Platform$OS.type == "windows") {
        if (TestPython()) {
          if (requireNamespace(pkg, ) ) {
            # convert files here
            VignetteFolder = paste0(system.file(package = pkg), "/doc")
            RnwFiles = c(list.files(path = VignetteFolder, pattern = "Rnw"),
                         list.files(path = VignetteFolder, pattern = "rnw"))
            MyVignettesFolder =
                paste0(getOption("BrailleR.Folder"), "/Vignettes/")
            if (!dir.exists(MyVignettesFolder)) dir.create(MyVignettesFolder)
            MoveTo = paste0(MyVignettesFolder, pkg, "/")
            if (!dir.exists(MoveTo)) dir.create(MoveTo)
            file.copy(paste0(VignetteFolder, "/", RnwFiles),
                      paste0(MoveTo, RnwFiles), overwrite = TRUE)
            for (i in RnwFiles) {
              message("Copying and converting line breaks:")
              shell(paste0(system.file(
                               "Python/FixLineBreaks.py", package = "BrailleR"),
                           " ", MoveTo, i))
              message("Converting tabs to spaces:")
              shell(paste0(system.file(
                               "Python/RemoveTabs.py", package = "BrailleR"),
                           " ", MoveTo, i))
            }
          } else {
            warning("The specified package is not installed.\n")
          }
        } else {
          .NeedsPython()
        }
      } else {
        .WindowsOnly()
      }
      return(invisible(NULL))
    }

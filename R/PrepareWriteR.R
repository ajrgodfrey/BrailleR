# Getting started with the WriteR application
# only for Windows users at present.
## preparing for deprecation
## substituted with temporarily unavailable while testing the impact of removal

PrepareWriteR =
    function(Author = getOption("BrailleR.Author")) {
      if (interactive()) {
        if (.Platform$OS.type == "windows") {


        } else {
          .WindowsOnly()
        }
      } else {
        .InteractiveOnly()
      }
      return(invisible(NULL))
    }


PrepareWriteR =
    function(Author = getOption("BrailleR.Author")) {
      .TempUnavailable()
      return(invisible(NULL))
}

# Getting started with the WriteR application
# only for Windows users at present.
## preparing for deprecation
## substituted with temporarily unavailable while testing the impact of removal

PrepareWriteR =
    function(Author = getOption("BrailleR.Author")) {
      if (interactive()) {
        if (.Platform$OS.type == "windows") {
          RHome = gsub("/", "\\\\\\\\", Sys.getenv("R_HOME"))
          MyHome = gsub("/", "\\\\\\\\", gsub("\\\\", "/", Sys.getenv("HOME")))

          cat(paste0(
                  '{
    "RDirectory": "', RHome, '\\\\bin\\\\', version$arch,
                  '\\\\Rscript.exe",
    "filename": "untitled.Rmd",
    "newText": "# \\n## by ',
                  Author, ' on \\n\\n",
}
'), file = 'WriteROptions')

          message("The settings file for WriteR has been created.")

          file.copy(paste0(system.file(package = "BrailleR"), "/Python/Writer/",
                           c("WriteR.pyw", "HelpPage.html", "HelpPage.Rmd",
                             "Basics.Rmd")), ".")
          message(
              "Copies of the main wxPython script and help page documents have been copied \ninto your working directory.")
          message(
              "You can move these files to your preferred folder for WriteR, \nor start working here.")
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

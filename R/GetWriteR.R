### problems so temporary override follows experimental work

GetWriteR =
    function(UseGitHub = TRUE) {
      if (interactive()) {
        if (.Platform$OS.type == "windows") {
          if (requireNamespace("BrailleR")) {
            if (UseGitHub) {
              download.file(
                  "https://raw.github.com/ajrgodfrey/WriteR/master/Python/WriteR.zip",
                  "WriteR.zip")
              unzip("WriteR.zip")
              file.remove("WriteR.zip")
              file.rename("WriteR.exe",
                          paste0(getOption("BrailleR.Folder"), "WriteR.exe"))
              message(
                  "The WriteR application has been added to your MyBrailleR folder.")
            } else {
              browseURL("https://R-Resources.massey.ac.nz/WriteR/WriteR.zip")
              message(
                  "The WriteR application has been downloaded but you need to unzip it.")
              message("Move it to your MyBrailleR folder and unzip before use.")
            }
            message(
                "It is assumed you wanted to download this file by issuing the last command.")
            message(
                "You can delete WriteR.exe at any time to remove WriteR from your system.")
          }
        } else {
          .WindowsOnly
        }
      } else {
        .InteractiveOnly()
      }
      return(invisible(NULL))
    }


GetWriteR = function(UseGitHub = TRUE) {
.TempUnavailable()
            }



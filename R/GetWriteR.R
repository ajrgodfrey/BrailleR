### problems so temporary override follows experimental work

GetWriteR =
    function() {
      if (interactive()) {
        if (.Platform$OS.type == "windows") {
              .DownloadAFile()
              download.file(
                  "https://R-Resources.massey.ac.nz/writer/WriteRInstaller.exe",
                  "WriteRInstaller.exe")
              file.rename("WriteRInstaller.exe",
                          paste0(getOption("BrailleR.Folder"), "WriteRInstaller.exe"))
              .Added2MyBrailleR()
            .DeleteAnytime()
        } else {
          .WindowsOnly
        }
      } else {
        .InteractiveOnly()
      }
      return(invisible(NULL))
    }


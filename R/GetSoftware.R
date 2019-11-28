
GetPandoc =
    function() {
      if (interactive()) {
        if (.Platform$OS.type == "windows") {
          if (requireNamespace("BrailleR")) {
            if (requireNamespace("installr")) {
              .DownloadAFile()
              installr::install.pandoc(
                download_dir = getOption("BrailleR.Folder"),
                keep_install_file = TRUE)
              .Added2MyBrailleR()
              .DeleteAnytime ()
            }
          }
        } else {
          .WindowsOnly()
        }
      } else {
        .InteractiveOnly()
      }
      return(invisible(NULL))
    }



GetRStudio =
    function() {
      if (interactive()) {
        if (.Platform$OS.type == "windows") {
          if (requireNamespace("BrailleR")) {
            if (requireNamespace("installr")) {
              .DownloadAFile()
              installr::install.RStudio(
                download_dir = getOption("BrailleR.Folder"),
                keep_install_file = TRUE)
              .Added2MyBrailleR()
              .DeleteAnytime ()
            }
          }
        } else {
          .WindowsOnly()
        }
      } else {
        .InteractiveOnly()
      }
      return(invisible(NULL))
    }



Get7zip =
    function() {
      if (interactive()) {
        if (.Platform$OS.type == "windows") {
          if (requireNamespace("BrailleR")) {
            if (requireNamespace("installr")) {
              .DownloadAFile()
              installr::install.7zip(download_dir = getOption("BrailleR.Folder"),
                                   keep_install_file = TRUE)
                .Added2MyBrailleR()
              .DeleteAnytime ()
            }
          }
        } else {
          .WindowsOnly()
        }
      } else {
        .InteractiveOnly()
      }
      return(invisible(NULL))
    }

GetCygwin =
    function(x64=TRUE) {
      if (interactive()) {
        if (.Platform$OS.type == "windows") {
          if (requireNamespace("BrailleR")) {
            if (requireNamespace("installr")) {
              .DownloadAFile()
bit=32
if(x64){
              if(installr::is.x64()) bit=64
              }
      installr::install.cygwin(bit=bit,
                download_dir = getOption("BrailleR.Folder"),
                keep_install_file = TRUE)
                .Added2MyBrailleR()
              .DeleteAnytime ()
            }
          }
        } else {
          .WindowsOnly()
        }
      } else {
        .InteractiveOnly()
      }
      return(invisible(NULL))
    }

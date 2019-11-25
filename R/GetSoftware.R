
GetRStudio =
    function() {
      if (interactive()) {
        if (.Platform$OS.type == "windows") {
          if (requireNamespace("BrailleR")) {
            if (requireNamespace("installr")) {
              message(
                "This command will download a file and save it to your hard drive.\n")
              installr::install.RStudio(
                download_dir = getOption("BrailleR.Folder"),
                keep_install_file = TRUE)
              message(
                "The installer file has been added to your MyBrailleR folder.")
              message(
                "You can delete it at any time, but that will not uninstall the application.")
            }
          }
        } else {
          warning(
              "This function is for users running R under the Windows operating system.\n")
        }
      } else {
        warning("This function is meant for use in interactive mode only.\n")
      }
      return(invisible(NULL))
    }



Get7zip =
    function() {
      if (interactive()) {
        if (.Platform$OS.type == "windows") {
          if (requireNamespace("BrailleR")) {
            if (requireNamespace("installr")) {
              message(
                "This command will download a file and save it to your hard drive.")
              installr::install.7zip(download_dir = getOption("BrailleR.Folder"),
                                   keep_install_file = TRUE)
              message(
                "The installer file has been added to your MyBrailleR folder.")
              message(
                "You can delete it at any time, but that will not uninstall the application.")
            }
          }
        } else {
          warning(
              "This function is for users running R under the Windows operating system.\n")
        }
      } else {
        warning("This function is meant for use in interactive mode only.\n")
      }
      return(invisible(NULL))
    }

GetCygwin =
    function(x64=TRUE) {
      if (interactive()) {
        if (.Platform$OS.type == "windows") {
          if (requireNamespace("BrailleR")) {
            if (requireNamespace("installr")) {
              message(
                "This command will download a file and save it to your hard drive.\n")
bit=32
if(x64){
              if(installr::is.x64()) bit=64
              }
      installr::install.cygwin(bit=bit,
                download_dir = getOption("BrailleR.Folder"),
                keep_install_file = TRUE)
              message(
                "The installer file has been added to your MyBrailleR folder.")
              message(
                "You can delete it at any time, but that will not uninstall the application.")
            }
          }
        } else {
          warning(
              "This function is for users running R under the Windows operating system.\n")
        }
      } else {
        warning("This function is meant for use in interactive mode only.\n")
      }
      return(invisible(NULL))
    }

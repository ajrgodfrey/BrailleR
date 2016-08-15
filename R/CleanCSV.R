CleanCSV =
    function(file) {
      if (interactive()) {
        for (ThisFile in file) {
          cat(paste0(ThisFile, ": "))
          if (file.exists(ThisFile)) {
            file.copy(ThisFile, paste0(ThisFile, ".bak"))
            for (FixString in c(", ", " ,", "\t,", ",\t")) {
              FindReplace(ThisFile, FixString, ",")
            }
            message("Done.")
          }  # end ThisFile exists condition
              else {
            warning("The specified file does not exist.\n")
          }
        }  # end for loop for files
      }  # end interactive ondition
          else {
        warning("This function is meant for use in interactive mode only.\n")
      }

      return(invisible(NULL))
    }

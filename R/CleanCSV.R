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
            .Done() 
          }  # end ThisFile exists condition
              else {
            .FileNotFound()
          }
        }  # end for loop for files
      }  # end interactive ondition
          else {
        .InteractiveOnly()
      }
      return(invisible(NULL))
    }

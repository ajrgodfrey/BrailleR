
AutoSpellCheck =
    function(file) {
      if (interactive()) {
        if (require(BrailleR)) {
          ChangeList = read.csv(paste0(getOption("BrailleR.Folder"),
                                       "AutoSpellList.csv"))
          for (i in 1:length(ChangeList$OldString)) {
            FindReplace(file, ChangeList$OldString[i], ChangeList$NewString[i])
          }
        }
      } else {
        .InteractiveOnly()
      }
      return(invisible(NULL))
    }

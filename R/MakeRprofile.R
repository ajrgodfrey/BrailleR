MakeRprofile =
    function(Overwrite = FALSE) {
      if (interactive()) {
      if (!file.exists(".Rprofile")) Overwrite = TRUE

      if (Overwrite) {
        cat('.First=function(){\n  .First.sys()\n  library(BrailleR)\n}\n',
            file = ".Rprofile")

        .FileCreated(".Rprofile", "in the current working directory.") 
        .AutoLoadBrailleR()
      } else {
.FileExists(file=".Rprofile")
        .OverWriteNeeded()
      }
      } else {
        .InteractiveOnly()
      }
      return(invisible(NULL))
    }

MakeRprofile =
    function(Overwrite = FALSE) {
      if (!file.exists(".Rprofile")) Overwrite = TRUE

      if (Overwrite) {
        cat('.First=function(){\n  .First.sys()\n  library(BrailleR)\n}\n',
            file = ".Rprofile")
        message(
            "The .Rprofile file has been updated. The BrailleR package will be automatically loaded on startup in this working directory.")
      } else {
.FileExists(file=".Rprofile")
        .OverWriteNeeded()
      }
      return(invisible(NULL))
    }

MakeRprofile =
    function(Overwrite = FALSE) {
      if (!file.exists(".Rprofile")) Overwrite = TRUE

      if (Overwrite) {
        cat('.First=function(){\n  .First.sys()\n  library(BrailleR)\n}\n',
            file = ".Rprofile")
        message(
            "The .Rprofile file has been updated. The BrailleR package will be automatically loaded on startup in this working directory.")
      } else {
        warning("An .Rprofile already exists. No action has been taken.\n")
      }
      return(invisible(NULL))
    }

BrailleRHome =
    function() {
      if (interactive()) {
        browseURL("https://R-Resources.massey.ac.nz/BrailleR/")
      } else {
        .InteractiveOnly()
      }
      return(invisible(NULL))
    }

BrailleRInAction =
    function() {
      if (interactive()) {
        browseURL("https://R-Resources.massey.ac.nz/BrailleRInAction/")
      } else {
        .InteractiveOnly()
      }
      return(invisible(NULL))
    }

LURN = function(BlindVersion = getOption("BrailleR.VI")) {
         if (interactive()) {
           if (BlindVersion) {
             browseURL("https://R-Resources.massey.ac.nz/LURNBlind/")
           } else {
             browseURL("https://R-Resources.massey.ac.nz/LURN/")
           }
         } else {
           .InteractiveOnly()
         }
         return(invisible(NULL))
       }



google = Google =
    function() {
      if (interactive()) {
        browseURL("https://www.google.com")
      } else {
        .InteractiveOnly()
      }
      return(invisible(NULL))
    }


R4DS = r4ds  =
    function() {
      if (interactive()) {
        browseURL("http://r4ds.had.co.nz/")
      } else {
        .InteractiveOnly()
      }
      return(invisible(NULL))
    }



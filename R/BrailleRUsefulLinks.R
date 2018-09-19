BrailleRHome =
    function() {
      if (interactive()) {
        browseURL("https://R-Resources.massey.ac.nz/BrailleR/")
      } else {
        warning("This function is meant for use in interactive mode only.\n")
      }
      return(invisible(NULL))
    }

BrailleRInAction =
    function() {
      if (interactive()) {
        browseURL("https://R-Resources.massey.ac.nz/BrailleRInAction/")
      } else {
        warning("This function is meant for use in interactive mode only.\n")
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
           warning("This function is meant for use in interactive mode only.\n")
         }
         return(invisible(NULL))
       }



google = Google =
    function() {
      if (interactive()) {
        browseURL("https://www.google.com")
      } else {
        warning("This function is meant for use in interactive mode only.\n")
      }
      return(invisible(NULL))
    }


R4DS = r4ds  =
    function() {
      if (interactive()) {
        browseURL("http://r4ds.had.co.nz/")
      } else {
        warning("This function is meant for use in interactive mode only.\n")
      }
      return(invisible(NULL))
    }



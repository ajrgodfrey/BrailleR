BrailleRHome =
    function() {
      if (interactive()) {
        browseURL("https://R-Resources.massey.ac.nz/BrailleR/")
      } else {
        warning("This function is meant for use in interactive mode only.\n")
      }
      return(invisible(NULL))
    }

LURN = function(BlindVersion = getOption("BrailleR.VI")) {
         if (interactive()) {
           if (BlindVersion) {
             browseURL("https://R-Resources.massey.ac.nz/LURNBlind/front.html")
           } else {
             browseURL("https://R-Resources.massey.ac.nz/LURN/front.html")
           }
         } else {
           warning("This function is meant for use in interactive mode only.\n")
         }
         return(invisible(NULL))
       }

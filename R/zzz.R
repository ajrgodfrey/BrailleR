.onDetach =
    function(libpath) {
        options("BrailleR.VI" = NULL)
    }

.onAttach =
    function(libname, pkgname) {
        options("BrailleR.VI" = TRUE)
      if (interactive()) {
        packageStartupMessage(
            "The BrailleR.View option has been set to TRUE. \nConsult the help page for GoSighted() to see how settings can be altered.\nYou may wish to use the GetGoing() function as a quick way of getting started.")
      } else {
        packageStartupMessage("The BrailleR.View,  option is set to FALSE.")
      }
    }

.onLoad =
    function(libname, pkgname) {
      ns <- getNamespace(pkgname)

      Folder = SetupBrailleR()

      if (file.exists("BrailleROptions")) {
        OpSet = read.dcf("BrailleROptions", all = TRUE)
      } else {  # first time package is used in this directory
        if (is.null(Folder)) {
          OpSet = read.dcf(system.file("MyBrailleR/BrailleROptions",
                                       package = "BrailleR"), all = TRUE)
        } else {
          OpSet = read.dcf(file.path(Folder, "/BrailleROptions"), all = TRUE)
        }
        # to do: # ask for permission to write a local copy
        ## write.dcf(OpSet, file="BrailleROptions")
      }

      OpSet$BrailleR.Folder = Folder
      OpSet$BrailleR.SigLevel = as.numeric(OpSet$BrailleR.SigLevel)
      OpSet$BrailleR.PValDigits = as.numeric(OpSet$BrailleR.PValDigits)
      OpSet$BrailleR.DotplotBins = as.numeric(OpSet$BrailleR.DotplotBins)
      OpSet$BrailleR.BRLPointSize = as.numeric(OpSet$BrailleR.BRLPointSize)
      OpSet$BrailleR.PaperWidth = as.numeric(OpSet$BrailleR.PaperWidth)
      OpSet$BrailleR.PaperHeight = as.numeric(OpSet$BrailleR.PaperHeight)
      #OpSet$ = as.numeric(OpSet$)

      do.call(options, as.list(OpSet))
      Op <- getOption("repos")
      Op["CRAN"] <- "https://cran.rstudio.com/"
      options(repos = Op)


      options(BrailleR.View = interactive())
      BrailleR = new.env(parent = .GlobalEnv)
      if (interactive()) {
        options("menu.graphics" = FALSE)
      }
    }

# functions for setting the package options as easily as possible. Most do not have arguments.

# these ones do have arguments


ResetDefaults =
    function(Local = interactive()) {
      if (interactive()) {
        DefSettings = system.file("BrailleROptions", package = "BrailleR")
        PrefSettings =
            file.path(getOption("BrailleR.Folder"), "BrailleROptions")
        file.copy(DefSettings, PrefSettings, overwrite = TRUE)
        message(
            "You have reset all preferences to the original package defaults.\n")
        if (Local) file.remove("BrailleROptions")
        devtools::reload("BrailleR")
      } else {
        warning("This function is meant for use in interactive mode only.\n")
      }
      return(invisible(NULL))
    }


ChooseEmbosser =
    function(
        Embosser = "none", Permanent = interactive(), Local = interactive()) {
      if (is.character(Embosser)) {
        options(BrailleR.Embosser = Embosser)
        message(
            "The BrailleR.Embosser option has been updated to ", Embosser, ".")
        if (Permanent) {
          Prefs = paste0(getOption("BrailleR.Folder"), "BrailleROptions")
          OpSet = as.data.frame(read.dcf(Prefs, all = TRUE))
          OpSet$BrailleR.Embosser = Embosser
          write.dcf(OpSet, file = Prefs)
          message("and has overwritten the setting for all folders.")
        }
        if (Local) {
          Prefs = "BrailleROptions"
          if (file.exists(Prefs)) {
            OpSet = as.data.frame(read.dcf(Prefs, all = TRUE))
          }
          OpSet$BrailleR.Embosser = Embosser
          write.dcf(OpSet, file = Prefs)
          message(
              "The new setting will remain in effect next time you load the BrailleR package in this directory.")
        }
      } else {
        warning("A text string was expected. No action taken.\n")
      }
      return(invisible(NULL))
    }

ChooseSlideStyle =
    function(css = "JGSlides.css", Permanent = interactive(),
             Local = interactive()) {
      if (is.character(css)) {
        options(BrailleR.SlideStyle = css)
        if (system.file("css", css, package = "BrailleR") == "") {
          warning(
              "The file", css,
              "is not in the css folder of the BrailleR package.\nPlease put it there before re-issuing this command.\n")
        } else {
          message(
              "The BrailleR.SlideStyle option has been updated to ", css, ".")
          if (Permanent) {
            Prefs = paste0(getOption("BrailleR.Folder"), "BrailleROptions")
            OpSet = as.data.frame(read.dcf(Prefs, all = TRUE))
            OpSet$BrailleR.SlideStyle = css
            write.dcf(OpSet, file = Prefs)
            message("and has overwritten the setting for all folders.")
          }
          if (Local) {
            Prefs = "BrailleROptions"
            if (file.exists(Prefs)) {
              OpSet = as.data.frame(read.dcf(Prefs, all = TRUE))
            }
            OpSet$BrailleR.SlideStyle = css
            write.dcf(OpSet, file = Prefs)
            message(
                "The new setting will remain in effect next time you load the BrailleR package in this directory.")
          }
        }
      } else {
        warning("A text string was expected. No action taken.\n")
      }
      return(invisible(NULL))
    }

ChooseStyle =
    function(css = "BrailleR.css", Permanent = interactive(),
             Local = interactive()) {
      if (is.character(css)) {
        options(BrailleR.Style = css)
        if (system.file("css", css, package = "BrailleR") == "") {
          warning(
              "The file", css,
              "is not in the css folder of the BrailleR package.\nPlease put it there before re-issuing this command.\n")
        } else {
          message("The BrailleR.Style option has been updated to ", css, ".")
          if (Permanent) {
            Prefs = paste0(getOption("BrailleR.Folder"), "BrailleROptions")
            OpSet = as.data.frame(read.dcf(Prefs, all = TRUE))
            OpSet$BrailleR.Style = css
            write.dcf(OpSet, file = Prefs)
            message("and has overwritten the setting for all folders.")
          }
          if (Local) {
            Prefs = "BrailleROptions"
            if (file.exists(Prefs)) {
              OpSet = as.data.frame(read.dcf(Prefs, all = TRUE))
            }
            OpSet$BrailleR.Style = css
            write.dcf(OpSet, file = Prefs)
            message(
                "The new setting will remain in effect next time you load the BrailleR package in this directory.")
          }
        }
      } else {
        warning("A text string was expected. No action taken.\n")
      }
      return(invisible(NULL))
    }


SetAuthor =
    function(
        name = "BrailleR", Permanent = interactive(), Local = interactive()) {
      if (is.character(name)) {
        options(BrailleR.Author = name)
        message("The BrailleR.Author option has been updated to ", name, ".")
        if (Permanent) {
          Prefs = paste0(getOption("BrailleR.Folder"), "BrailleROptions")
          OpSet = as.data.frame(read.dcf(Prefs, all = TRUE))
          OpSet$BrailleR.Author = name
          write.dcf(OpSet, file = Prefs)
          message("and has overwritten the setting for all folders.")
        }
        if (Local) {
          Prefs = "BrailleROptions"
          if (file.exists(Prefs)) {
            OpSet = as.data.frame(read.dcf(Prefs, all = TRUE))
          }
          OpSet$BrailleR.Author = name
          write.dcf(OpSet, file = Prefs)
          message(
              "The new setting will remain in effect next time you load the BrailleR package in this directory.")
        }
      } else {
        warning("A text string was expected. No action taken.\n")
      }
      return(invisible(NULL))
    }


SetBRLPointSize =
    function(pt, Permanent = FALSE, Local = interactive()) {
      if ((10 < pt) & (pt < 40)) {
        options(BrailleR.BRLPointSize = pt)
        message(
            "The BrailleR.BRLPointSize option for the braille font has been changed to ",
            pt, " inches.")
        if (Permanent) {
          Prefs = paste0(getOption("BrailleR.Folder"), "BrailleROptions")
          OpSet = as.data.frame(read.dcf(Prefs, all = TRUE))
          OpSet$BrailleR.BRLPointSize = pt
          write.dcf(OpSet, file = Prefs)
          message("and has overwritten the setting for all folders.")
        }
        if (Local) {
          Prefs = "BrailleROptions"
          if (file.exists(Prefs)) {
            OpSet = as.data.frame(read.dcf(Prefs, all = TRUE))
          }
          OpSet$BrailleR.BRLPointSize = pt
          write.dcf(OpSet, file = Prefs)
          message(
              "The new setting will remain in effect next time you load the BrailleR package in this directory.")
        }
      } else {
        warning(
            "The point size must be between 10 and 40 . \nNo change has been made to this setting.\n")
      }
      return(invisible(NULL))
    }


SetLanguage =
    function(
        Language = "en_us", Permanent = interactive(), Local = interactive()) {
      if (is.character(Language)) {
        options(BrailleR.Language = Language)
        message(
            "The BrailleR.Language option has been updated to ", Language, ".")
        if (Permanent) {
          Prefs = paste0(getOption("BrailleR.Folder"), "BrailleROptions")
          OpSet = as.data.frame(read.dcf(Prefs, all = TRUE))
          OpSet$BrailleR.Language = Language
          write.dcf(OpSet, file = Prefs)
          message("and has overwritten the setting for all folders.")
        }
        if (Local) {
          Prefs = "BrailleROptions"
          if (file.exists(Prefs)) {
            OpSet = as.data.frame(read.dcf(Prefs, all = TRUE))
          }
          OpSet$BrailleR.Language = Language
          write.dcf(OpSet, file = Prefs)
          message(
              "The new setting will remain in effect next time you load the BrailleR package in this directory.")
        }
      } else {
        warning("A text string was expected. No action taken.\n")
      }
      return(invisible(NULL))
    }


SetMakeUpper =
    function(Upper, Permanent = interactive(), Local = interactive()) {
      Upper = as.logical(Upper)
      if (is.logical(Upper)) {
        options(BrailleR.MakeUpper = Upper)
        message(
            "The BrailleR.MakeUpper option for capitalising the initial letter of variable names has been changed to ",
            Upper, ".")
        if (Permanent) {
          Prefs = paste0(getOption("BrailleR.Folder"), "BrailleROptions")
          OpSet = as.data.frame(read.dcf(Prefs, all = TRUE))
          OpSet$BrailleR.MakeUpper = Upper
          write.dcf(OpSet, file = Prefs)
          message("and has overwritten the setting for all folders.")
        }
        if (Local) {
          Prefs = "BrailleROptions"
          if (file.exists(Prefs)) {
            OpSet = as.data.frame(read.dcf(Prefs, all = TRUE))
          }
          OpSet$BrailleR.MakeUpper = Upper
          write.dcf(OpSet, file = Prefs)
          message(
              "The new setting will remain in effect next time you load the BrailleR package in this directory.")
        }
      } else {
        warning(
            "The option must be either TRUE or FALSE.\nNo change has been made to this setting.\n")
      }
      return(invisible(NULL))
    }

SetPaperHeight =
    function(Inches, Permanent = FALSE, Local = interactive()) {
      if ((5 < Inches) & (Inches < 14)) {
        options(BrailleR.PaperHeight = Inches)
        message(
            "The BrailleR.PaperHeight option for the height of the embossed images has been changed to ",
            Inches, " inches.")
        if (Permanent) {
          Prefs = paste0(getOption("BrailleR.Folder"), "BrailleROptions")
          OpSet = as.data.frame(read.dcf(Prefs, all = TRUE))
          OpSet$BrailleR.PaperHeight = Inches
          write.dcf(OpSet, file = Prefs)
          message("and has overwritten the setting for all folders.")
        }
        if (Local) {
          Prefs = "BrailleROptions"
          if (file.exists(Prefs)) {
            OpSet = as.data.frame(read.dcf(Prefs, all = TRUE))
          }
          OpSet$BrailleR.PaperHeight = Inches
          write.dcf(OpSet, file = Prefs)
          message(
              "The new setting will remain in effect next time you load the BrailleR package in this directory.")
        }
      } else {
        warning(
            "The height must be between 5 and 14 inches. \nNo change has been made to this setting.\n")
      }
      return(invisible(NULL))
    }

SetPaperWidth =
    function(Inches, Permanent = FALSE, Local = interactive()) {
      if ((5 < Inches) & (Inches < 14)) {
        options(BrailleR.PaperWidth = Inches)
        message(
            "The BrailleR.PaperWidth option for the width of the embossed images has been changed to ",
            Inches, " inches.")
        if (Permanent) {
          Prefs = paste0(getOption("BrailleR.Folder"), "BrailleROptions")
          OpSet = as.data.frame(read.dcf(Prefs, all = TRUE))
          OpSet$BrailleR.PaperWidth = Inches
          write.dcf(OpSet, file = Prefs)
          message("and has overwritten the setting for all folders.")
        }
        if (Local) {
          Prefs = "BrailleROptions"
          if (file.exists(Prefs)) {
            OpSet = as.data.frame(read.dcf(Prefs, all = TRUE))
          }
          OpSet$BrailleR.PaperWidth = Inches
          write.dcf(OpSet, file = Prefs)
          message(
              "The new setting will remain in effect next time you load the BrailleR package in this directory.")
        }
      } else {
        warning(
            "The width must be between 5 and 14 inches. \nNo change has been made to this setting.\n")
      }
      return(invisible(NULL))
    }



SetPValDigits =
    function(digits, Permanent = interactive(), Local = interactive()) {
      digits = as.integer(digits)
      if (digits > 1) {
        options(BrailleR.PValDigits = digits)
        message(
            "The BrailleR.PValDigits option for the number of decimal places to display for p values has been changed to ",
            digits, ".")
        if (Permanent) {
          Prefs = paste0(getOption("BrailleR.Folder"), "BrailleROptions")
          OpSet = as.data.frame(read.dcf(Prefs, all = TRUE))
          OpSet$BrailleR.PValDigits = digits
          write.dcf(OpSet, file = Prefs)
          message("and has overwritten the setting for all folders.")
        }
        if (Local) {
          Prefs = "BrailleROptions"
          if (file.exists(Prefs)) {
            OpSet = as.data.frame(read.dcf(Prefs, all = TRUE))
          }
          OpSet$BrailleR.PValDigits = digits
          write.dcf(OpSet, file = Prefs)
          message(
              "The new setting will remain in effect next time you load the BrailleR package in this directory.")
        }
      } else {
        warning(
            "The number of digits must be an integer greater than one.\nNo change has been made to this setting.\n")
      }
      return(invisible(NULL))
    }

SetSigLevel =
    function(alpha, Permanent = interactive(), Local = interactive()) {
      if ((0 < alpha) & (alpha < 1)) {
        options(BrailleR.SigLevel = alpha)
        message(
            "The BrailleR.SigLevel option for the level of alpha has been changed to ",
            alpha, ".")
        if (Permanent) {
          Prefs = paste0(getOption("BrailleR.Folder"), "BrailleROptions")
          OpSet = as.data.frame(read.dcf(Prefs, all = TRUE))
          OpSet$BrailleR.SigLevel = alpha
          write.dcf(OpSet, file = Prefs)
          message("and has overwritten the setting for all folders.")
        }
        if (Local) {
          Prefs = "BrailleROptions"
          if (file.exists(Prefs)) {
            OpSet = as.data.frame(read.dcf(Prefs, all = TRUE))
          }
          OpSet$BrailleR.SigLevel = alpha
          write.dcf(OpSet, file = Prefs)
          message(
              "The new setting will remain in effect next time you load the BrailleR package in this directory.")
        }
      } else {
        warning(
            "The level of alpha must be between 0 and 1. \nNo change has been made to this setting.\n")
      }
      return(invisible(NULL))
    }

# functions below this point have no arguments. (yet)

GoSighted =
    function() {
      options(BrailleR.VI = FALSE)
      message(
          "By going sighted, you have turned off the automatic generation of text descriptions of graphs.\n")
      return(invisible(NULL))
    }

GoBlind =
    function() {
      options(BrailleR.VI = TRUE)
      message(
          "By going blind, you have turned on the automatic generation of text descriptions of graphs.\n")
      return(invisible(NULL))
    }

GoAdvanced =
    function() {
      options(BrailleR.Advanced = TRUE)
      message(
          "By going advanced, you have reduced the verbosity of text descriptions of graphs.\n")
      return(invisible(NULL))
    }


GoNovice =
    function() {
      options(BrailleR.Advanced = FALSE)
      message(
          "By going novice, you have returned to receiving all of the automatically generated text descriptions of graphs.\n")
      return(invisible(NULL))
    }



ViewOn = function() {
           options(BrailleR.View = TRUE)
           message("You have turned the automatic opening of html pages on.\n")
           return(invisible(NULL))
         }

ViewOff =
    function() {
      options(BrailleR.View = FALSE)
      message("You have turned the automatic opening of html pages off.\n\n")
      return(invisible(NULL))
    }

LatexOn =
    function() {
      options(BrailleR.Latex = TRUE)
      message("You have turned the automatic generation of LaTeX tables on.\n")
      return(invisible(NULL))
    }

LatexOff =
    function() {
      options(BrailleR.Latex = FALSE)
      message("You have turned the automatic generation of LaTeX tables off.\n")
      return(invisible(NULL))
    }


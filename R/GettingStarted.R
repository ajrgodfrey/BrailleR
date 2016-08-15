GetGoing =
    function() {
      if (interactive()) {
        message(
            "You will be asked to enter answers for a series of questions.\nHit <enter> to use the default shown in parentheses.")

        message("\nEnter the name you want to use for authoring content. (",
                getOption("BrailleR.Author"), ")")
        name = readLines(n = 1)
        if (name != "") SetAuthor(name)

        message(
            "\nHow many decimal places do you wish p values to be rounded to? (",
            getOption("BrailleR.PValDigits"), ")\n")
        digits = as.numeric(readLines(n = 1))
        if (!is.na(digits)) SetSigLevel(digits)

        message(
            "\nWhat is the level of significance you plan to use as your default? (",
            getOption("BrailleR.SigLevel"), ")")
        alpha = as.numeric(readLines(n = 1))
        if (!is.na(alpha)) SetSigLevel(alpha)

        message(
            "\nThe following questions are yes/no questions. Use T or TRUE for yes, F or FALSE for no.")

        message(
            "\nDo you want to process R scripts and Rmd files outside R? (TRUE)")
        batch = as.logical(readLines(n = 1))
        if (is.na(batch)) batch = TRUE
        if (batch) MakeBatch()

        message(
            "\nDo you want to incorporate output from R into LaTeX files? (TRUE)")
        latex = as.logical(readLines(n = 1))
        if (is.na(latex)) latex = TRUE
        if (latex) {
          LatexOn()
        } else {
          LatexOff()
        }

        message(
            "\nDo you want to automatically open HTML files of R output? (TRUE)")
        view = as.logical(readLines(n = 1))
        if (is.na(view)) view = TRUE
        if (view) {
          ViewOn()
        } else {
          ViewOff()
        }

        message(
            "\nBrailleR assumes you are blind. Is this how you will work? (TRUE)")
        vi = as.logical(readLines(n = 1))
        if (is.na(vi)) vi = TRUE
        if (vi) {
          GoBlind()
        } else {
          GoSighted()
        }


        #end interactive section.
      } else {
        warning("This function is only intended for interactive R sessions.\n")
      }
      return(invisible(NULL))
    }

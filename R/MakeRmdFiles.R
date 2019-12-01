History2Rmd =
    function(file = "History.Rmd") {
      if (interactive()) {
        TempFile = tempfile(fileext = "R")
        savehistory(TempFile)
        Lines = readLines(TempFile)
        LineNo = 1:length(Lines)
        cat("# History from R session on", format(Sys.Date(), "%A %d %B %Y"),
            "\n## by", getOption("BrailleR.Author"), "\n\n", file = file)
        cat(paste0("```{r line", LineNo, "}  \n", Lines, "\n```  \n\n"),
            file = file, append = TRUE)
        message("There is a new file in your working directory. Look for: ")
        return(file)
      } else {
        .InteractiveOnly()
        return(invisible(NULL))
      }
    }


R2Rmd =
    function(ScriptFile) {
      if (file.exists(ScriptFile)) {
        RmdFile = paste0(ScriptFile, "md")
        Lines = readLines(ScriptFile)
        NoLines = length(Lines)
        GoodLines = Lines > ""
        GoodLines2 = c(FALSE, GoodLines[1:(NoLines - 1)])
        ShowLines = GoodLines | GoodLines2
        #if(Lines[1]=="") ShowLines[1]=FALSE
        Lines[Lines == ""] = "```  \n\n```{r }  "
        Lines = Lines[ShowLines]

        cat("# ", "\n## by", getOption("BrailleR.Author"), "\n\n```{r }  ",
            file = RmdFile)
        cat(paste0("\n", Lines, "  "), file = RmdFile, append = TRUE)
        cat("\n# end of input  \n```  \n\n", file = RmdFile, append = TRUE)
        .NewFile()
        return(RmdFile)
      } else {
        .FileNotFound()
        return(invisible(NULL))
      }
    }

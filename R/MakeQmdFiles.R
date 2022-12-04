# make exportable

.History2Qmd =
    function(file = "History.Qmd") {
      if (interactive()) {
        TempFile = tempfile(fileext = "R")
        savehistory(TempFile)
        Lines = readLines(TempFile)
        LineNo = 1:length(Lines)
        cat(paste0('---\ntitle: "History from R session on ', format(Sys.Date(), "%A %d %B %Y"),
            '"\nauthor: "by ', getOption("BrailleR.Author"), '"\ndate: Updated on `r format(Sys.Date(), \'%A %d %B %Y\')`\n---\n\n```{r setup, include=FALSE}\nlibrary(knitr)
opts_chunk$set(comment="", fig.cap="to fix")
```\n\n'), file = file)
        cat(paste0("```{r}\n
\#| line", LineNo, "\n", Lines, "\n```  \n\n"),
            file = file, append = TRUE)
        .NewFile(file)
        return(file)
      } else {
        .InteractiveOnly()
        return(invisible(NULL))
      }
    }


.R2Qmd =
    function(ScriptFile) {
      if (file.exists(ScriptFile)) {
        QmdFile = gsub(".Qmd", ".Qmd", paste0(ScriptFile, "md"))
        Lines = readLines(ScriptFile)
        NoLines = length(Lines)
        GoodLines = Lines > ""
        GoodLines2 = c(FALSE, GoodLines[1:(NoLines - 1)])
        ShowLines = GoodLines | GoodLines2
        #if(Lines[1]=="") ShowLines[1]=FALSE
        Lines[Lines == ""] = "```  \n\n```{r}  "
        Lines = Lines[ShowLines]

        cat(paste0('---\ntitle: ""\nauthor: "', getOption("BrailleR.Author"), '"\ndate: `r format(Sys.Date(), \'%A %d %B %Y\')`\n---\n\n```{r }'),
            file = QmdFile)
        cat(paste0("\n", Lines, "  "), file = QmdFile, append = TRUE)
        cat("\n# end of input  \n```  \n\n", file = QmdFile, append = TRUE)
        .NewFile()
        return(QmdFile)
      } else {
        .FileDoesNotExist(file)
        return(invisible(NULL))
      }
    }

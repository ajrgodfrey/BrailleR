# do we need this given spelling package now exists??
SpellCheck =
    function(file) {
      if (interactive()) {
        for (ThisFile in file) {
          cat(paste0(ThisFile, ": "))
          if (file.exists(ThisFile)) {
            file.copy(ThisFile, paste0(ThisFile, ".bak"), overwrite = FALSE)
            cat("\n", file = ThisFile, append = TRUE)  # otherwise problems 
                                                       # on readLines() below
            OldText <- readLines(con = ThisFile)
            Mistakes = SpellCheckFiles(file = ThisFile)
            for (i in names(Mistakes[[1]])) {
              Lines = gsub(",", ", ", Mistakes[[1]][i])
              LineNos = as.numeric(unlist(strsplit(Lines, ", ")))
              UserPref = 6
              while (UserPref > 4) {
                UserPref =
                    menu(
                        list(
                            "Ignore this word",
                            "add this word to the global list of words to ignore",
                            "add this word to the list of words to ignore when checking this file",
                            "change it to...",
                            paste0("read the word '", i, "' in context")),
                        title = paste0(
                            "\n", i, " appears to be misspelled on ",
                            ifelse(length(LineNos) > 1, "lines", "line"), Lines))
                if (UserPref == "5") {
                  cat(paste0(OldText[LineNos], "\n"))
                }
              }  # end of the while loop
              if (UserPref == "2") {
                cat(paste0(i, "\n"), file = paste0(getOption("BrailleR.Folder"),
                                                   "words.ignore.txt"),
                    append = TRUE)
              }
              if (UserPref == "3") {
                cat(paste0(i, "\n"), file = paste0(ThisFile, ".ignore.txt"),
                    append = TRUE)
              }
              if (UserPref == "4") {
                cat("Enter replacement text: ")
                Replace = readLines(n = 1)
                OldText = gsub(i, Replace, OldText)
              }


            }  # end of misspelled words loop
            NoLines = length(OldText)
            if (NoLines > 2) {
              if (all(OldText[c(NoLines - 1, NoLines)] == "\n")) {
                NoLines = NoLines - 1
              }
            }
            writeLines(OldText[1:NoLines], con = ThisFile)
            .Done()
          }  # end ThisFile exists condition
              else {
            .FileDoesNotExist(file)
          }
        }  # end for loop for files
      }  # end interactive ondition
          else {
        .InteractiveOnly()
      }
      return(invisible(NULL))
    }

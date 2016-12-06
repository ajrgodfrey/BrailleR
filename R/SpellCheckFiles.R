SpellCheckFiles =
    function(file = ".", ignore = character(), local.ignore = TRUE,
             global.ignore = TRUE) {
      ignore <- c(hunspell::en_stats, ignore)
      if (global.ignore) {
        globalIgnoreFile =
            paste0(getOption("BrailleR.Folder"), "words.ignore.txt")
        if (file.exists(globalIgnoreFile)) {
          ignore = c(ignore, read.table(globalIgnoreFile,
                                        colClasses = "character")[, 1])
        }
      }
      if (dir.exists(file)) {
        filenames = list.files(file)
        checkFiles <- normalizePath(paste0(file, "/", filenames))
        if (file.exists(as.character(local.ignore))) {
          ignore =
              c(ignore, read.table(local.ignore, colClasses = "character")[, 1])
        }
      } else {
        filenames = checkFiles <- file
        localIgnoreFile = paste0(filenames, ".ignore.txt")
        if (file.exists(localIgnoreFile)) {
          ignore = c(ignore,
                     read.table(localIgnoreFile, colClasses = "character")[, 1])
        }
      }
      # a little hack because Hadley doesn't want to export spell_check_file  from the devtools package
      NS = getNamespace("devtools")
      spell_check_file = get("spell_check_file", NS)
      checkLines = list()
      checkLines <- lapply(
          checkFiles, spell_check_file, ignore = ignore)
      names(checkLines) = filenames
      class(checkLines) = c("wordlist", "data.frame")
      return(checkLines)
    }





print.wordlist =
    function(x, ...) {
      for (i in 1:length(x)) {
        cat(paste0("File: ", names(x)[i], "\n"))
        cat(paste0(names(x[[i]]), " ", gsub(",", " ", x[[i]]), "\n"))
      }
    }


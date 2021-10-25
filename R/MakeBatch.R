# getting some useful batch files for processing R scripts and Rmarkdown files.
# Windows users only

MakeBatch =
    function(file = NULL) {
      if (interactive()) {
        if (.Platform$OS.type == "windows") {
          RHome = gsub("/", "\\\\", Sys.getenv("R_HOME"))
          if (is.null(file)) {
            # write a batch file for processing R scripts
            cat(paste0(RHome, "\\bin\\R.exe CMD BATCH --vanilla --quiet %1\n"),
                file = "RBatch.bat")
            .NewFile(file = "RBatch.bat")
            # write a batch file for processing a specific R markdown file
            cat(paste0(RHome,
                       "\\bin\\RScript.exe --vanilla -e \"rmarkdown::render('%1')\"\n"),
                file = "RmdBatch.bat")
                        .NewFile(file = "RmdBatch.bat")
            # write a batch file for processing all R markdown files
            cat(paste0(RHome, '\\bin\\Rscript.exe --vanilla -e "BrailleR::ProcessAllRmd()"\n'),
                file = "ProcessAllRmd.bat")
                        .NewFile(file = "ProcessAllRmd.bat")
            # write a batch file for processing all markdown files
            cat(paste0(RHome, '\\bin\\Rscript.exe --vanilla -e "BrailleR::ProcessAllMd()"\n'),
                file = "ProcessAllMd.bat")
                                    .NewFile(file = "ProcessAllMd.bat")

            message(
                "These files need to be moved to a folder that is on your system path.")
            # write a file to show the system path settings
            cat(Sys.getenv("PATH"), file = "path.txt")
            message("These details are saved in path.txt for reference.")
            # write a test Rmd file
            cat("# a test file
## created by the BrailleR package

My R version is `r version$major`.`r version$minor` and is being used to create this test file
It will then be used to process the test file later once the necessary actions are taken in Windows Explorer.  \n",
                file = "test1.Rmd")
                                    .NewFile(file="test1.Rmd")
            MakeBatch("test1.Rmd")
            # write a test R script
            cat("# a test file
## created by the BrailleR package

MySample=sample(100, 10)
MySample
mean(MySample)  \n",
                file = "test2.R")
            cat("test2.R created successfully.\n")
            MakeBatch("test2.R")
            message(
                "Consult the help page for guidance on using these files in Windows Explorer.")
          } else {
            if (!file.exists(file))
              warning(paste0('The specified file "', file,
                             '" does not currently exist.\n'))
            FullFile = unlist(strsplit(file, split = ".", fixed = TRUE))
            if (endsWith(file, ".R") | endsWith(file, ".r")) {
              # write a batch file for processing the R script
              cat(paste0(RHome, "\\bin\\R.exe CMD BATCH --vanilla --quiet ",
                         FullFile[1], ".R\n"),
                  file = paste0(FullFile[1], ".bat"))
                                      .NewFile(file = paste0(FullFile[1], ".bat"))
            }
            if (endsWith(file, ".Rmd") | endsWith(file, ".rmd")) {
              # write a batch file for processing the R markdown file
              cat(paste0(RHome, "\\bin\\RScript.exe -e \"rmarkdown::render('",
                         FullFile[1], ".Rmd')\"\n"),
                  file = paste0(FullFile[1], ".bat"))
                                      .NewFile(file = paste0(FullFile[1], ".bat"))
            }
          }
        } else {
          .WindowsOnly()
        }
      } else {
        .InteractiveOnly()
      }
      return(invisible(NULL))
    }

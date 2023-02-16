# file contains MakeAllInOneSlide(), MakeSlidy(),  and MakeSlideShow()
## all deprecated

MakeAllInOneSlide =
    function(Folder, Style = getOption("BrailleR.SlideStyle"), file = NULL) {

      if (dir.exists(Folder)) {  # only continue if the folder specified exists

        # find the CSS file wanted.
        StyleUsed = FindCSSFile(Style)
        if (file.exists(paste0("./", Folder, "/", Style))) {
          StyleUsed = paste0("./", Folder, "/", Style)
        }

        if (!is.null(StyleUsed)) {  # only continue if a css file was found
          # get lists of master slides and output slide
          MasterSlideSet =
              list.files(path = Folder, pattern = "Rmd", full.names = TRUE)

          OutRMD = paste0(file, ".Rmd")
          OutMD = paste0(file, ".md")

          cat("<!---
 one HTML document to concatinate an entire slide show presented as a series of HTML slides.
--->\n\n",
              file = OutRMD)

          file.append(OutRMD, MasterSlideSet)
          cat("\n\n", file = OutRMD, append = TRUE)

          knit2html(OutRMD, stylesheet = StyleUsed)
          # remove temporary files
          file.remove(OutRMD)
          file.remove(OutMD)

        }  # end css file condition
            else {
          ## war ning("Cannot find the specified css file.")
        }
      }  # end folder existence condition
          else {
        .FolderNotFound()
 .NoActionTaken()
      }
      return(invisible(NULL))
    }



MakeSlidy =
    function(Folder, file = NULL) {

      if (dir.exists(Folder)) {  # only continue if the folder specified exists

          # get lists of master slides and output slide
          MasterSlideSet =
              list.files(path = Folder, pattern = "Rmd", full.names = TRUE)

          OutRMD = paste0(file, ".Rmd")
          OutMD = paste0(file, ".md")

          cat("<!---
Slidy presentation
--->\n\n",
              file = OutRMD)

          file.append(OutRMD, MasterSlideSet)
          cat("\n\n", file = OutRMD, append = TRUE)

          rmarkdown::render(OutRMD, output_format=slidy_presentation())
      }  # end folder existence condition
          else {
        .FolderNotFound()
 .NoActionTaken()
      }
      return(invisible(NULL))
    }


MakeSlideShow =
    function(Folder, Style = getOption("BrailleR.SlideStyle"),
             ContentsSlide = TRUE) {

      if (dir.exists(Folder)) {  # only continue if the folder specified exists

        # find the CSS file wanted.
        StyleUsed = FindCSSFile(Style)
        if (file.exists(paste0("./", Folder, "/", Style))) {
          StyleUsed = paste0("./", Folder, "/", Style)
        }

        if (!is.null(StyleUsed)) {  # only continue if a css file was found
          # get lists of master slides and output slides
          MasterSlideSet =
              list.files(path = Folder, pattern = "Rmd", full.names = TRUE)
          SlideSet = gsub(paste0(Folder, "/"), "", MasterSlideSet)
          OutSet = gsub(".Rmd", ".html", SlideSet)
          # make temporary copy of slides
          file.copy(from = MasterSlideSet, to = SlideSet, overwrite = TRUE)

          if (ContentsSlide) {
            cat("## Contents\n\n", file = "00_Contents.Rmd")
            for (i in SlideSet) {  # add contents link
              cat("\n\n[contents](00_Contents.html)", file = i, append = TRUE)
              temp = readLines(i, n = 5)
              temp = temp[temp != ""]
              cat(paste0("#", temp[1], "\n\n"), file = "00_Contents.Rmd",
                  append = TRUE)
              cat(paste0("[", gsub(".Rmd", "", i), "](",
                         gsub(".Rmd", ".html", i), ")\n\n"),
                  file = "00_Contents.Rmd", append = TRUE)
            }
            knit2html("00_Contents.Rmd", stylesheet = StyleUsed)
            file.remove("00_Contents.md")
            file.remove("00_Contents.Rmd")
          }

          for (i in 2:length(SlideSet)) {  # add back link
            cat(paste0("\n\n[back](", OutSet[i - 1], ")\n"), file = SlideSet[i],
                append = TRUE)
          }
          for (i in 1:(length(SlideSet) - 1)) {  # add next link
            cat(paste0(" [next](", OutSet[i + 1], ")\n"), file = SlideSet[i],
                append = TRUE)
          }

          for (i in SlideSet) {
            knit2html(i, stylesheet = StyleUsed)
            # remove temporary files
            file.remove(sub(".Rmd", ".md", i))
            file.remove(i)
          }

        }  # end css file condition
            else {
          ## war ning("Cannot find the specified css file.")
        }
      }  # end folder existence condition
          else {
        .FolderNotFound()
 .NoActionTaken()
      }
      return(invisible(NULL))
    }

MakeAllInOneSlide = MakeSlidy = MakeSlideShow =
    function(...){
.DeprecatedFunction() 
}


 

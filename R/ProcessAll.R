ProcessAllRmd = function(dir =".", method = "render"){
      if (dir.exists(dir)) {
        RmdFiles = list.files(dir, pattern=".Rmd", full.names=TRUE) 
        }
        else stop("Specified folder does not exist.\n")
      if(method=="render"){
        for(i in RmdFiles){
          rmarkdown::render(i)
          }
        }
      else if(method=="knit2html"){
        for(i in RmdFiles){
          knitr::knit2html(i)
          }
        }
      else stop("Specified method is not yet available.\n")

      return(invisible(NULL))
      }

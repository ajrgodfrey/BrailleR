ProcessAllRmd = function(dir =".", method = "render"){
      if (dir.exists(dir)) {
        FileSet = list.files(dir, pattern="\\.Rmd$", full.names=TRUE) 
        }
        else stop("Specified folder does not exist.\n")
.ProcessAll(dir = dir, method = method, FileSet)
      return(invisible(NULL))
}

ProcessAllMd = function(dir ="."){
      if (dir.exists(dir)) {
        FileSet = list.files(dir, pattern="\\.md$", full.names=TRUE) 
        }
        else stop("Specified folder does not exist.\n")
.ProcessAll(dir = dir, FileSet = FileSet)
      return(invisible(NULL))
}

.ProcessAll = function(dir =".", method = "render", FileSet){
      if(method=="render"){
        for(i in FileSet){
          rmarkdown::render(i, output_format = "all")
          }
        }
      else if(method=="knit2html"){
        for(i in FileSet){
          knitr::knit2html(i)
          }
        }
      else stop("Specified method is not yet available.\n")
      return(invisible(NULL))
      }

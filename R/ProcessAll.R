ProcessAllRmd = function(dir =".", method = "render"){
      if (dir.exists(dir)) {
        FileSet = list.files(dir, pattern="\\.Rmd$", full.names=TRUE) 
        }
        else stop("Specified folder does not exist.\n")
.ProcessAll(dir = dir, method = method, FileSet, Extension=".Rmd")
      return(invisible(NULL))
}

ProcessAllMd = function(dir ="."){
      if (dir.exists(dir)) {
        FileSet = list.files(dir, pattern="\\.md$", full.names=TRUE) 
        }
        else stop("Specified folder does not exist.\n")
.ProcessAll(dir = dir, FileSet = FileSet, Extension=".md")
      return(invisible(NULL))
}

.ProcessAll = function(dir =".", method = "render", FileSet, Extension=".Rmd") {
        for(i in FileSet){
Outfile = sub(Extension, ".html", i)
if(file.mtime(i) > file.mtime(Outfile)| !file.exists(Outfile)) {
RemoveBOM(i)
      if(method=="render"){
          rmarkdown::render(i, output_format = "all")
          }
      else if(method=="knit2html"){
          knitr::knit2html(i)
          }
      else {stop("Specified method is not yet available.\n")}
}
}
      return(invisible(NULL))
      }

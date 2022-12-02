
MakeReadable =
    function(pkg) {
      if (.Platform$OS.type == "windows") {
          if (requireNamespace(pkg, ) ) {
            # move files here for subsequent conversion
            VignetteFolder = paste0(system.file(package = pkg), "/doc")
            RnwFiles = c(list.files(path = VignetteFolder, pattern = "Rnw", full.names=TRUE),
                         list.files(path = VignetteFolder, pattern = "rnw", full.names=TRUE))
            MyVignettesFolder =
                paste0(getOption("BrailleR.Folder"), "/Vignettes/")
            if (!dir.exists(MyVignettesFolder)) dir.create(MyVignettesFolder)

FinalMoveTo = paste0(MyVignettesFolder, pkg, "/")
            if (!dir.exists(FinalMoveTo)) dir.create(FinalMoveTo)
FinalMoveTo = MyVignettesFolder

OriginalDir = getwd()

MoveTo=pkg
dir.create(MoveTo)


            file.copy(RnwFiles,
                      MoveTo,  overwrite = TRUE)

setwd(MoveTo)

            RnwFiles = c(list.files(pattern = "Rnw"),
                         list.files(pattern = "rnw"))

              # Copying and converting line breaks

            for (i in RnwFiles) {
try(Sweave(i))
}

TeXFiles = list.files(pattern=".tex")

#if(nzchar(Sys.which("htmlblahlatex"))){
# try to use tex4ht
# shoudl fail because if() is flaweed on purpose while developing.
#} else {
# use pandoc
HTMLFile=gsub(".tex", ".html", i)
shell(paste("pandoc", i, "-o", HTMLFile))
#}
setwd(OriginalDir)

file.copy(MoveTo, FinalMoveTo, overwrite=TRUE)
unlink(MoveTo)

          } else {
            .PkgNotFound()
          }
      } else {
        .WindowsOnly()
      }
      return(invisible(NULL))
    }


.RemoveWhiteSpace = function(file){
.Done()
writeLines(gsub("  *", " ", readLines(file)), file)
return(invisible(NULL))
}



.RemoveTabs = function(file){
              # Converting tabs to spaces
writeLines(gsub("\t", "    ", readLines(file)), file)
#              shell(paste0(system.file(
#                               "Python/RemoveTabs.py", package = "BrailleR"),
#                           ' "', file, '"'))
return(invisible(NULL))
}

.MakeBackUp = function(file){
OldFile=paste0(file, ".bak")
file.copy(file, OldFile)
return(invisible(NULL))
}



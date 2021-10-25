
MakeReadable =
    function(pkg) {
      if (.Platform$OS.type == "windows") {
        if (TestPython()) {
          if (requireNamespace(pkg, ) ) {
            # move files here for subsequent conversion
            VignetteFolder = paste0(system.file(package = pkg), "/doc")
            RnwFiles = c(list.files(path = VignetteFolder, pattern = "Rnw", full.names=TRUE),
                         list.files(path = VignetteFolder, pattern = "rnw", full.names=TRUE))
            MyVignettesFolder =
                paste0(getOption("BrailleR.Folder"), "/Vignettes/")
            if (!dir.exists(MyVignettesFolder)) dir.create(MyVignettesFolder)
            MoveTo = paste0(MyVignettesFolder, pkg, "/")
            if (!dir.exists(MoveTo)) dir.create(MoveTo)
            file.copy(RnwFiles,
                      MoveTo,  overwrite = TRUE)

OriginalDir = getwd()
setwd(MoveTo)

            RnwFiles = c(list.files(pattern = "Rnw"),                         list.files(pattern = "rnw"))

            for (i in RnwFiles) {
try(Sweave(i))
}

TeXFiles = list.files(pattern=".tex")

if(nzchar(Sys.which("htmlblahlatex"))){
# try to use tex4ht
# shoudl fail because if() is flaweed on purpose while developing.
} else {
# use pandoc
HTMLFile=gsub(".tex", ".html", i)
shell(paste("pandoc -s", i, "-o", HTMLFile))
}


setwd(OriginalDir)
          } else {
            .PkgNotFound()
          }
        } else {
          .NeedsPython()
        }
      } else {
        .WindowsOnly()
      }
      return(invisible(NULL))
    }


.RemoveWhiteSpace = function(){

#              message("Copying and converting line breaks:", i)
#              shell(paste0(system.file(
#                               "Python/FixLineBreaks.py", package = "BrailleR"),
#                           " ", MoveTo, "/", i))
#              message("Converting tabs to spaces:", i)
#              shell(paste0(system.file(
#                               "Python/RemoveTabs.py", package = "BrailleR"),
#                           " ", MoveTo, "/", i))

}

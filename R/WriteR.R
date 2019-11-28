
.IsWriteRAvailable =
    function(){
      Success = FALSE
      PyExists = TestPython()
      if(PyExists && .IsWxAvailable()){
        Success=TRUE
      }else{
        if(PyExists){
          Success = .PullWxUsingPip()
        }else{
          .NeedsPython()
        }
      }
      return(invisible(Success))
      }

# Running the WriteR application
# only for Windows users at present.

WriteR =
    function(file = NULL, math = c("webTeX", "MathJax")) {
      if (interactive()) {
        if (.Platform$OS.type == "windows") {
          if (.IsWriteRAvailable()) {
            if (!is.null(file)) {
              if (!file.exists(file)) {
                #cat("Starting new file\n", file = file)
                file.copy(system.file("Templates/simpleYAMLHeader.Rmd", package="BrailleR"), file)
              }
            }
            shell(paste0('"', file.path(system.file(
                            "Python/WriteR/WriteR.pyw", package = "BrailleR")), '" ',
                        ifelse(is.null(file), "", file)), wait=FALSE)
          } else {
            .NeedsWX()
            .InstallPython()
          }
        } else {
          .WindowsOnly()
        }
      } else {
        .InteractiveOnly()
      }
      return(invisible(NULL))
    }


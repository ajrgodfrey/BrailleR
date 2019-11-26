.IsWxAvailable =
    function(){
TestWx = system('python -c "import wx"')
return(TestWx == 0)
}



.IsWriteRAvailable =
    function(){
      Success = FALSE
      PyExists = nchar(Sys.which("python"))>0
      if(PyExists && .IsWxAvailable()){
        Success=TRUE
      }else{
        if(PyExists){
          Success = .PullWxUsingPip()
        }else{
          warning("This function requires installation of Python 3.0 or above.\n")
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
            warning(
                "This function requires an installation of Python and wxPython.\n")
            message(
                "You could use GetPython3() and GetWxPython3() to help install them.\n")
          }
        } else {
          warning(
              "This function is for users running R under the Windows operating system.\n")
        }
      } else {
        warning("This function is meant for use in interactive mode only.\n")
      }
      return(invisible(NULL))
    }


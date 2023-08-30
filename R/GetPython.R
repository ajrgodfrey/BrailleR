GetPython27 = function(...){
.DeprecatedFunction() 
}

GetWxPython27 =  function(...){
.DeprecatedFunction()
}

TestPython = function(){
HasPython=nzchar(Sys.which("python"))
if(HasPython){
.PythonVersion()
}
else{
.NoSeePython()
}
return(invisible(HasPython))
}


TestWX = function(){
if(TestPython()){
      if (interactive()) {
        if (.Platform$OS.type == "windows") {
shell(paste("python", system.file("Python/TestWX.py", package="BrailleR")))
        } else {
          .WindowsOnly()
        }
}
        if(.IsWxAvailable()){
 .CanSeeWxPython() 
.CanUseWriteR()
return(invisible(TRUE))}
else{ .CannotSeeWxPython() 
return(invisible(FALSE))}
}
}


.IsWxAvailable =
    function(){
TestWx = system('python -c "import wx"')
return(TestWx == 0)
}




GetPython = GetPython3 =
    function(x64=TRUE) {
      .GetPython(3, x64=x64)
      return(invisible(NULL))
    }

.GetPython =
    function(version, x64=x64) {
      if (interactive()) {
        if (.Platform$OS.type == "windows") {
          if (requireNamespace("BrailleR")) {
            if (requireNamespace("installr")) {
              .DownloadAFile()
bit = .ifelse(x64, 64, 32)
            installr::install.python(version_number = version, download_dir=getOption("BrailleR.Folder"), keep_install_file = TRUE, x64=x64)
             .Added2MyBrailleR()
             .DeleteAnytime()
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

.PullWxUsingPip = function(){
    if(.IsWxAvailable()){
        system("pip install --user -U wxPython")
        }
    else{
        system("pip install --user wxPython")
        }
        return(invisible(TRUE))
    }



GetWxPython = GetWxPython3 =
    function() {
      Success = FALSE
      if (interactive()) {
        if (.Platform$OS.type == "windows") {
          if(TestPython()){
.PullWxUsingPip()
          }
        } else {
          .WindowsOnly()
        }
      } else {
        .InteractiveOnly()
      }
      return(invisible(Success))
    }

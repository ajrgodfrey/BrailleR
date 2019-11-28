GetPython27 = .DeprocatedFunction 
GetWxPython27 = .DeprocatedFunction 


TestPython = function(){
if(nchar(Sys.which("python"))>0){
VersionString = system2("python", "--version", stdout=TRUE, stderr=TRUE)
message("Your system is using ", VersionString, "\n")
return(TRUE)
}
else{
.NoSeePython()
return(FALSE)
}
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
 message("Python can see the necessary wx module.\nYou are ready to use WriteR.\n")
return(invisible(TRUE))}
else{ message("Python cannot see the necessary wx module.\nYou need to get that fixed.\n")
return(invisible(FALSE))}
}
}


.IsWxAvailable =
    function(){
TestWx = system('python -c "import wx"')
return(TestWx == 0)
}




GetPython3 =
    function() {
      .GetPython(3)
      return(invisible(NULL))
    }

.GetPython =
    function(version) {
      if (interactive()) {
        if (.Platform$OS.type == "windows") {
          if (requireNamespace("BrailleR")) {
            if (requireNamespace("installr")) {
              .DownloadAFile()
#            installr::
.install.python(version_number = version, download_dir=getOption("BrailleR.Folder"), keep_install_file = TRUE)
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

GetWriteR = function(UseGitHub = TRUE) {
.TempUnavailable()
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



GetWxPython3 =
    function() {
      Success = FALSE
      if (interactive()) {
        if (.Platform$OS.type == "windows") {
          if(TestPython()){
          }
        } else {
          .WindowsOnly()
        }
      } else {
        .InteractiveOnly()
      }
      return(invisible(Success))
    }

.BlankMSG  =     function() {
return(invisible(NULL))
    }

.Added2MyBrailleR = function(){
            message(
                "The installer file has been added to your MyBrailleR folder.")
      return(invisible(NULL))
}

.DeleteAnytime  = function(){
              message(
                "You can delete it at any time, but that will not uninstall the application.")
      return(invisible(NULL))
}

.DownloadAFile = function(){
message(
                "This command will download a file and save it to your hard drive.")
      return(invisible(NULL))
}


.NoSeePython = function(){
message("Python cannot be seen on your system.\nIf it is installed, then you may need to ensure your system settings are correct.\n")
      return(invisible(NULL))
}

.InstallPython =     function() {
message(
                "You could use GetPython3() and GetWxPython3() to help install them.\n")
return(invisible(NULL))
    }


.TempUnavailable =     function() {
              message("This command is temporarily unavailable.\n")
      return(invisible(NULL))
    }

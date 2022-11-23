# add filenames to messages for file creation

.BlankMSG  =     function() {
message("")
return(invisible(NULL))
    }

.Added2MyBrailleR = function(){
message("The installer file has been added to your MyBrailleR folder.")
return(invisible(NULL))
}

.CannotSeeWxPython = function(){
message("Python cannot see the necessary wx module.\nYou need to get that fixed.")
return(invisible(NULL))
}



.CanSeeWxPython = function(){
message("Python can see the necessary wx module.")
return(invisible(NULL))
}

.CanUseWriteR  = function(){
message("You are ready to use WriteR.")
return(invisible(NULL))
}

.ConsultHelpPage  =     function() {
message("Consult the help page for guidance on using these files in Windows Explorer.")
return(invisible(NULL))
    }


.DeleteAnytime  = function(){
message("You can delete it at any time, but that will not uninstall the application.")
return(invisible(NULL))
}

.Done  = function(){
message("Done.")
return(invisible(NULL))
}

.DownloadAFile = function(){
message("This command will download a file and save it to your hard drive.")
return(invisible(NULL))
}


.FileCreated =     function(file=NULL) {
NewFile = ifelse(is.null(file), "", file)
message(NewFile, " has been created in your MyBrailleR directory.")
return(invisible(NULL))
    }


.InstallPython =     function() {
message("You could use GetPython3() and GetWxPython3() to help install them.")
return(invisible(NULL))
    }

.MoveOntoPath=     function() {
message("These files need to be moved to a folder that is on your system path.")
return(invisible(NULL))
    }


.NewFile =     function(file=NULL) {
NewFile = ifelse(is.null(file), "", file)
message(NewFile, " has been created in your working directory.")
return(invisible(NULL))
    }

.NoSeePython = function(){
message("Python cannot be seen on your system.\nIf it is installed, then you may need to ensure your system settings are correct.")
return(invisible(NULL))
}

.NothingDoneGraph =     function() {
message("Nothing done to augment this graph object.")
return(invisible(NULL))
    }


.PythonVersion =     function() {
VersionString = system2("python", "--version", stdout=TRUE, stderr=TRUE)
message("Your system is using ", VersionString, "")
return(invisible(NULL))
    }




.SVGAndXMLMade =     function() {
message("SVG and XML files created successfully.")
return(invisible(NULL))
    }


.TempUnavailable =     function() {
  message("This command is temporarily unavailable.")
return(invisible(NULL))
    }

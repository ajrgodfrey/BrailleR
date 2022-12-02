# add filenames to messages for file creation


.BlankMSG =     function() {
message("")
return(invisible(NULL))
}

.Added2MyBrailleR = function(){
message("The installer file has been added to your MyBrailleR folder.")
return(invisible(NULL))
}


        .AnswerQuestions=function(){
message("You will be asked to enter answers for a series of questions.\nHit <enter> to use the default shown in parentheses.")
return(invisible(NULL))
}

.AuthorName =     function() {
message("\nEnter the name you want to use for authoring content. (",
                getOption("BrailleR.Author"), ")")
return(invisible(NULL))
    }

.AutoLoadBrailleR  =     function() {
message("The BrailleR package will be automatically loaded on startup in this working directory.")
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


.FileCreated =     function(file=NULL, where="in your MyBrailleR directory.") {
NewFile = ifelse(is.null(file), "", file)
message(NewFile, " has been created ", where)
return(invisible(NULL))
    }

.FileUpdated =     function(file=NULL, where="in your MyBrailleR directory.") {
NewFile = ifelse(is.null(file), "", file)
message(NewFile, " has been updated ", where)
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

.NoActionTaken =     function() {
message("No action taken.")
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

.NoVIMethod =     function() {
      message("There is no specific method written for  this type of object.\n")
      message("You might try to use the print() function on the object or the str() command to investigate its contents.\n")
      return(invisible(NULL))
    }


.OptionLocal =     function() {
message("The new setting will remain in effect next time you load the BrailleR package in this directory.")
return(invisible(NULL))
}

.OptionPermanent =     function() {
message("and has overwritten the setting for all folders.")
return(invisible(NULL))
}



.OptionUpdated =     function(option, to=NULL) {
message("The BrailleR.", option, " option has been updated", ifelse(is.null(to), "", paste0("to ", to ), ".")
return(invisible(NULL))
}


.OriginalDefaults =     function() {
message("You have reset all preferences to the original package defaults.\n")
return(invisible(NULL))
}


.PythonVersion =     function() {
VersionString = system2("python", "--version", stdout=TRUE, stderr=TRUE)
message("Your system is using ", VersionString, "")
return(invisible(NULL))
    }

.SavedInPath =     function() {
message("These details are saved in path.txt for reference.")
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


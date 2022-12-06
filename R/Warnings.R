
.BlankWarning =     function() {
warning("")
return(invisible(NULL))
}

.CannotSeeWxPython = function(){
warning("Python cannot see the necessary wx module.You need to get that fixed.")
return(invisible(NULL))
}


.DeprecatedFunction =     function() {
warning("This function has been deprecated.")
return(invisible(NULL))
}




.DownloadAFile = function(){
warning("This command will download a file and save it to your hard drive.")
return(invisible(NULL))
}


.ExpectingText =     function() {
warning("A text string was expected. No action taken.")
return(invisible(NULL))
}

.ExperimentalFunction =     function() {
warning("This function is purely experimental. Use it at your own risk.")
return(invisible(NULL))
}

.FileDoesNotExist =     function(file=NULL) {
warning(ifelse(is.null(file), "The specified file", file),  " does not exist.")
return(invisible(NULL))
}

.FileExists =     function(file) {
warning(file, "already exists.")
return(invisible(NULL))
}





.FolderNotFound =     function(folder=NULL) {
warning(ifelse(is.null(folder), "The specified folder", folder),  " does not exist.")
return(invisible(NULL))
}


.InteractiveOnly =     function() {
warning("This function is meant for use in interactive mode only.")
return(invisible(NULL))
}


.NeedsPython =     function() {
warning("This function requires installation of Python 3.0 or above.")
return(invisible(NULL))
}

.NeedsWX =     function() {
warning("This function requires an installation of Python and wxPython.")
return(invisible(NULL))
}


.NoConversion =     function() {
warning("There was a problem and no conversion was possible.")
return(invisible(NULL))
}

.NoGraphicsDevice =     function() {
warning("There is no current graphics device to investigate.")
return(invisible(NULL))
}




.OverWriteNeeded =     function(file=NULL) {
warning("No action has been taken. Use `Overwrite=TRUE` if you want to replace it.")
return(invisible(NULL))
}


.PkgNotFound =     function(Pkg=NULL) {
warning("The ", ifelse(is.null(Pkg), "specified package", Pkg),  " does not exist.")
return(invisible(NULL))
}

.TempUnavailable =     function() {
message("This command is temporarily unavailable.")
return(invisible(NULL))
}



.WindowsOnly =     function() {
warning("This function is for users running R under the Windows operating system.")
return(invisible(NULL))
}

.BlankWarning  =     function() {
warning("\n")
return(invisible(NULL))
    }

.DeprecatedFunction =     function() {
warning("This function has been deprecated.\n")
return(invisible(NULL))
    }


.FileExists =     function(file) {
warning(file, "already exists.\n")
return(invisible(NULL))
    }

.FileNotFound =     function() {
warning("The specified file does not exist.\n")
return(invisible(NULL))
    }


.FolderNotFound =     function() {
warning("The specified folder does not exist.\n")
return(invisible(NULL))
    }


.InteractiveOnly =     function() {
warning("This function is meant for use in interactive mode only.\n")
return(invisible(NULL))
    }


.NeedsPython =     function() {
 warning("This function requires installation of Python 3.0 or above.\n")
return(invisible(NULL))
    }

.NeedsWX =     function() {
warning("This function requires an installation of Python and wxPython.\n")
return(invisible(NULL))
    }




.OverWriteNeeded =     function(file=NULL) {
warning("No action has been taken. Use `Overwrite=TRUE` if you want to replace it.\n")
return(invisible(NULL))
    }


.PkgNotFound =     function() {
warning("The specified package is not installed.\n")
return(invisible(NULL))
    }



.WindowsOnly =     function() {
warning("This function is for users running R under the Windows operating system.\n")
return(invisible(NULL))
    }

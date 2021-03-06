.BlankWarning  =     function() {
return(invisible(NULL))
    }

.DeprecatedFunction =     function() {
warning("This function has been deprecated.\n")
return(invisible(NULL))
    }

.FileNotFound =     function() {
warning("The specified file does not exist.\n")
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



.WindowsOnly =     function() {
warning("This function is for users running R under the Windows operating system.\n")
return(invisible(NULL))
    }

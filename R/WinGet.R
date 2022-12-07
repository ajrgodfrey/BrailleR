## These commands can only be called from functions that have done OS checking
## They are left as internal commands for this reason
## the first function is the wrapper for the command line tool, and nothing more


## once working, look to update GetPython.R GetSoftware.R  and installPython.R

.winget = function(what, action=c("upgrade", "install", "show", "uninstall")){
    Out = shell(paste("winget", action, what), intern=TRUE)
    return(Out)
}



# possibly create .winget7Zip .wingetMaxima and/or .wingetOctave

.wingetPandoc = function(){
    action =  .ifelse(rmarkdown::pandoc_available(), "upgrade", "install")
    return(.winget("pandoc", action))
}

# possibly create .wingetPython but need to wait for wxPython to be 3.10 compliant

.wingetQuarto = function(){
    action = .ifelse(is.null(quarto::quarto_path()), "install", "upgrade")
    return(.winget("Quarto", action))
}


## N.B. there is no "upgrade" of R, just installation of the latest version
.wingetR=function(){
    return(.winget("RProject.R", "install"))
}

# possibly create .wingetRStudio

# possibly create .wingetRTools

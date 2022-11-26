## These commands can only be called from functions that have done OS checking
## They are left as internal commands for this reason
## the first function is the wrapper for the command line tool, and nothing more

.winget = function(what, action=c("upgrade", "install", "show", "uninstall")){
paste("winget", action, what)
}



wingetPandoc = function(){
    action =  ifelse(rmarkdown::pandoc_available(), "upgrade", "install")
    return(.winget("pandoc", action))
}

.wingetQuarto = function(){
    action = ifelse(is.null(quarto::quarto_path()), "install", "upgrade")
    return(.winget("Quarto", action))
}


## N.B. there is no "upgrade" of R, just installation of the latest version
.wingetR=function(){
    return(.winget("RProject.R", "install"))
}


SetupBrailleR= function(){
    defaultPath = "~/MyBrailleR/"
    defaultPath <- normalizePath(defaultPath, mustWork=FALSE)
    tempPath <- tempdir()

    if (dir.exists(defaultPath)) {
       tempPath <- defaultPath
      }
     else if (interactive()) {
        prompt <- "The BrailleR package needs to create a directory that will hold your files.\n
It is convenient to use one in your home directory, because \nit remains after restarting R.\n\n"

        prompt <- c(prompt, sprintf("Do you wish to create the '%s' directory? \nIf not, a temporary directory (%s) that is specific to this R session will be used.\n", 
            defaultPath, tempPath))
message(prompt)

UserPref = menu(list(paste("Yes: create", defaultPath, "now"), "No, use a temporary folder"), title = "Do you want to create the (almost) permanent folder?")
if(UserPref==1){
    dir.create(defaultPath)
cat("This folder is for the BrailleR package to be used with the R statistical software application.\nIt was created on", format(Sys.Date(), "%A %d %B %Y"), "\nusing version", as.character(packageVersion("BrailleR")), "of BrailleR.\n", file= paste0(defaultPath, "Readme.txt"))
message("Using the permanent folder for this session and every session from now onwards.\nYou can delete the folder at any time.")
        tempPath <- defaultPath
}
else {message("Using a temporary folder for this session.\nN.B. You will be asked again next time you load the BrailleR package.")}
}

# move various options and settings files here, use overwrite=FALSE
    BrailleRSettings = system.file("BrailleROptions", package="BrailleR")
file.copy(BrailleRSettings, paste0(tempPath, "BrailleROptions"), overwrite=FALSE)
    WriteRSettings = system.file("WriteROptions", package="BrailleR")
file.copy(WriteRSettings, paste0(tempPath, "WriteROptions"), overwrite=FALSE)

return(    invisible(tempPath))
}

SetupBrailleR= function(){
    defaultPath = "~/MyBrailleR/"
    defaultPath <- normalizePath(defaultPath, mustWork=FALSE)
Folder=NULL

    if (dir.exists(defaultPath)) {
Folder=normalizePath(defaultPath)
.MoveBrailleRFiles(Folder)
      }
     else if (interactive()) {
        prompt <- "The BrailleR package needs to create a directory that will hold your files.\n
It is convenient to use one in your home directory, because \nit remains after restarting R.\n\n"

        prompt <- c(prompt, sprintf("Do you wish to create the '%s' directory?\n", 
            defaultPath))
message(prompt)

UserPref = menu(list(paste("Yes: create", defaultPath, "now"), "No,not this time"), title = "Do you want to create the (almost) permanent folder?")
if(UserPref==1){
    dir.create(defaultPath)
cat("This folder is for the BrailleR package to be used with the R statistical software application.\nIt was created on", format(Sys.Date(), "%A %d %B %Y"), "\nusing version", as.character(utils::packageVersion("BrailleR")), "of BrailleR.\n", file= file.path(defaultPath, "Readme.txt"))
message("Using the permanent folder for this session and every session from now onwards.\nYou can delete the folder at any time.")
Folder=normalizePath(defaultPath)
.MoveBrailleRFiles(Folder)
}
else {message("N.B. You will be asked again next time you load the BrailleR package.")}
}
return(invisible(Folder))
}

.MoveBrailleRFiles= function(Folder){
Folder <- normalizePath(Folder, mustWork=FALSE)

# move various options and settings files here, use overwrite=FALSE
    BrailleRSettings = system.file("BrailleROptions", package="BrailleR")
file.copy(BrailleRSettings, Folder, overwrite=FALSE)
    WriteRSettings = system.file("WriteROptions", package="BrailleR")
file.copy(WriteRSettings, file.path(Folder, "WriteROptions"), overwrite=FALSE)
if(!dir.exists(file.path(Folder, "css"))){dir.create(file.path(Folder, "css"))}
CSSFolder = file.path(system.file(package="BrailleR"), "css")
CSSFiles=list.files(path=CSSFolder, pattern="css")
file.copy(file.path(CSSFolder, CSSFiles), file.path(Folder, "css", CSSFiles), overwrite=FALSE)

return(    invisible(NULL))
}

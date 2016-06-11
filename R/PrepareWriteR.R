# Getting started with the WriteR application
# only for Windows users at present.

PrepareWriteR = function(Author=getOption("BrailleR.Author")){
if(interactive()){
if(.Platform$OS.type=="windows"){
RHome= gsub("/", "\\\\\\\\", Sys.getenv("R_HOME"))
MyHome = gsub("/", "\\\\\\\\", gsub("\\\\", "/", Sys.getenv("HOME")))

cat(paste0('{
    "RDirectory": "', RHome, '\\\\bin\\\\', version$arch, '\\\\Rscript.exe",
    "filename": "untitled.Rmd",
    "newText": "# \\n## by ', Author, ' on \\n\\n",
}
'), file='WriteROptions')

message("The settings file for WriteR has been created.")

file.copy(paste0(system.file(package="BrailleR"), "/Python/Writer/", c("WriteR.pyw", "HelpPage.html", "HelpPage.Rmd", "Basics.Rmd")), ".")
message("Copies of the main wxPython script and help page documents have been copied \ninto your working directory.")
message("You can move these files to your preferred folder for WriteR, \nor start working here.")
}
else{warning("This function is for users running R under the Windows operating system.\n")}
}
else{warning("This function is meant for use in interactive mode only.\n")}
return(invisible(NULL))
}


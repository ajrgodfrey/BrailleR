

GetWriteR= function(UseGitHub = TRUE){
if(interactive()){
if(.Platform$OS.type=="windows"){
if(require(BrailleR)){
if(UseGitHub){
download.file("https://raw.github.com/ajrgodfrey/WriteR/master/Python/WriteR.zip", "WriteR.zip")
}
else{
download.file("http://R-Resources.massey.ac.nz/WriteR/WriteR.zip", "WriteR.zip")
}
unzip("WriteR.zip")
file.remove("WriteR.zip")
file.rename("WriteR.exe", paste0(getOption("BrailleR.Folder"), "WriteR.exe"))
message('The WriteR application has been added to your MyBrailleR folder.\nIt is assumed you wanted to download this file by issuing the last command.\nYou can delete "WriteR.exe" at any time to remove WriteR from your system.\n')
}
} else{warning("This function is for users running R under the Windows operating system.\n")}
} else{warning("This function is meant for use in interactive mode only.\n")}
return(invisible(NULL))
}

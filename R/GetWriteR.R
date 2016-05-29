

GetWriteR= function(){
if(interactive()){
if(.Platform$OS.type=="windows"){
if(require(BrailleR)){
download.file("http://R-Resources.massey.ac.nz/WriteR/WriteR.exe", paste0(getOption("BrailleR.Folder"), "WriteR.exe"))
}
} else{warning("This function is for users running R under the Windows operating system.\n")}
} else{warning("This function is meant for use in interactive mode only.\n")}
return(invisible(NULL))
}

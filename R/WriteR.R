# Running the WriteR application
# only for Windows users at present.

WriteR = function(file=NULL, math = c("webTeX", "MathJax")){
if(interactive()){
if(.Platform$OS.type=="windows"){
#shell.exec(system.file("Python/WriteR/WriteR.pyw", package="BrailleR"))
} else{warning("This function is for users running R under the Windows operating system.\n")}
} else{warning("This function is meant for use in interactive mode only.\n")}
return(invisible(NULL))
}


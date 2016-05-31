
BrailleRHome = function(){
if(interactive()){
browseURL("http://R-Resources.massey.ac.nz/BrailleR/")
} else{warning("This function is meant for use in interactive mode only.\n")}
return(invisible(NULL))
}

LURN = function(BlindVersion = getOption("BrailleR.VI")){
if(interactive()){
if(BlindVersion){
browseURL("http://R-Resources.massey.ac.nz/LURNBlind/front.html")
}
else{
browseURL("http://R-Resources.massey.ac.nz/LURN/front.html")
}
} else{warning("This function is meant for use in interactive mode only.\n")}
return(invisible(NULL))
}
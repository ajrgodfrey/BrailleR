#' @rdname BrailleRHome
#' @title Open the BrailleR Project home page in your browser
#' @aliases BrailleRHome
#' @description  Visit the BrailleR Project home page for updates, instructions on how to join the mailing list which we call BlindRUG and get the latest downloads.
#' @return Nothing. The functionis for opening a web page and nothing will result in the R session.

#' @author A. Jonathan R. Godfrey
#' @export BrailleRHome

BrailleRHome= function(){
if(interactive()){
browseURL("http://R-Resources.massey.ac.nz/BrailleR/")
} else{warning("This function is meant for use in interactive mode only.\n")}
return(invisible(NULL))
}

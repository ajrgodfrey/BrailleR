#' @rdname AutoSpellCheck
#' @title Automatic fixing of typos
#' @aliases AutoSpellCheck
#' @description  Fix up all those annoying typos that come up far too often.
#' @details The word list of typos and their corrections is called \file{AutoSpellList.csv} and is stored in the user's MyBrailleR folder. The file can be updated to meet the user's specific needs. It should not be over-written by a new installation of BrailleR.
#' @return NULL. This function only affects external files.
#' @export AutoSpellCheck

#' @param file A vector of files to be checked

AutoSpellCheck= function(file){
if(interactive()){
if(require(BrailleR)){
ChangeList = read.csv(paste0(getOption("BrailleR.Folder"), "AutoSpellList.csv"))
for(i in 1:length(ChangeList$OldString)){
FindReplace(file, ChangeList$OldString[i], ChangeList$NewString[i])
}
}
}
else{warning("This function is meant for use in interactive mode only.\n")}
return(invisible(NULL))
}


SpellCheckFiles= function(file = ".", ignore = character()) 
{
    ignore <- c(hunspell::en_stats, ignore)
if(dir.exists(file)){
filenames = list.files(file)
    checkFiles <- normalizePath(paste0(file, "/", filenames))
}
else{
filenames= checkFiles <- file
}
    checkLines=list()
    checkLines <- lapply(checkFiles, devtools:::spell_check_file, ignore = ignore)
names(checkLines)=filenames
class(checkLines) = "wordlist"
return(    checkLines )
}





print.wordlist = function(x, ...){
for(i in 1:length(x)){
cat(paste0("File: ", names(x)[i], "\n"))
cat(paste0(names(x[[i]]), " ", gsub(",", " ", x[[i]]), "\n")) 
}
}


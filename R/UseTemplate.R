UseTemplateList = function(newfile, fileList, find=NULL, replace=NULL){
for(i in fileList){
cat(UseTemplate(i, find=find, replace=replace), file=newfile, append=TRUE)
}
return(invisible(NULL))
}


UseTemplate = function(file, find=NULL, replace=NULL){
TXT = readLines(system.file(paste0("Templates/", file), package="BrailleR"))
if(!is.null(replace)){
for(i in 1:length(replace)){
TXT = gsub(find[i], replace[i], TXT)
}
}
return(paste0(TXT, collapse="\n"))
}


.UseTemplate = function(templateFile, NewFile=NULL, Changes=list()){
TXT = readLines(system.file(paste0("Templates/", templateFile), package="BrailleR"))
whisker.render(template=templateFile, data=Changes)
OutText = paste0(TXT, collapse="\n")
if(!is.null(NewFile)){ 
cat(OutText, file=NewFile)
.NewFile(NewFile)
}
return(OutText)
}


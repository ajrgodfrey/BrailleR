UseTemplateList = function(newfile, fileList, find=NULL, replace=NULL){
      if (interactive()) {
for(Template in fileList){
cat(UseTemplate(Template, find=find, replace=replace), file=newfile, append=TRUE)
}
      } else {
        .InteractiveOnly()
      }
return(invisible(TRUE))
}


UseTemplate = function(file, find=NULL, replace=NULL){
      if (interactive()) {
TXT = readLines(system.file(paste0("Templates/", file), package="BrailleR"))
if(!is.null(replace)){
for(i in 1:length(replace)){
TXT = gsub(find[i], replace[i], TXT)
}
}
      } else {
        .InteractiveOnly()
      }
return(paste0(TXT, collapse="\n"))
}


.UseTemplate = function(templateFile, NewFile=NULL, Changes=list()){
      if (interactive()) {
TXT = readLines(system.file(paste0("Templates/", templateFile), package="BrailleR"))
OutText = whisker.render(template=TXT, data=Changes)
if(!is.null(NewFile)){ 
cat(OutText, file=NewFile)
.NewFile(NewFile)
}
      } else {
        .InteractiveOnly()
      }
return(OutText)
}

.ChooseTemplate = function(){
      if (interactive()) {
Templates = read.csv(system.file("Templates/templates.csv", package="BrailleR"))
Types = as.character(unique(Templates$Type))
        UserPrefType = menu(Types,
                 title = "Which type of template do you want?")
Subset = Templates[Templates$Type == Types[UserPrefType], ]
        UserPrefFile = menu(Subset$Template,
                 title = "Which template do you want?")
file = Subset$Template[UserPrefFile]
message(paste("The", file, "uses the following terms that must be replaced:", Subset$Changes[UserPrefFile], "\nIt will ", Subset$Description[UserPrefFile]))
      } else {
        .InteractiveOnly()
file=NULL
      }
      } else {
        .InteractiveOnly()
      }
return(file)
}

.BuildRmdFile = function(TemplateList = c("simpleYAMLHeader.Rmd", "StandardSetupChunk.Rmd", "GetLibs.Rmd", "GetData.Rmd"), 
      Changes = list(), Outfile = "test.Rmd"){
      if (interactive()) {
for(Template in TemplateList){
cat(.UseTemplate(Template, Changes=Changes), "\n\n\n", file=Outfile, append=TRUE)
}
.NewFile(Outfile)
message("N.B. it will not be processed untill all {{.}} elements have been replaced with meaningful text.")
      } else {
        .InteractiveOnly()
      }
return(invisible(TRUE))
}

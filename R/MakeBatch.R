# getting some useful batch files for processing R scripts and Rmarkdown files.
# Windows users only

MakeBatch=function(file=NULL){
if(interactive()){
if(.Platform$OS.type=="windows"){
RHome = gsub("/", "\\\\", Sys.getenv("R_HOME"))
if(is.null(file)){
# write a batch file for processing R scripts
cat(paste0(RHome, "\\bin\\R.exe CMD BATCH --vanilla --quiet %1\n"), file="RBatch.bat")
message("RBatch.bat created successfully.")
# write a batch file for processing R markdown files
cat(paste0(RHome, "\\bin\\RScript.exe -e \"rmarkdown::render('%1')\"\n"), file="RmdBatch.bat")
message("RmdBatch.bat created successfully.")
message("These files need to be moved to a folder that is on your system path.")
# write a file to show the system path settings
cat(Sys.getenv("PATH"), file="path.txt")
message("These details are saved in path.txt for reference.")
# write a test Rmd file
cat("# a test file
## created by the BrailleR package

My R version is `r version$major`.`r version$minor` and is being used to create this test file
It will then be used to process the test file later once the necessary actions are taken in Windows Explorer.  \n", file="test1.Rmd")
message("test1.Rmd created successfully.")
MakeBatch("test1.Rmd")
# write a test R script
cat("# a test file
## created by the BrailleR package

MySample=sample(100, 10)
MySample
mean(MySample)  \n", file="test2.R")
cat("test2.R created successfully.\n")
MakeBatch("test2.R")
message("Consult the help page for guidance on using these files in Windows Explorer.")
}
else{
if(!file.exists(file)) warning(paste0('The specified file "', file, '" does not currently exist.\n'))
FullFile=unlist(strsplit(file, split=".", fixed=TRUE))
if(FullFile[2]=="R"){
# write a batch file for processing the R script
cat(paste0(RHome, "\\bin\\R.exe CMD BATCH --vanilla --quiet ", FullFile[1], ".R\n"), file=paste0(FullFile[1], ".bat"))
message(FullFile[1], ".bat created successfully.")
}
if(FullFile[2]=="Rmd"){
# write a batch file for processing the R markdown file
cat(paste0(RHome, "\\bin\\RScript.exe -e \"knitr::knit2html('", FullFile[1], ".Rmd')\"\n"), file=paste0(FullFile[1], ".bat"))
message(FullFile[1], ".bat created successfully.")
}
}
}
else{warning("This function is for users running R under the Windows operating system.\n")}
}
else{warning("This function is meant for use in interactive mode only.\n")}
return(invisible(NULL))
}

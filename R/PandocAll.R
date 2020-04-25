PandocAll = function(intype="docx", outtype="html"){

FileList=list.files(pattern=paste0(".",intype))

for(i in FileList){
Outfile = sub(paste0(".", intype), paste0(".", outtype),  i)
if(file.mtime(i) > file.mtime(Outfile)| !file.exists(Outfile)) {
shell(paste0('pandoc -s "', i, '" -o "', Outfile, '"'))
message(paste("File", i, "converted to", Outfile))
}
}



return(invisible(TRUE))
}

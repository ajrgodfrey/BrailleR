RemoveBOM = function(file){
FileLines = readLines(file)
Line1 = FileLines[1]

if(nchar(Line1)==6 & nchar(strsplit(Line1,"---")) ==3){
FileLines[1] = "---"
writeLines(FileLines, con=file)
message("BOM removed from file")
return(invisible(TRUE))
}
return(invisible(TRUE))
}



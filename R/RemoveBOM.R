RemoveBOM = function(File){
FileLines = readLines(File)
Line1 = FileLines[1]

if(nchar(Line1)==6 & nchar(strsplit(Line1,"---")) ==3){
FileLines[1] = "---"
writeLines(FileLines, con=File)
message("BOM removed from file")
return(invisible(TRUE))
}
return(invisible(TRUE))
}



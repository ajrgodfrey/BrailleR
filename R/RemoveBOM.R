RemoveBOM = function(file){
      if (interactive()) {
FileLines = readLines(file)
Line1 = FileLines[1]

if(nchar(Line1)==6 & nchar(strsplit(Line1,"---")) ==3){
FileLines[1] = "---"
writeLines(FileLines, con=file)
.Done()
return(invisible(TRUE))
}
      } else {
        .InteractiveOnly()
      }
return(invisible(TRUE))
}



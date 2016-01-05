txtOut=function(Filename=NULL){
if(is.null(Filename)){
message("Please enter a filename and press <enter>. \nPressing <enter> alone will generate a default  filename \nbased on the current date and time.\n")
Filename=scan(,what=character(0), quiet=TRUE)
FullFilename=paste0(Filename[1],".txt")
CommandSet=paste0(Filename[1],".R")
}
else{
FullFilename=paste(sub(".txt", "", Filename), "txt", sep=".")
CommandSet = paste(sub(".txt", "", Filename), "R", sep=".")
}
if(is.na(Filename[1])){
Now=date()
Year=substr(Now,21,24)
Month=substr(Now,5,7)
Day=substr(Now,9,10)
Hour=substr(Now,12,13)
Minute=substr(Now,15,16)
FullFilename=paste0("Term",Year,Month,Day, "-",Hour,Minute,".txt")
CommandSet=paste0("Hist",Year,Month,Day,"-",Hour,Minute,".R")
}
txtStart(file=FullFilename, cmdfile=CommandSet)
}


WhichFile = function(String, Folder, fixed=TRUE, DoesExist=TRUE){

Files=list.files(path=Folder, recursive =TRUE, full.names =TRUE)
Out=""
for(i in Files){

Text = readLines(i)
if(DoesExist){
if(any(grep(String, Text, fixed=fixed)))  Out=c(Out,i)}
else{
if(!any(grep(String, Text, fixed=fixed)))  Out=c(Out,i)}
}
return(Out)
}

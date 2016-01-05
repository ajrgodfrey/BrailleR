DataViewer=function(x, Update=FALSE, New=NULL, Filename=NULL){
# only for interactive sessions
if(interactive()){

# check here that x is one of data.frame, matrix, or a vector.
if(!is.data.frame(x) & !is.matrix(x) & !is.vector(x) ) {stop("Argument x must be a data.frame, matrix, or vector.")}

if(is.null(Filename)){
Filename=tempfile(pattern = "DV-", tmpdir=".", fileext = ".csv")
}
write.csv(x, file=Filename)
browseURL(Filename)

readline("Press <enter> once the viewing and editing is completed. \nOtherwise the temporary file will not be removed.")

if (Update){
if(is.null(New)){ New = "New"}

BringBack = read.csv(Filename, row.names=1)
# check for class of x
if(is.matrix(x)){BringBack=as.matrix(BringBack)}
if(is.vector(x)){BringBack = BringBack[,1]}
assign(New, BringBack, envir=parent.frame())
} # end Update

file.remove(Filename)
} # end interactive
else{
warning("This function is only useful in interactive sessions running under Windows.")
}  # end not interactive
invisible(NULL)
} # end function

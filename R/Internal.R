
GetAxisTicks=function(x){
A=x[1]
B=x[2]
Ticks=x[3]
paste(paste0(seq(A,B-Ticks,(B-A)/Ticks),",", collapse=" "), "and", B, collapse=" ")
}


InQuotes=function(x){
Out=paste0('"', x, '"')
}

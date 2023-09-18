# making sure the old style graphics are presented as the right text strings
# colours (col), line types (lty), plotting character (pch) symbols
# need to add bty, 

.ColourText = function(x){
for(Colour in 1:length(x)){
xx=x[Colour]
XXX = as.integer(xx)
if(!is.na(XXX)){
x[Colour]=.BaseColourText[XXX+1]
} else if (is.character(xx)) {
x[Colour]=tolower(xx)
} else {
stop("incorrect input value")
}
}
return(x)
}

.BaseColourText = c("white", "black", "red", "green", "blue", "cyan", "magenta", "yellow", "grey")
names(.BaseColourText) = .BaseColourText


.LineTypeText = function(x){
for(LineType in 1:length(x)){
xx=x[LineType]
XXX = as.integer(xx)
if(!is.na(XXX)){
x[LineType]=.BaseLineTypeText[XXX+1]
} else if (is.character(xx)) {
x[LineType]=tolower(xx)
} else {
stop("incorrect input value")
}
}
return(x)
}

.BaseLineTypeText = c("blank", "solid", "dashed", "dotted", "dotdash", "longdash", "twodash")
names(.BaseLineTypeText) = .BaseLineTypeText


.SymbolText = function(x){
for(Symbol in 1:length(x)){
xx=x[Symbol]
XXX = as.integer(xx)
if(!is.na(XXX)){
x[Symbol]=.BaseSymbolText[XXX+1]
} else if (is.character(xx)) {
x[Symbol]=tolower(xx)
} else {
stop("incorrect input value")
}
}
return(x)
}

.BaseSymbolText = c("square", "circle", "triangle point up", "plus", "cross", "diamond", "triangle point down", "square cross", "star", "diamond plus", "circle plus", "square plus", "triangle plus", "star plus", "circle cross", "square cross", "filled square", "filled circle", "filled triangle point up", "filled diamond", "filled triangle point down", "filled circle plus", "filled square plus", "filled diamond plus", "filled triangle plus", "filled star", "filled square cross")
names(.BaseSymbolsText) = .BaseSymbolsText


.BaseBoxTypeText = c("n"="none", "o"="all", "l"="bottom-left", "7"="top-right", "c"="all but right", "u"="all but top", "]"="all but left")

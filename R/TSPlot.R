

TimeSeriesPlot = function(x, ...){
    Out = list(x=as.ts(x))
    MC <- match.call(expand.dots = TRUE)
    Out$graph = eval(plot(Out$x, ...), parent.frame())
Out$par = par()
    class(Out) = "tsplot"
    if (length(MC$main) > 0) Out$main = as.character(MC$main) else {Out$main = ""}
    if (length(MC$sub) > 0) Out$sub = as.character(MC$sub)
    if (length(MC$xlab) > 0) Out$xlab = as.character(MC$xlab) else {Out$xlab = "Time"}
    if (length(MC$ylab) > 0) Out$ylab = as.character(MC$ylab)
    Out=Augment(Out)
    return(invisible(Out))
}


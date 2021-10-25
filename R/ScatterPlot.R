

ScatterPlot = function(.data, x, y=NULL, base=FALSE, ...){
    MC <- match.call(expand.dots = TRUE)
if(base){
    Out = list()
    Out$data = .CleanData4TwoWayPlot(x, y)
    Out$ExtraArgs  = .GrabExtraArgs(MC)
    Out$ExtraArgs$xlab =     MC$xlab= ifelse(is.null(MC$xlab), as.character(MC$x), MC$xlab)
    Out$ExtraArgs$ylab =     MC$ylab= ifelse(is.null(MC$ylab), as.character(MC$y), MC$ylab)
    Out = .checkTextLabels(MC, Out)
    MC[[1L]] <- quote(graphics::plot)
    MC$x <- Out$data$x
    MC$y <- Out$data$y
    Out$graph <- eval(MC, envir=parent.frame())
    Out$par = par()
    class(Out) = "scatterplot"
    Out=Augment(Out)
    return(invisible(Out))
}
else{ ## do it in ggplot2
Out=ggplot(.data, aes(x=x, y=y)) + geom_point()
    return(Out)
}
}


FittedLinePlot = function(.data, x, y, line.col=2, base=FALSE, ...){
    MC <- match.call(expand.dots = TRUE)
if(base){

    Out = list()
    Out$data = .CleanData4TwoWayPlot(x, y)
    Out$fittedline = list(coef = coef(lm(y~x, data=Out$data)),
                    col = line.col)
    Out$ExtraArgs  = .GrabExtraArgs(MC)
    Out$ExtraArgs$xlab  = MC$xlab = ifelse(is.null(MC$xlab), as.character(MC$x), MC$xlab)
    Out$ExtraArgs$ylab  =     MC$ylab= ifelse(is.null(MC$ylab), as.character(MC$y), MC$ylab)
    Out = .checkTextLabels(MC, Out)
    MC$x <- Out$data$x
    MC$y <- Out$data$y
    MC$line.col=NULL
    Out$graph <- do.call(graphics::plot, as.list(MC[-1]))
    Out$par = par()
    class(Out) = c("fittedlineplot", "scatterplot")
    Out=Augment(Out)
    do.call(abline, Out$fittedline)
    return(invisible(Out))
}
else{ ## do it in ggplot2
Out=ggplot(.data, aes(x=x, y=y)) + geom_point() + geom_smooth(method="lm", col=line.col)
    return(Out)
}
}



plot.fittedlineplot = function(x, ...){
    x$x= x$data$x
    x$y = x$data$y
    Pars=x$ExtraArgs
  if(any(class(x) == "fittedlineplot")) fitline = x$fittedline
    x = .RemoveExtraGraphPars(x)
    suppressWarnings(do.call(plot, c(x, Pars)))
  if(any(class(x) == "fittedlineplot")) do.call(abline, fitline)
    return(invisible(NULL))
}

plot.scatterplot = print.fittedlineplot = print.scatterplot = plot.scatterplot

.RemoveExtraGraphPars = function(x){
ToRemoveBrailleRBits = c("xTicks", "yTicks", "par", "GroupSummaries", "Continuous", "coef", "data", "fittedline", "main", "sub", "xlab", "ylab", "ExtraArgs", "line.col")
ToRemoveBasePar = c("cin", "cra", "csi", "cxy", "din", "page")
ToRemove = c(ToRemoveBasePar, ToRemoveBrailleRBits)
x2 = x[setdiff(names(x), ToRemove)]
class(x2) = class(x)
return(invisible(x2))
}

.GrabExtraArgs = function(x){
    ToRemove = c("", "x", "y", "main", "xlab", "ylab", "sub", "line.col")
    ExtraArgs = (as.list(x))[setdiff(names(x), ToRemove)]
    return(invisible(ExtraArgs))
}


.CleanData4TwoWayPlot = function(x, y){
    Ord = order(x,y)
return(invisible(na.omit(data.frame(x=x[Ord], y=y[Ord]))))
}


.checkTextLabels = function(MC, Out){
    if (length(MC$main) > 0) Out$ExtraArgs$main = as.character(MC$main) else {Out$ExtraArgs$main = ""}
    if (length(MC$sub) > 0) Out$ExtraArgs$sub = as.character(MC$sub)
    if (length(MC$xlab) > 0) Out$ExtraArgs$xlab = as.character(MC$xlab)
    if (length(MC$ylab) > 0) Out$ExtraArgs$ylab = as.character(MC$ylab)
    return(invisible(Out))
}



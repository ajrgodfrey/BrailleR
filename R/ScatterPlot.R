

ScatterPlot = function(x, y=NULL, ...){
    MC <- match.call(expand.dots = TRUE)
    Out = list()
    Out$data = .CleanData4TwoWayPlot(x, y)
    MC$xlab= ifelse(is.null(MC$xlab), as.character(MC$x), MC$xlab)
    MC$ylab= ifelse(is.null(MC$ylab), as.character(MC$y), MC$ylab)
    MC[[1L]] <- quote(graphics::plot)
    MC$x <- Out$data$x
    MC$y <- Out$data$y
    Out$graph <- eval(MC, envir=parent.frame())
    Out$ExtraArgs  = .GrabExtraArgs(MC)
    Out$par = par()
    class(Out) = "scatterplot"
    Out = .checkTextLabels(MC, Out)
    Out=Augment(Out)
    return(invisible(Out))
}


FittedLinePlot = function(x, y, line.col=2, ...){
    MC <- match.call(expand.dots = TRUE)
    Out = list()
    Out$data = .CleanData4TwoWayPlot(x, y)
    MC$xlab= ifelse(is.null(MC$xlab), as.character(MC$x), MC$xlab)
    MC$ylab= ifelse(is.null(MC$ylab), as.character(MC$y), MC$ylab)
    MC[[1L]] <- quote(graphics::plot)
    MC$x <- Out$data$x
    MC$y <- Out$data$y
    Out$graph <- eval(MC, envir=parent.frame())
    Out$ExtraArgs  = .GrabExtraArgs(MC)
    Out$par = par()
    class(Out) = c("fittedlineplot", "scatterplot")
    Out = .checkTextLabels(MC, Out)
    Out=Augment(Out)
    Out$fittedline$coef = coef(lm(y~x, data=Out$data))
    Out$fittedline$col = line.col
    abline(Out$fittedline$coef, col=line.col)
    return(invisible(Out))
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

plot.scatterplot = function(x, ...){
x$x= x$data$x
x$y = x$data$y
 Pars = x$ExtraArgs
x = .RemoveExtraGraphPars(x)
suppressWarnings(do.call(plot, c(x, Pars)))
return(invisible(NULL))
}


plot.fittedlineplot = function(x, ...){
x$x= x$data$x
x$y = x$data$y
Pars=x$ExtraPars
fitline = x$fittedline
x = .RemoveExtraGraphPars(x)
suppressWarnings(do.call(plot, c(x, Pars)))
    abline(fitline$coef, col=fitline$col)
return(invisible(NULL))
}

print.fittedlineplot = plot.fittedlineplot
print.scatterplot = plot.scatterplot

.RemoveExtraGraphPars = function(x){
ToRemoveBrailleRBits = c("xTicks", "yTicks", "par", "GroupSummaries", "Continuous", "coef", "data", "fittedline", "main", "sub", "xlab", "ylab", "ExtraArgs")
ToRemoveBasePar = c("cin", "cra", "csi", "cxy", "din", "page")
ToRemove = c(ToRemoveBasePar, ToRemoveBrailleRBits)
x2 = x[setdiff(names(x), ToRemove)]
class(x2) = class(x)
return(invisible(x2))
}

.GrabExtraArgs = function(x){
ToRemove = c("", "x", "y", "main", "xlab", "ylab", "sub")
ExtraArgs = as.list(x[setdiff(names(x), ToRemove)])
return(invisible(ExtraArgs))
}

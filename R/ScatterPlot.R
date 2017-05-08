

ScatterPlot = function(x, y, ...){
    MC <- match.call(expand.dots = TRUE)
    Out = list()
    Out$data = .CleanData4TwoWayPlot(x, y)
    MC$xlab= ifelse(is.null(MC$xlab), as.character(MC$x), MC$xlab)
    MC$ylab= ifelse(is.null(MC$ylab), as.character(MC$y), MC$ylab)
    MC[[1L]] <- quote(graphics::plot)
    MC$x <- Out$data$x
    MC$y <- Out$data$y
    Out$graph <- eval(MC, envir=parent.frame())
    Out$par = par()
    class(Out) = "scatterplot"
    Out = .checkTextLabels(MC, Out)
    Out=Augment(Out)
    return(invisible(Out))
}


FittedLinePlot = function(x, y, ...){
    MC <- match.call(expand.dots = TRUE)
    Out = list()
    Out$data = .CleanData4TwoWayPlot(x, y)
    MC$xlab= ifelse(is.null(MC$xlab), as.character(MC$x), MC$xlab)
    MC$ylab= ifelse(is.null(MC$ylab), as.character(MC$y), MC$ylab)
    MC[[1L]] <- quote(graphics::plot)
    MC$x <- Out$data$x
    MC$y <- Out$data$y
    Out$graph <- eval(MC, envir=parent.frame())
    Out$par = par()
    class(Out) = c("fittedlineplot", "scatterplot")
    Out = .checkTextLabels(MC, Out)
    Out=Augment(Out)
    Out$fittedline$coef = coef(lm(y~x, data=Out$data))
    abline(Out$fittedline$coef)
    return(invisible(Out))
}


.CleanData4TwoWayPlot = function(x, y){
    Ord = order(x,y)
return(invisible(na.omit(data.frame(x=x[Ord], y=y[Ord]))))
}


.checkTextLabels = function(MC, Out){
    if (length(MC$main) > 0) Out$main = as.character(MC$main) else {Out$main = ""}
    if (length(MC$sub) > 0) Out$sub = as.character(MC$sub)
    if (length(MC$xlab) > 0) Out$xlab = as.character(MC$xlab)
    if (length(MC$ylab) > 0) Out$ylab = as.character(MC$ylab)
    return(invisible(Out))
}

plot.scatterplot = function(x, ...){
suppressWarnings(do.call(plot, x))
return(invisible(NULL))
}


plot.fittedlineplot = function(x, ...){
suppressWarnings(do.call(plot, x$data))
    abline(x$fittedline$coef)
return(invisible(NULL))
}

print.fittedlineplot = plot.fittedlineplot
print.scatterplot = plot.scatterplot

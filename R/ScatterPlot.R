

ScatterPlot = function(x, y, ...){
    MC <- match.call(expand.dots = TRUE)
    Out = list()
    Ord = order(x,y)
    Out$data = na.omit(data.frame(x=x[Ord], y=y[Ord]))
    MC$xlab= ifelse(is.null(MC$xlab), as.character(MC$x), MC$xlab)
    MC$ylab= ifelse(is.null(MC$ylab), as.character(MC$y), MC$ylab)
    MC[[1L]] <- quote(graphics::plot)
    MC$x <- Out$data$x
    MC$y <- Out$data$y

    Out$graph <- eval(MC, envir=parent.frame())

    Out$par = par()
    class(Out) = "scatterplot"
    if (length(MC$main) > 0) Out$main = as.character(MC$main) else {Out$main = ""}
    if (length(MC$sub) > 0) Out$sub = as.character(MC$sub)
    if (length(MC$xlab) > 0) Out$xlab = as.character(MC$xlab)
    if (length(MC$ylab) > 0) Out$ylab = as.character(MC$ylab)
    Out=Augment(Out)
    return(invisible(Out))
}


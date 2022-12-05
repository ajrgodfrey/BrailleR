

TimeSeriesPlot = function(.data, x, time=NULL, base=FALSE, ...){
  Out = list()
  MC = match.call(expand.dots = TRUE)
  MC$ylab= ifelse(is.null(MC$ylab), as.character(MC$x), MC$ylab)
  if (length(MC$sub) > 0) Out$sub = as.character(MC$sub)
  if (length(MC$xlab) > 0) Out$xlab = as.character(MC$xlab) else {Out$xlab = "Time"}
  if (length(MC$ylab) > 0) Out$ylab = as.character(MC$ylab)
  if(base){
    Out = list(x=as.ts(x))

    MC[[1L]] <- quote(graphics::plot)
    MC$x <- Out$x
    
    Out$graph <- eval(MC, envir=parent.frame())
    
    Out$par = par()
    class(Out) = "tsplot"
    if (length(MC$main) > 0) Out$main = as.character(MC$main) else {Out$main = ""}
    Out=Augment(Out)
  }
  else{ ## do it in ggplot2
    if (is.ts(.data)) {
      .data = data.frame(Y=as.matrix(.data), date=time(.data))
      time = .data$date
      x = .data$Y
    }
    if (length(MC$main) > 0) Out$main = as.character(MC$main)
    if (is.null(time)) time = 1:length(x)
    Out = ggplot(.data, aes(y=x, x=time)) +
      geom_line() +
      ylab(Out$ylab) + xlab(Out$xlab) +
      labs(title=Out$main, subtitle=Out$sub)
}
  return(invisible(Out))
}

plot.tsplot = function(x, ...){
  x = .RemoveExtraGraphPars(x) # see ScatterPlot.R for this function
  suppressWarnings(do.call(plot, x))
  return(invisible(NULL))
}

print.tsplot = plot.tsplot

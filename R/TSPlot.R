

TimeSeriesPlot = function(.data, x, time=NULL, base=FALSE, ...){
  Out = list()
  MC = match.call(expand.dots = TRUE)
  if(base){
    Out = list(x=as.ts(x))
    MC$ylab= ifelse(is.null(MC$ylab), as.character(MC$x), MC$ylab)
    MC[[1L]] <- quote(graphics::plot)
    MC$x <- Out$x
    
    Out$graph <- eval(MC, envir=parent.frame())
    
    Out$par = par()
    class(Out) = "tsplot"
    if (length(MC$main) > 0) Out$main = as.character(MC$main) else {Out$main = ""}
    if (length(MC$sub) > 0) Out$sub = as.character(MC$sub)
    if (length(MC$xlab) > 0) Out$xlab = as.character(MC$xlab) else {Out$xlab = "Time"}
    if (length(MC$ylab) > 0) Out$ylab = as.character(MC$ylab)
    Out=Augment(Out)
  }
  else{ ## do it in ggplot2
    MC$ylab = ifelse(is.null(MC$ylab), tail(strsplit(as.character(MC$x), "$"),n=1), MC$ylab)
    if (length(MC$sub) > 0) Out$sub = as.character(MC$sub)
    if (length(MC$xlab) > 0) Out$xlab = as.character(MC$xlab) else {Out$xlab = "Time"}
    if (length(MC$ylab) > 0) Out$ylab = as.character(MC$ylab)
    if (length(MC$main) > 0) Out$main = as.character(MC$main)
    
    #Special care has to be taken if it is a dataframe
    if (is.ts(.data)) {
      #Sort out data frame
      .data = data.frame(Y=as.matrix(.data), date=time(.data))
      time = .data$date
      x = .data$Y
      #Get correct ylab
      Out$ylab = ifelse(is.null(MC$ylab[[1]]), deparse(MC$.data), MC$ylab)
    } else if (!is.data.frame(.data)) {
      x = .data
      .data = data.frame(x=x)
    }
    
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

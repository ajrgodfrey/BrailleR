# NB xlab() and ylab() are functions in the ggplot2 package; 
# the original BrailleR  implementation was inconsistent with ggplot2 so the function names were chantged to camel case.

Main = XLab = YLab = function(graph, label=NULL){
    arg = as.character(match.call()[[1]])
    Obj = tolower(as.character(match.call()[["graph"]]))
    if(any(class(graph)=="Augmented")){
        if(is.null(label)){
            Out = .GetGraphText(graph, arg)
            return(Out)
        } else {
            Out = .UpdateGraph(graph, label, arg)
            assign(Obj, Out, parent.frame())
            return(invisible(Out))
        }
    }
}


update.scatterplot = update.tsplot = update.fittedlineplot = UpdateGraph = function(object, ...){
      MC <- match.call(expand.dots = TRUE)
      ParSet = (as.list(MC))[-c(1,2)]
      Obj = as.character(match.call()[["object"]])
      Out = object
# now sift ExtraArgs from ParSet and update them
# now sift pars from ParSet and update them
      assign(Obj, Out, parent.frame())
      return(invisible(Out))
}


.UpdateGraph = function(graph, label, arg){
    graph$"ExtraArgs"[[arg]] = label
    if(any(class(graph)=="ggplot")){
        arg = .ggplotLabelNames[arg]
        graph$labels[[arg]] = label
    }
    print(graph) # is actually plot() except for histograms
    return(invisible(graph))
}

.GetGraphText = function(graph, arg){
    return(invisible(graph$"ExtraArgs"[[arg]]))
}

.ggplotLabelNames = c(main="title", sub="subtitle", xlab="x", ylab="y")

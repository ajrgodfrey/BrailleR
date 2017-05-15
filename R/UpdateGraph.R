# NB xlab() and ylab() are also functions in ggplot2; 
# this BrailleR  implementation is inconsistent with ggplot2.

main = xlab = ylab = function(graph, label=NULL){
    arg = as.character(match.call()[[1]])
    Obj = as.character(match.call()[["graph"]])
    if(any(class(graph)=="Augmented")){
        if(is.null(label)){
            Out = .GetGraphText(graph, arg)
            return(Out)
        } else {
            Out = .UpdateGraph(graph, label, arg)
            assign(Obj, Out, parent.frame())
            return(invisible(TRUE))
        }
    }
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

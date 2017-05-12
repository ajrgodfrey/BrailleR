

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
print(graph) # is actually plot() except for histograms
return(invisible(graph))
}

.GetGraphText = function(graph, arg){
return(invisible(graph$"ExtraArgs"[[arg]]))
}

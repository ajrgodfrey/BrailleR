
# help page is shared with VI()

#The heavy lifting of this function is done with these internal functions which 
#Interact with the mustache templates.

#This method is somewhat inefficient as it will just get slower and slower as more is added.
.readTxtCSV = function(location) {
  temp = read.csv(system.file(paste0("whisker/", location), package="BrailleR"), header = T, as.is = T)
  sublists = length(temp) > 2
  templates = list()
  for (plot in 1:length(temp[,1])) {
    templates[[temp[plot,1]]] = if (sublists) {
      sublist = as.list(gsub("\n", "",temp[plot,2:length(temp)]))
      names(sublist) = colnames(temp)[2:length(temp)]
      sublist
    } else {
      gsub("\n", "",temp[plot,2])
    }
  }
  return(templates)
}

.renderDescription = function(name) {
  template = .readTxtCSV("Describe/baseR.txt")
  generics = .readTxtCSV("Describe/generics.txt")
  rendered = list(
    title = whisker::whisker.render(template = template[[name]]["title"], data=generics),
    general = whisker::whisker.render(template = template[[name]]["general"], data=generics),
    RHints = whisker::whisker.render(template = template[[name]]["RHints"], data=generics)
  )
  class(rendered) = "description"
  return(rendered)
}

Describe = 
    function(x, VI=FALSE, ...){
      UseMethod("Describe")
    }

print.description = 
    function(x, ...){
        template = paste(readLines(system.file("whisker/Describe/Describedefault.txt", package="BrailleR")), collapse="\n")
        output = whisker::whisker.render(template, x)
        cat(output)
        return(invisible(NULL))
    }

Describe.default = 
    function(x, VI=FALSE, ...){
        if(VI) VI(x)
        .renderDescription("default")
    }

Describe.histogram = 
    function(x, VI=FALSE, ...){
        if(VI) VI(x)
        .renderDescription("histogram")
    }

Describe.scatterplot = 
    function(x, VI=FALSE, ...){
        if(VI) VI(x)
        .renderDescription("scatterplot")
    }

Describe.tsplot = 
    function(x, VI=FALSE, ...){
        if(VI) VI(x)
        .renderDescription("tsplot")
    }
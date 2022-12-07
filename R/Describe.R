

#The heavy lifting of this function is done with these internal functions which 
#Interact with the mustache templates.

#This method is somewhat inefficient as it will just get slower and slower as more templates are added.
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

.renderDescription = function(name, baseR = T) {
  if (baseR) {
    template = .readTxtCSV("Describe/baseR.txt")
  } else {
    template = .readTxtCSV("Describe/ggplot.txt")
  }
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
        cat(output, "\n\n")
        return(invisible(NULL))
    }

print.multiDescription = 
    function(x, ...){
      for (element in x) {
        print(element)
      }
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

Describe.ggplot = 
    function(x, VI=FALSE, whichLayer = NULL, ...){
      if(VI) VI(x)
      layers = x$layers
      
      #Interactive version to find out which layers to print
      if (length(layers) == 1) {
        whichLayer = 1
      } else if(is.null(whichLayer) && interactive()) {
          cat("Please select which layers you will want to see descriptions for:\n")
          for(i in seq_along(layers)) {
            cat(i,": ", class(layers[[i]]$geom)[1],"\n")
          }
          cat("Each layer should be seperated by a comma\n")
          userInput = readline(prompt="Which layers do you want to see? ")
          whichLayer = gsub(" ", "", userInput) |>
            strsplit(split=",") |>
            lapply(FUN=strtoi) |> 
            unlist()
      #Default for non interactive is to print all layers
      } else {
        whichLayer = 1:length(layers)
      }
      
      #Filter out any number that arent 
      whichLayer = whichLayer[whichLayer %in% 1:length(layers)]
      #Get the descriptions of the layers
      descriptions = list()
      for (layer in whichLayer) {
        currentClass = class(layers[[layer]]$geom)[1]
        descriptions[[currentClass]] = .renderDescription(currentClass, F)
      }
      
      #Make sure that all descriptions actually have a valid descriptions
      descriptions = descriptions[
        lapply(descriptions,
               \(desc) {
                  nchar(desc$title) + nchar(desc$general) + nchar(desc$RHints) != 0
            }
        ) |> unlist()
      ]
      
      
      #Output multiple descriptions
      if (length(descriptions) > 1) {
        class(descriptions) = "multiDescription"
        return(descriptions)
      #No valid indexes
      } else if (length(whichLayer) == 0){
        warning("You havent entered any valid layer indexes")
        return(NULL)
      #No available description
      } else if (length(descriptions) == 0){
        warning("None of you selected layers have a description yet.")
        return(NULL)
      #Only one description
      } else {
        return(descriptions[[1]])
      }
    }

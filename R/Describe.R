# help page is shared with VI()

Describe = 
    function(x, VI=FALSE){
      UseMethod("Describe")
    }

Describe.default = Describe.histogram = 
    function(x, VI=FALSE){
        if(VI) VI(x)
        title = "No description of this type of object has been written at this time."
        general = ""
        RHints = ""
        Out = list(title = title, general = general, RHints = RHints)
        class(Out) = "description"
        return(Out)
    }

print.description = 
    function(x, ...){
        cat(paste0(x$title, "\n", "General description: ", x$general, "\n", "R hints: ", x$RHints, "\n"))
        return(invisible(NULL))
    }

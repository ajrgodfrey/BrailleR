
# help page is shared with VI()

Describe = 
    function(x, VI=FALSE, ...){
      UseMethod("Describe")
    }

.CommonAxisStyleText ="As with most graphs created by the base graphics package, the axes do not join at the bottom left corner and are separated from the area where the data are being plotted."

.CommonTickMarkText = "Tick marks are automatically chosen for the data, and the axes may not extend past the ends of variables being plotted."

.CommonAspectRatioText = "R normally plots a graph in a square window. This can be altered; the way this is done depends heavily on the method being used to create the graph. See the help on win.graph() or  x11() for the graphs made in an interactive  session or part of an R script; png(), pdf() or postscript() for specific file formats being created; or, use fig.height and fig.width arguments in your R markdown documents."

print.description = 
    function(x, ...){
        cat(paste0(x$title, "\n", "General description: ", x$general, "\n", "R hints: ", x$RHints, "\n"))
        return(invisible(NULL))
    }

Describe.default = 
    function(x, VI=FALSE, ...){
        if(VI) VI(x)
        title = "No description of this type of object has been written at this time."
        general = ""
        RHints = ""
        Out = list(title = title, general = general, RHints = RHints)
        class(Out) = "description"
        return(Out)
    }
Describe.histogram = 
    function(x, VI=FALSE, ...){
        if(VI) VI(x)
        title = "A histogram created using the base graphics package."
        general = paste("A histogram uses rectangles to represent the counts or relative frequencies of observations falling in each subrange of the numeric variable being investigated. The rectangles are standing side by side with their bottom end at the zero mark of the vertical axis. The widths of the rectangles are usually constant, but this can be altered by the user. A sighted person uses the heights and therefore the areas of the rectangles to help determine the overall shape of the distribution, the presence of gaps in the data, and any outliers that might be present.", .CommonAxisStyleText, .CommonTickMarkText, "The vertical axis for frequency always starts at zero.") 
        RHints = ""
        Out = list(title = title, general = general, RHints = RHints)
        class(Out) = "description"
        return(Out)
    }

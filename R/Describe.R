
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
        RHints = "If you intend to make a tactile version of a histogram, you may find it useful to alter the aspect ratio so that the histogram is wider than it is tall."
        Out = list(title = title, general = general, RHints = RHints)
        class(Out) = "description"
        return(Out)
    }

Describe.scatterplot = 
    function(x, VI=FALSE, ...){
        if(VI) VI(x)
        title = "A scatter plot created using BrailleR which builds on base graphics use of the plot() command"
        general = "A scatter plot shows the relationship between two variables by plotting a symbol for each observation at the coordinates for the two variables."
        RHints = "Default settings would use a small black open circle for each observation in the dataset that has a value for both variables being plotted. The `col` and `pch` arguments alter the colour and shape of the symbols; these might vary according to some other information known about each observation. It is common to add a straight line with the `abline()` command to show how well a linear relationship summarises the data."
        Out = list(title = title, general = general, RHints = RHints)
        class(Out) = "description"
        return(Out)
    }

Describe.tsplot = 
    function(x, VI=FALSE, ...){
        if(VI) VI(x)
        title = "A time series plot created using BrailleR which builds on base graphics use of the plot() command"
        general = "A time series plot shows the behaviour of a variable over time, by plotting a symbol at the height of the variable of interest for each time point along the x-axis."
        RHints = "Default settings would use a series of line segments to join adjacent points. Each  missing observation contributes to the absence of two line segments. The line segments are printed as solid black lines, unless the colour is changed using the `col` argument. The type of line is changed with the `lty` argument. It can prove useful to alter the width of lines using the `lwd` argument."
        Out = list(title = title, general = general, RHints = RHints)
        class(Out) = "description"
        return(Out)
    }


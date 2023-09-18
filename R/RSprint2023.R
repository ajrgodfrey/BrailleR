
# to be named more helpfully
wtf <- function()
{
    recordedPlot <- recordPlot()
Out = summary(recordedPlot)#now pass each list element through a whisker template by using .VI_*() below
for(Element in 1:length(names(Out))){
args <- lapply(Out[[Element]], function(x) if (is.null(x)) NA else x)
do.call(paste0(".VI_", names(Out)[Element]), args)
}
return(invisible(Out))
}

summary.recordedplot = function(object, ...){
     .getCall <- function(x) {
         structure(list(x[[2]][-1]), 
                  names = x[[2]][1][[1]]$name)
     }
Out=    lapply(object[[1]], .getCall) |> do.call(what = c)
# do not name the vectors in here as there is a chance of duplication if the same C function is called twice.
# result must be cycled through item by item
return(Out)
}



# Note from Deepayan
# Initial list of functions that get recorded on the display list, along with a potential list of arguments. 
# The argument list may not be complete or correct in all cases, and will need to be verified.
# There are other functions that may be called (that definitely happens for grid-based plots), so this should only be considered as a starting point.

.plotc_arglist <- 
    list(C_plot_new = c(""),
         C_plot_window = c(""),
         C_axis = c("side, at, labels, tick, line, pos, outer, font, lty, lwd, lwd.ticks, col, col.ticks, hadj, padj, gap.axis"),
         C_plotXY = c("xy, type, pch, lty, col, bg, cex, lwd"),
        C_segments = c("x0, y0, x1, y1, col, lty, lwd"),
         C_rect = c("xl, yb, xr, yt, col, border, lty"),
         C_path = c("x, y, col, border, lty"),
         C_raster = c("image, xl, yb, xr, yt, angle, interpolate"),
         C_arrows = c("x0, y0, x1, y1, length, angle, code, col, lty, lwd"),
         C_polygon = c("x, y, col, border, lty"),
         C_text = c("xy, labels, adj, pos, offset, vfont, cex, col, font"),
         C_mtext = c("text, side, line, outer, at, adj, padj, cex, col, font"),
         C_title = c("main, sub, xlab, ylab, line, outer"),
         C_abline = c("a, b, h, v, something, col, lty, lwd"),
         C_box = c("which, lty"), 
         C_locator = c("x, y, nobs, ans, saveans, stype"),
         C_identify = c("ans, x, y, l, ind, pos, order, Offset, draw, saveans"),
         C_strHeight = c("?"),
         C_dend = c("?"),
         C_dendwindow = c("?"),
         C_erase = c("?"),
         C_symbols = c("x, y, type, data, inches, bg, fg"),
         C_xspline = c("sx, sy, ss, col, border, res"),
         C_clip = c("x1, x2, y1, y2"),
         C_convertX = c("from, to"),
         C_convertY = c("from, to")
) |>
## split on comma to get a vector of argument names
lapply(\(x) trimws(strsplit(x, ",")[[1]]))




.addListNames = function(ListToName, NamesList){
for(Item in names(ListToName)){
#cat(Item,"\n") # helps tracking during testing
try(names(ListToName[[Item]]) <- NamesList[[Item]])
}
return(invisible(ListToName))
}


.VI_C_plot_window = .VI_palette2 = function(x, ...){cat("Something unnecessary\n")}

.VI_C_plot_window = 
.VI_C_axis =  .VI_C_plotXY =  .VI_C_segments =  .VI_C_rect =  .VI_C_path =  .VI_C_raster =  .VI_C_arrows =  .VI_C_polygon =  .VI_C_text =  .VI_C_mtext =  .VI_C_box =  
.VI_C_locator =  .VI_C_identify =  .VI_C_strHeight =  .VI_C_dend =  .VI_C_dendwindow =  .VI_C_erase =  .VI_C_symbols =  .VI_C_xspline =  .VI_C_clip =  .VI_C_convertX =  .VI_C_convertY = function(x, ...){
cat(as.character(match.call()), "\n")
}

.VI_C_abline = function(a, b, h, v, something, col, lty, lwd, ...){
Working = data.frame(a=a, b=b, h=h, v=v, something=something,  col=col, lty=lty, lwd=lwd)
Working$a = replace(Working$a, is.na(Working$a) & !is.na(Working$b), 0)
Working$b = replace(Working$b, !is.na(Working$a) & is.na(Working$b), 0)
SlopedLines = Working [!is.na(Working$b), ]
if(nrow(SlopedLines) > 0){
cat(paste("There  is a", .LineTypeText(SlopedLines$lty), .ColourText(SlopedLines$col),  
"line with slope", SlopedLines$b, "and intercept", SlopedLines$a, collapse="\n"), "\n") 
}
HorizontalLines = Working [!is.na(Working$h), ]
if(nrow(HorizontalLines) > 0){
cat(paste("There  is a", .LineTypeText(HorizontalLines$lty), .ColourText(HorizontalLines$col),  
"horizontal line  at y = ", HorizontalLines$h, collapse="\n"), "\n") 
}
VerticalLines = Working [!is.na(Working$v), ]
if(nrow(VerticalLines) > 0){
cat(paste("There  is a", .LineTypeText(VerticalLines$lty), .ColourText(VerticalLines$col),  
"vertical line  at x = ", VerticalLines$v, collapse="\n"), "\n") 
}
return(invisible(NULL))
}

.VI_C_plot_new = function(...) {
cat("A new graph has been created.\n")
8:00 pm 18/09/2023return(invisible(NULL))
} 

.VI_C_title =   function(main, sub, xlab, ylab, line, outer, ...){
if(!is.na(main)) cat(paste0('The main title is "', main, '"\n'))
if(!is.na(sub)) cat(paste0('The subtitle is "', sub, '"\n'))
if(!is.na(xlab)) cat(paste0('The x-axis label is "', xlab, '"\n'))
if(!is.na(ylab)) cat(paste0('The y-axis label is "', ylab, '"\n'))
return(invisible(NULL))
}

.VI_C_plotXY = function(xy, type, pch, lty, col, bg, cex, lwd, ...){
#XY is a list with x, y, xlab, and ylab
return(invisible(NULL))
}

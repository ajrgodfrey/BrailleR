# this was made possible with much help and insight from Deepayan


# to be named more helpfully
summarizeDL <- function()
{
    recordedPlot <- recordPlot()
summary(recordedPlot)
#now pass through a whisker template
}

summary.recordedplot = function(object, ...){
     .getCall <- function(x) {
         structure(list(x[[2]][-1]), 
                  names = x[[2]][1][[1]]$name)
     }
semiOut=    lapply(object[[1]], .getCall) |> do.call(what = c)
Out = lapply(semiOut, unlist)
# name the vectors now
Out = .addCFunctionArgNames(Out)
return(Out)
}


.addCFunctionArgNames = function(summaryDisplayList){
for(Element in summaryDisplayList){
# add the names from DS' argument list found in .plotc_arglist

}
}


# Initial list of functions that get recorded on the display list, along with a potential list of arguments. 
# The argument list may not be complete or correct in all cases, and will need to be verified.
# There are other functions that may be called (that definitely happens for grid-based plots), so this should only be considered as a starting point.

.plotc_arglist <- 
    list(C_plot_new = c(""),
         C_plot_window = c(""),
         C_axis = c("side, at, labels, tick, line, pos, outer, font, lty, lwd, lwd.ticks, col, col.ticks, hadj, padj, gap.axis, ..."),
         C_plotXY = c("x, y, type, pch, lty, col, bg, cex, lwd, ..."),
         C_segments = c("x0, y0, x1, y1, col, lty, lwd, ..."),
         C_rect = c("xl, yb, xr, yt, col, border, lty, ..."),
         C_path = c("x, y, col, border, lty, ..."),
         C_raster = c("image, xl, yb, xr, yt, angle, interpolate, ..."),
         C_arrows = c("x0, y0, x1, y1, length, angle, code, col, lty, lwd, ..."),
         C_polygon = c("x, y, col, border, lty, ..."),
         C_text = c("xy, labels, adj, pos, offset, vfont, cex, col, font, ..."),
         C_mtext = c("text, side, line, outer, at, adj, padj, cex, col, font, ..."),
         C_title = c("main, sub, xlab, ylab, line, outer, ..."),
         C_abline = c("a, b, h, v, col, lty, lwd, ..."),
         C_box = c("which, lty, ..."),
         C_locator = c("x, y, nobs, ans, saveans, stype"),
         C_identify = c("ans, x, y, l, ind, pos, order, Offset, draw, saveans"),
         C_strHeight = c("?"),
         C_dend = c("?"),
         C_dendwindow = c("?"),
         C_erase = c("?"),
         C_symbols = c("x, y, type, data, inches, bg, fg, ..."),
         C_xspline = c("sx, sy, ss, col, border, res"),
         C_clip = c("x1, x2, y1, y2"),
         C_convertX = c("from, to"),
         C_convertY = c("from, to")
) |>
## split on comma to get a vector of argument names
lapply(\(x) trimws(strsplit(x, ",")[[1]]))



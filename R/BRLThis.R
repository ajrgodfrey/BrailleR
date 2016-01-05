# @rdname BRLThis
# @title Convert a graph to a pdf ready for embossing
# @aliases BRLThis
# @description  The first argument to this function must be a call to create a graph, such as a histogram. Instead of opening a new graphics device, the graph will be created in a pdf file, with all text being presented using  a braille font. The function is somewhat experimental as the best braille font is not yet confirmed, and a number of examples need to be tested on a variety of embossers before full confidence in the function is given. 
# @details The user's chosen braille font must be installed. This might include the default font shipped as part of the package.
# @return Nothing within the R session, but a pdf file will be created in the user's working directory.
# @author A. Jonathan R. Godfrey.
# @examples 
#; data(airquality)
# with(airquality,
# BRLThis(hist(Ozone), "Ozone-hist.pdf"))

# @export BRLThis
# @param x the call to create a graph
# @param file A character string giving the filename where the image is to be saved.
BRLThis = function(x, file){
extrafont::loadfonts(quiet=TRUE)

# need to add these arguments to the call 
# family="Braille Normal", cex=1, cex.axis=1, cex.main=1, cex.lab=1, cex.sub=1)
eval({
    pdf(file, pointsize=29) 
    x
    dev.off()
    extrafont::embed_fonts(file)#, outfile=file)
    }, parent.frame())
return(invisible(NULL))
}

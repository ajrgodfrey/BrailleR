
VI.ggplot = function(x){
txt=paste0('The chart titled ', BrailleR::InQuotes(x$labels$title), ';\n',
    'with x-axis ', BrailleR::InQuotes(x$labels$x), ' labeled from ',
    ggplot_build(x)$panel$ranges[[1]]$x.labels[1], ' to ',
    tail(ggplot_build(x)$panel$ranges[[1]]$x.labels, n=1),
    ' and y-axis ', BrailleR::InQuotes(x$labels$y), ' labeled from ',
    ggplot_build(x)$panel$ranges[[1]]$y.labels[1], ' to ',
    tail(ggplot_build(x)$panel$ranges[[1]]$y.labels,n=1), ';\n')

if ('colour' %in% attributes(x$labels)$names){
    txt=paste0(txt, '\nColour is used to represent ', BrailleR::InQuotes(x$labels$colour))
 
    if ('factor' %in% class(x$data[[x$labels$colour]])) {
        txt=paste0(txt,', a factor with levels: ', paste(levels(x$data[[x$labels$colour]]), collapse=', '), '.\n')
    }
    else{ txt=paste0(txt, , ';\n')}
}
cat(txt)
return(invisible(NULL))
}


VI.ggplot =
    function(x, Describe=FALSE, ...) {
      TitleText = ifelse(is.null(x$labels$title), "This untitled chart;\n",
              paste0('This chart titled ', .getTextGGTitle(x), ';\n'))
      SubtitleText = ifelse(is.null(x$labels$subtitle), "has no subtitle;\n",
              paste0('has the subtitle: ', .getTextGGSubtitle(x), ';\n'))
      CaptionText = ifelse(is.null(x$labels$caption), "and no caption.\n",
              paste0('and the caption: ', .getTextGGCaption(x), '.\n'))

      txt =
          paste0(TitleText, SubtitleText, CaptionText,
              'with x-axis ', BrailleR::InQuotes(x$labels$x), ' labeled from ',
              ggplot_build(x)$panel$ranges[[1]]$x.labels[1], ' to ',
              tail(ggplot_build(x)$panel$ranges[[1]]$x.labels, n = 1),
              ' and y-axis ', BrailleR::InQuotes(x$labels$y), ' labeled from ',
              ggplot_build(x)$panel$ranges[[1]]$y.labels[1], ' to ',
              tail(ggplot_build(x)$panel$ranges[[1]]$y.labels, n = 1), ';\n')

      if ('colour' %in% names(x$labels)) {
        txt = paste0(txt, '\nColour is used to represent ',
                     BrailleR::InQuotes(x$labels$colour))

        if ('factor' %in% class(x$data[[x$labels$colour]])) {
          txt =
              paste0(txt, ', a factor with levels: ',
                     paste(levels(x$data[[x$labels$colour]]), collapse = ', '),
                     '.\n')
        } else {
          txt = paste0(txt, ';\n')
        }
      }
      cat(txt)
      return(invisible(NULL))
    }

.getTextGGTitle = function(x){
if(is.null(x$labels$title)){
text = "no label"
} else {
text =  BrailleR::InQuotes(x$labels$title)
}
return(invisible(text))
}

.getTextGGSubtitle = function(x){
if(is.null(x$labels$subtitle)){
text = "no label"
} else {
text =  BrailleR::InQuotes(x$labels$subtitle)
}
return(invisible(text))
}

.getTextGGCaption = function(x){
if(is.null(x$labels$caption)){
text = "no label"
} else {
text =  BrailleR::InQuotes(x$labels$caption)
}
return(invisible(text))
}


.getTextGGXLab = function(x){
text = BrailleR::InQuotes(x$labels$x)
}



.getTextGGYLab = function(x){
text = BrailleR::InQuotes(x$labels$y)
}



VI.ggplot =
    function(x, Describe=FALSE, ...) {
      TitleText = ifelse(is.null(.getTextGGTitle(x)), "This untitled chart;\n",
              paste0('This chart titled ', .getTextGGTitle(x), ';\n'))
      SubtitleText = ifelse(is.null(.getTextGGSubtitle(x)), "has no subtitle;\n",
              paste0('has the subtitle: ', .getTextGGSubtitle(x), ';\n'))
      CaptionText = ifelse(is.null(.getTextGGCaption(x)), "and no caption.\n",
              paste0('and the caption: ', .getTextGGCaption(x), '.\n'))

      xTicks = .getTextGGXTicks(x)
      if (length(xTicks)==1) 
        xTickText = xTicks[1] 
      else
        xTickText = paste0(paste(head(xTicks,-1),collapse=", ")," and ",tail(xTicks,1))
      yTicks = .getTextGGYTicks(x)
      if (length(yTicks)==1)
        yTickText = yTicks[1]
      else
        yTickText = paste0(paste(head(yTicks,-1),collapse=", ")," and ",tail(yTicks,1))
      
      txt =
          paste0(TitleText, SubtitleText, CaptionText,
              'with x-axis ', .getTextGGXLab(x), ' with labels at ',xTickText,
              ' and y-axis ', .getTextGGYLab(x), ' with labels at ',yTickText,';\n')

      if (!is.null(.getTextGGColourLab(x))) {
        txt = paste0(txt, '\nColour is used to represent ',.getTextGGColourLab(x))

        if (!is.null(.getTextGGColourFactors(x))) {
          txt =
              paste0(txt, ', a factor with levels: ',
                     paste(.getTextGGColourFactors(x), collapse = ', '),
                     '.\n')
        } else {
          txt = paste0(txt, ';\n')
        }
      }
      layerCount=.getGGLayerCount(x);
      if (layerCount==1)
        txt = paste0(txt,"There is one layer\n")
      else
        txt = paste0(txt,"There are ",layerCount," layers\n")
      for (layer in 1:layerCount) {
        layerClass=.getTextGGLayerType(x,layer)
        txt = paste0(txt,"Layer ",layer," is of type ",layerClass,"\n")
      }

      cat(txt)
      return(invisible(NULL))
    }

.getTextGGTitle = function(x){
if(is.null(x$labels$title)){
text = NULL
} else {
text =  BrailleR::InQuotes(x$labels$title)
}
return(invisible(text))
}

.getTextGGSubtitle = function(x){
if(is.null(x$labels$subtitle)){
text = NULL
} else {
text =  BrailleR::InQuotes(x$labels$subtitle)
}
return(invisible(text))
}

.getTextGGCaption = function(x){
if(is.null(x$labels$caption)){
text = NULL
} else {
text =  BrailleR::InQuotes(x$labels$caption)
}
return(invisible(text))
}

.getTextGGXLab = function(x){
  labels = BrailleR::InQuotes(x$labels$x)
}

.getTextGGYLab = function(x){
  labels = BrailleR::InQuotes(x$labels$y)
}

.getTextGGColourLab = function(x){
  if ('colour' %in% names(x$labels))
    text = BrailleR::InQuotes(x$labels$colour)
  else
    text = NULL
}

.getTextGGColourFactors = function(x){
if ('factor' %in% class(x$data[[x$labels$colour]])) 
  labels = levels(x$data[[x$labels$colour]])
else
  labels = NULL
}
           
.getTextGGXTicks = function(x){
  text=ggplot_build(x)$layout$panel_ranges[[1]]$x.major_source
}

.getTextGGYTicks = function(x){
  text=ggplot_build(x)$layout$panel_ranges[[1]]$y.major_source
}

.getGGLayerCount = function(x){
  count=length(ggplot_build(x)$plot$layers)
}

.getTextGGLayerType = function(x,n){
  plotClass = class(ggplot_build(x)$plot$layers[[n]]$geom)[1]
}
VI.ggplot = function(x, Describe=FALSE, ...) {
  VItext=list()
  class(VItext)=c("VItext",class(VItext))
  
  TitleText = ifelse(is.null(.getTextGGTitle(x)), "This untitled chart;\n",
              paste0('This chart titled ', .getTextGGTitle(x), ';\n'))
  VItext["title"]=TitleText
  SubtitleText = ifelse(is.null(.getTextGGSubtitle(x)), "has no subtitle;\n",
              paste0('has the subtitle: ', .getTextGGSubtitle(x), ';\n'))
  VItext["subtitle"]=SubtitleText
  CaptionText = ifelse(is.null(.getTextGGCaption(x)), "and no caption.\n",
              paste0('and the caption: ', .getTextGGCaption(x), '.\n'))
  VItext["caption"]=CaptionText
  
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
      
  VItext["xaxis"]=paste0('with x-axis ', .getTextGGXLab(x), ' with labels ',xTickText)
  VItext["yaxis"]=paste0(' and y-axis ', .getTextGGYLab(x), ' with labels ',yTickText,';\n')
  
  if (!is.null(.getTextGGColourLab(x))) {
    VItext["color"] = paste0('Colour is used to represent ',.getTextGGColourLab(x))

    if (!is.null(.getTextGGColourFactors(x))) {
      VItext["color"]=paste0(VItext["color"],', a factor with levels: ',paste(.getTextGGColourFactors(x), collapse = ', '),
                             '.\n')
    } else {
      VItext["color"] = paste0(VItext["color"],".\n")
    }
  }
  if (!is.null(.getTextGGFillLab(x))) {
    VItext["fill"] = paste0('Fill colour is used to represent ',.getTextGGFillLab(x))
    if (!is.null(.getTextGGFillFactors(x))) {
      VItext["fill"]=paste0(VItext["fill"],', a factor with levels: ',paste(.getTextGGFillFactors(x), collapse = ', '),
                             '.\n')
    } else {
      VItext["fill"] = paste0(VItext["fill"],".\n")
    }
    
  }
  layerCount=.getGGLayerCount(x);
  if (layerCount==1) {
    VItext["layer.count"] = "There is one layer\n"
  } else {
    VItext["layer.count"]=paste0("There are ",layerCount," layers\n")
  }
  for (layer in 1:layerCount) {
    layerClass = .getTextGGLayerType(x,layer)
    if (layerClass == "GeomHline") {
      txt = paste0(" is a horizontal line at position ",.getGGLayerYIntercept(x,layer))
    } else if (layerClass == "GeomPoint") {
      txt = paste0(" is a scatterplot containing ",.getGGLayerDataCount(x,layer)," points")    
    } else if (layerClass == "GeomBar") {
      txt = paste0(" is a bar chart containing ",.getGGLayerDataCount(x,layer)," bars")
    } else
      txt = paste0(" is of type ",layerClass)
    VItext[paste0("layer",layer)]=paste0("Layer ",layer,txt,"\n")
    if (!is.null(.getGGLayerMapping(x,layer)))
       VItext[paste0("layer",layer,"mapping")]=.getGGLayerMapping(x,layer)
    if (!is.null(.getGGLayerAes(x,layer)))
      VItext[paste0("layer",layer,"aes")]=.getGGLayerAes(x,layer)
  }

  return(VItext)
}

print.VItext = function(x, ...) {
  cat(paste(x))
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
.getTextGGFillLab = function(x){
  if ('fill' %in% names(x$labels))
    text = BrailleR::InQuotes(x$labels$fill)
  else
    text = NULL
}

.getTextGGColourFactors = function(x){
  if ('factor' %in% class(x$data[[x$labels$colour]])) 
    labels = levels(x$data[[x$labels$colour]])
  else
    labels = NULL
}
.getTextGGFillFactors = function(x){
  if ('factor' %in% class(x$data[[x$labels$fill]])) 
    labels = levels(x$data[[x$labels$fill]])
  else
    labels = NULL
}
           
.getTextGGXTicks = function(x){
  text=ggplot_build(x)$layout$panel_ranges[[1]]$x.labels
}

.getTextGGYTicks = function(x){
  text=ggplot_build(x)$layout$panel_ranges[[1]]$y.labels
}

.getGGLayerCount = function(x){
  count=length(ggplot_build(x)$plot$layers)
}

.getTextGGLayerType = function(x,n){
  plotClass = class(ggplot_build(x)$plot$layers[[n]]$geom)[1]
}

.getGGLayerYIntercept = function(x,n){
  yIntercept = ggplot_build(x)$plot$layers[[n]]$mapping$yintercept
}

.getGGLayerDataCount = function(x,n){
  points = nrow(ggplot_build(x)$data[[n]])
}
.getGGLayerMapping = function(x,n){
  mapping = ggplot_build(x)$plot$layers[[n]]$mapping
  if (length(mapping)>0)
    return(paste0("Layer ",n," maps ",paste0(names(mapping)," to ",mapping,collapse=", "),"\n")) 
  else
    return(NULL)
}
.getGGLayerAes = function(x,n){
  aes = ggplot_build(x)$plot$layers[[n]]$aes_params
  if (length(aes)>0)
    return(paste0("Layer ",n," sets aesthetic ",paste0(names(aes)," to ",aes,collapse=", "),"\n")) 
  else
    return(NULL)
}
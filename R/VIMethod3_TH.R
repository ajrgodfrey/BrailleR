textify.VIgg = function(x, template=
                          system.file("whisker/VIdefault.txt",
                                      package="BrailleR")) {
  #f=file(template)
  #temp = scan(f,what=character(),sep="=")
  temp = read.csv(template,header=FALSE,as.is=TRUE)
  #close(f)
  #if (length(temp)%%2 != 0)
  #  warning("Invalid template")
  #dim(temp) = c(ceiling(length(temp)/2),2)
  templates=as.list(gsub("\n","",temp[,2]))
  names(templates) = temp[,1]
  mainTemplate = templates["VIgg"]
  partials = templates[which(names(templates)!="VIgg")]
  render = whisker::whisker.render(mainTemplate,x,partials=partials)
  return(as.vector(strsplit(render,"<br>",fixed=TRUE)[[1]]))
}

print.VIgg = function(x, ...) {
  cat(textify.VIgg(x),sep="\n")
}

.VIlist = function(...) {
  l = list(...)
  l[(lapply(l,length)>0)] 
}

VI.ggplot = function(x, Describe=FALSE, ...) {
  title = .getTextGGTitle(x)
  subtitle = .getTextGGSubtitle(x)
  caption = .getTextGGCaption(x)
  annotations = .VIlist(title=title,subtitle=subtitle,caption=caption)
  xlabel = .getTextGGXLab(x)
  xticklabels = .getTextGGXTicks(x)
  xaxis = .VIlist(xlabel=xlabel,xticklabels=xticklabels)
  ylabel = .getTextGGYLab(x)
  yticklabels = .getTextGGYTicks(x)
  yaxis = .VIlist(ylabel=ylabel,yticklabels=yticklabels)
  colourlabel = .getTextGGColourLab(x)
  factorlevels = .getTextGGColourFactors(x)
  colourfactor = .VIlist(factorlevels = factorlevels)
  colour = .VIlist(colourlabel=colourlabel,colourfactor=colourfactor)
  fillcolourlabel = .getTextGGFillLab(x)
  factorlevels = .getTextGGFillFactors(x)
  fillcolourfactor = .VIlist(factorlevels = factorlevels)
  fillcolour = .VIlist(fillcolourlabel=fillcolourlabel,
                       fillcolourfactor=fillcolourfactor)
  facetrows = as.list(.getGGFacetRows(x))
  facetrowsflag = if (length(facetrows)>0) TRUE   # TRUE or NULL
  facetcols = as.list(.getGGFacetCols(x))
  facetcolsflag = if (length(facetcols)>0) TRUE   # TRUE or NULL
  facet = .VIlist(facetrowsflag=facetrowsflag,facetrows=facetrows,
                  facetcolsflag=facetcolsflag,facetcols=facetcols)
  ## STILL NEED TO CAPTURE AND REPORT ON VALUES OF THE FACET VARS
  layers = list()
  layerCount=.getGGLayerCount(x);
  for (i in 1:layerCount) {
    layer = list(layernum=i)
    layerClass = .getTextGGLayerType(x,i)
    if (layerClass == "GeomHline") {
      layer[["hlineflag"]] = TRUE
      # This is only working correctly if there's just one hline
      # and it's specified like geom_hline(aes(yintercept=200)).
      # Doesn't currently work for geom_hline(yintercept=200)
      # or for multiple hlines
      layer[["ypos"]] = .getGGLayerYIntercept(x,i)
    } else if (layerClass == "GeomPoint") {
      layer[["pointflag"]] = TRUE
      layer[["npoints"]] = .getGGLayerDataCount(x,i)
    } else if (layerClass == "GeomBar") {
      layer[["barflag"]] = TRUE      
      layer[["nbars"]] = .getGGLayerDataCount(x,i)
    } else
       layer[["unknownflag"]] = TRUE
#      txt = paste0(" is of type ",layerClass)
    layers[[i]] = layer  
  }
  VIgg = .VIlist(annotations=annotations,xaxis=xaxis,yaxis=yaxis,
              colour=colour,fillcolour=fillcolour,facet=facet,
              nlayers=layerCount,layers=layers)
  class(VIgg) = "VIgg"
  return(VIgg)
}

# Just saving this here until I've fully replicated it above
.oldVI.ggplot = function(x, Describe=FALSE, ...) {

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
#    text =  BrailleR::InQuotes(x$labels$title)
     text =  x$labels$title
  }
  return(invisible(text))
}

.getTextGGSubtitle = function(x){
  if(is.null(x$labels$subtitle)){
    text = NULL
  } else {
#    text =  BrailleR::InQuotes(x$labels$subtitle)
    text =  x$labels$subtitle
  }
  return(invisible(text))
}

.getTextGGCaption = function(x){
  if(is.null(x$labels$caption)){
    text = NULL
  } else {
#    text =  BrailleR::InQuotes(x$labels$caption)
    text =  x$labels$caption
  }
  return(invisible(text))
}

.getTextGGXLab = function(x){
#  labels = BrailleR::InQuotes(x$labels$x)
  labels = x$labels$x
}

.getTextGGYLab = function(x){
#  labels = BrailleR::InQuotes(x$labels$y)
  labels = x$labels$y
}

.getTextGGColourLab = function(x){
  if ('colour' %in% names(x$labels))
#    text = BrailleR::InQuotes(x$labels$colour)
    text = x$labels$colour
  else
    text = NULL
}
.getTextGGFillLab = function(x){
  if ('fill' %in% names(x$labels))
#    text = BrailleR::InQuotes(x$labels$fill)
    text = x$labels$fill
  else
    text = NULL
}

.getTextGGColourFactors = function(x){
  if (!is.null(x$labels$colour) && 'factor' %in% class(x$data[[x$labels$colour]])) 
    labels = levels(x$data[[x$labels$colour]])
  else
    labels = NULL
}
.getTextGGFillFactors = function(x){
  if (!is.null(x$labels$fill) && 'factor' %in% class(x$data[[x$labels$fill]])) 
    labels = levels(x$data[[x$labels$fill]])
  else
    labels = NULL
}
           
.getTextGGXTicks = function(x){
  text=suppressMessages(ggplot_build(x))$layout$panel_ranges[[1]]$x.labels
}

.getTextGGYTicks = function(x){
  text=suppressMessages(ggplot_build(x))$layout$panel_ranges[[1]]$y.labels
}

.getGGLayerCount = function(x){
  count=length(suppressMessages(ggplot_build(x))$plot$layers)
}

.getTextGGLayerType = function(x,n){
  plotClass = class(suppressMessages(ggplot_build(x))$plot$layers[[n]]$geom)[1]
}

.getGGLayerYIntercept = function(x,n){
  yIntercept = suppressMessages(ggplot_build(x))$plot$layers[[n]]$mapping$yintercept
}

.getGGLayerDataCount = function(x,n){
  points = nrow(suppressMessages(ggplot_build(x))$data[[n]])
}
.getGGLayerMapping = function(x,n){
  mapping = suppressMessages(ggplot_build(x))$plot$layers[[n]]$mapping
  if (length(mapping)>0)
    return(paste0("Layer ",n," maps ",paste0(names(mapping)," to ",mapping,collapse=", "),"\n")) 
  else
    return(NULL)
}
.getGGLayerAes = function(x,n){
  aes = suppressMessages(ggplot_build(x))$plot$layers[[n]]$aes_params
  if (length(aes)>0)
    return(paste0("Layer ",n," sets aesthetic ",paste0(names(aes)," to ",aes,collapse=", "),"\n")) 
  else
    return(NULL)
}
.getGGFacetRows = function(x){
  if (length(x$facet$params$rows)>0)
    return(names(x$facet$params$rows))
  else
    return(NULL)
}
.getGGFacetCols = function(x){
  if (length(x$facet$params$cols)>0)
    return(names(x$facet$params$cols))
  else
    return(NULL)
}
.getGGPlotData = function(x,n) {
  return(suppressMessages(ggplot_build(x))$data[[n]])
}

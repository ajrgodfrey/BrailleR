## Textify performs whisker rendering
## First parameter is a list of objects.  
## Second parameter is the name of a template file.
## #ach object is rendered using the template of the same name 
## found within the template file.  Partial templates can also
## be present in the template file and will be used if needed.
.VItextify = function(x, template=
                          system.file("whisker/VIdefault.txt",
                                      package="BrailleR")) {
  temp = read.csv(template,header=FALSE,as.is=TRUE)
  templates=as.list(gsub("\n","",temp[,2]))
  names(templates) = temp[,1]
  result = list()
  for (i in 1:length(x)) {
    render = whisker::whisker.render(templates[names(x[i])],x[[i]],
                                     partials=templates)
    result[[i]] = as.vector(strsplit(render,"<br>",fixed=TRUE)[[1]])
  }
  names(result) = names(x)
  return(result)
}

print.VIgraph = function(x, ...) {
  cat(x$text,sep="\n")
}

.VIlist = function(...) {
  l = list(...)
  l[(lapply(l,length)>0)] 
}


# threshold specifies how many points, lines, etc will be explicitly listed.
# Greater numbers will be summarised (e.g. "is a set of 32 horizontal lines" vs
# "is a set of 3 horizontal lines at 5, 7.5, 10")
VI.ggplot = function(x, Describe=FALSE, threshold=10, ...) {
  VIstruct = .VIstruct.ggplot(x,threshold)
  text = .VItextify(list(VIgg=VIstruct))[[1]]
  VIgraph=list(VIgg=VIstruct, text=text)
  class(VIgraph) = "VIgraph"
  return(VIgraph)
}
# Add additional fields to the structure that are only needed because
# of the limitations of the mustache templating system
.VIstruct.preprocess = function(x) {
  
}

.VIstruct.ggplot = function(x,threshold) {
  xbuild = suppressMessages(ggplot_build(x))
  title = .getTextGGTitle(x,xbuild)
  subtitle = .getTextGGSubtitle(x,xbuild)
  caption = .getTextGGCaption(x,xbuild)
  annotations = .VIlist(title=title,subtitle=subtitle,caption=caption)
  xlabel = .getTextGGXLab(x,xbuild)
  xticklabels = .getTextGGXTicks(x,xbuild)
  xaxis = .VIlist(xlabel=xlabel,xticklabels=xticklabels)
  ylabel = .getTextGGYLab(x,xbuild)
  yticklabels = .getTextGGYTicks(x,xbuild)
  yaxis = .VIlist(ylabel=ylabel,yticklabels=yticklabels)
  legends = .getGGLegends(x,xbuild)
  facetrows = as.list(.getGGFacetRows(x,xbuild))
  facetrowsflag = if (length(facetrows)>0) TRUE   # TRUE or NULL
  facetcols = as.list(.getGGFacetCols(x,xbuild))
  facetcolsflag = if (length(facetcols)>0) TRUE   # TRUE or NULL
  faceted = (length(facetrows)>0 || length(facetcols)>0)
  # Need to compute npanels
  facet = .VIlist(facetrowsflag=facetrowsflag,facetrows=facetrows,
                  facetcolsflag=facetcolsflag,facetcols=facetcols)
  ## STILL NEED TO CAPTURE AND REPORT ON VALUES OF THE FACET VARS
  layerCount = .getGGLayerCount(x,xbuild);
  singlelayer = if (layerCount==1) TRUE
  layers = .getGGLayers(x,xbuild,layerCount,faceted,threshold)
  VIstruct = .VIlist(annotations=annotations,xaxis=xaxis,yaxis=yaxis,
              legends=legends,facet=facet,
              nlayers=layerCount,singlelayer=singlelayer,
              layers=layers,type="ggplot")
  class(VIstruct) = "VIstruct"
  return(VIstruct)
}

.getGGLayers = function(x,xbuild,layerCount,faceted,threshold) {
  layers = list()
  for (i in 1:layerCount) {
    layer = list(layernum=i)
    layerClass = .getTextGGLayerType(x,xbuild,i)
    if (layerClass == "GeomHline") {
      layer[["hlinetype"]] = TRUE
      # This is only working correctly if there's just one hline
      # and it's specified like geom_hline(aes(yintercept=200)).
      # Doesn't currently work for geom_hline(yintercept=200)
      # or for multiple hlines
      yint = .getGGLayerYIntercept(x,xbuild,i)
      layer[["data"]] = yint
      layer[["n"]] = length(yint)
      layer[["s"]] = if (length(yint)>1) TRUE
      layer[["largecount"]] = if (length(yint)>threshold) TRUE
    } else if (layerClass == "GeomPoint") {
      layer[["pointtype"]] = TRUE
      if (faceted) {
        facetpoints = integer()
        #for (f in 1:npanels)
        #  facetpoints[f] = .getGGFacetDataCount(x,i,f)
        layer[["facetpoints"]] = facetpoints
        layer[["largecount"]] = if (length(facetpoints)>threshold) TRUE
      } else {
        # layer[["data"]] = ??   Should be getting the data details here
        npoints = .getGGLayerDataCount(x,xbuild,i)
        layer[["n"]] = npoints
        layer[["largecount"]] = if (npoints>threshold) TRUE
      }
      # Returns wrong count for faceted charts
    } else if (layerClass == "GeomBar") {
      layer[["bartype"]] = TRUE      
      if (faceted) {
        facetbars = integer()
        #for (f in 1:npanels)
        #  facetbars[f] = .getGGFacetDataCount(x,i,f)
        layer[["facetbars"]] = facetbars
      } else {
        nbars = .getGGLayerDataCount(x,xbuild,i)
        layer[["n"]] = nbars
        layer[["largecount"]] = if (nbars>threshold) TRUE
        layer[["data"]] = .getGGPlotData(x,xbuild,i)
      }
      # Returns wrong count for faceted charts
    } else if (layerClass == "GeomLine") {
      layer[["linetype"]] = TRUE
      if (faceted) {
        facetsegments = integer()
        #for (f in 1:npanels)
        #  facetsegments[f] = .getGGFacetDataCount(x,i,f) - 1
        layer[["facetsegments"]] = facetsegments 
      } else {
        nsegments = .getGGLayerDataCount(x,xbuild,i) - 1
        layer[["n"]] = nsegments
        layer[["largecount"]] = if (nsegments>threshold) TRUE
        layer[["data"]] = .getGGPlotData(x,xbuild,i)
      }
    } else
      layer[["unknowntype"]] = TRUE
    layers[[i]] = layer  
  }
  return(layers)
}

.getGGLegends = function(x,xbuild) {
  legends = list()
  labels = .getGGLegend(x,xbuild)
  labels = labels[which(!names(labels) %in% c("x","y","title","subtitle","caption"))]
  names = names(labels)
  for (i in seq_along(labels)) {
    name = names[i]
    mapping = labels[[i]]
    levels = .getGGFactorLevels(x,xbuild,mapping)
    isfactor = if (!is.null(levels)) TRUE
    legend = .VIlist(aes=name,mapping=unname(mapping),
                     isfactor=isfactor,levels=levels)
    legends[[i]] = legend
  }
  return(legends)
}

.getGGLegend = function(x,xbuild) {
  return(x$labels)
}

# If var is a factor variable, return the levels, otherwise null
.getGGFactorLevels = function(x,xbuild,var) {
  if (var %in% colnames(x$data) && 'factor' %in% class(x$data[[var]])) 
    levels(x$data[[var]])
  else
    NULL
}

.getTextGGTitle = function(x,xbuild){
  if(is.null(x$labels$title)){
    text = NULL
  } else {
     text =  x$labels$title
  }
  return(invisible(text))
}

.getTextGGSubtitle = function(x,xbuild){
  if(is.null(x$labels$subtitle)){
    text = NULL
  } else {
    text =  x$labels$subtitle
  }
  return(invisible(text))
}

.getTextGGCaption = function(x,xbuild){
  if(is.null(x$labels$caption)){
    text = NULL
  } else {
    text =  x$labels$caption
  }
  return(invisible(text))
}

.getTextGGXLab = function(x,xbuild){
  labels = x$labels$x
}

.getTextGGYLab = function(x,xbuild){
  labels = x$labels$y
}

.getTextGGXTicks = function(x,xbuild){
  text=xbuild$layout$panel_ranges[[1]]$x.labels
}

.getTextGGYTicks = function(x,xbuild){
  text=xbuild$layout$panel_ranges[[1]]$y.labels
}

.getGGLayerCount = function(x,xbuild){
  count=length(xbuild$plot$layers)
}

.getTextGGLayerType = function(x,xbuild,layer){
  plotClass = class(xbuild$plot$layers[[layer]]$geom)[1]
}

# This potentially returns a vector of length > 1
# It will likely need to be teased apart into a list
.getGGLayerYIntercept = function(x,xbuild,layer){
  yIntercept = xbuild$data[[layer]]$yintercept
}

.getGGLayerDataCount = function(x,xbuild,layer){
  points = nrow(xbuild$data[[layer]])
}

.getGGFacetDataCount = function(x,xbuild,layer,facet){
  data=xbuild$data[[layer]]
  points = nrow(data[data$PANEL==facet,])
}
## THESE NOT CURRENTLY USED 
#.getGGLayerMapping = function(x,xbuild,layer){
#  mapping = xbuild$plot$layers[[layer]]$mapping
#  if (length(mapping)>0)
#    return(paste0("Layer ",layer," maps ",paste0(names(mapping)," to ",mapping,collapse=", "),"\n")) 
#  else
#    return(NULL)
#}
#.getGGLayerAes = function(x,xbuild,layer){
#  aes = xbuild$plot$layers[[layer]]$aes_params
#  if (length(aes)>0)
#    return(paste0("Layer ",n," sets aesthetic ",paste0(names(aes)," to ",aes,collapse=", "),"\n")) 
#  else
#    return(NULL)
#}
.getGGFacetRows = function(x,xbuild){
  if (length(x$facet$params$rows)>0)
    return(names(x$facet$params$rows))
  else
    return(NULL)
}
.getGGFacetCols = function(x,xbuild){
  if (length(x$facet$params$cols)>0)
    return(names(x$facet$params$cols))
  else
    return(NULL)
}
.getGGPlotData = function(x,xbuild,layer) {
  # This returns a data frame -- useable by MakeAccessible, but will need to change
  # if it's going to be used by VI via the whisker template
  return(xbuild$data[[layer]])
}

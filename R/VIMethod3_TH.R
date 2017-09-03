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

.VIstruct.ggplot = function(x,threshold=10) {
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
  facetpanels = ifelse(is.null(facetrows),1,length(facetrows)) * 
                ifelse(is.null(facetcols),1,length(facetcols))
  facet = .VIlist(facetrowsflag=facetrowsflag,facetrows=facetrows,
                  facetcolsflag=facetcolsflag,facetcols=facetcols)
  ## STILL NEED TO CAPTURE AND REPORT ON VALUES OF THE FACET VARS
  layerCount = .getGGLayerCount(x,xbuild);
  singlelayer = if (layerCount==1) TRUE
  layers = .getGGLayers(x,xbuild,layerCount,facetpanels,threshold)
  VIstruct = .VIlist(annotations=annotations,xaxis=xaxis,yaxis=yaxis,
              legends=legends,facet=facet,
              nlayers=layerCount,singlelayer=singlelayer,
              layers=layers,type="ggplot")
  class(VIstruct) = "VIstruct"
  return(VIstruct)
}

.getGGLayers = function(x,xbuild,layerCount,facetpanels,threshold) {
  layers = list()
  for (layeri in 1:layerCount) {
    layeraes = .getGGLayerAes(x,xbuild,layeri)
    layer = .VIlist(layernum=layeri,layeraes=layeraes)
    data =.getGGPlotData(x,xbuild,layeri)
    layer[["data"]] = data
    n = nrow(data)
    if (facetpanels>1) {
      facetdata = tabulate(data$PANEL,nbins=facetpanels)
      layer[["facetn"]] = sapply(facetdata,nrow)
    }
    faceted = (!is.null(facetpanels) && facetpanels>1)
    layer[["n"]] = n
    layer[["s"]] = if (n>1) TRUE  # For templating
    layer[["largecount"]] = if (n>threshold) TRUE
    layerClass = .getTextGGLayerType(x,xbuild,layeri)
    if (layerClass == "GeomHline") {
      layer[["hlinetype"]] = TRUE
      layer[["yintercept"]] = data$yintercept
    } else if (layerClass == "GeomPoint") {
      layer[["pointtype"]] = TRUE
      # need to capture points as x-y pairs from the data
    } else if (layerClass == "GeomBar") {
      layer[["bartype"]] = TRUE      
      # need to capture heights of bars
    } else if (layerClass == "GeomLine") {
      layer[["linetype"]] = TRUE
      # need to capture info on segments - starting & ending x-y?
    } else if (layerClass == "GeomBoxplot") {
      layer[["boxtype"]] = TRUE
      # need to capture info related to boxes
    } else if (layerClass == "GeomSmooth") {
      layer[["smoothtype"]] = TRUE
      layer[["method"]] = .getGGSmoothMethod(x,xbuild,layeri)
      layer[["ci"]] = if (.getGGSmoothSEflag(x,xbuild,layeri)) TRUE
    } else
      layer[["unknowntype"]] = TRUE
    layers[[layeri]] = layer  
  }
  return(layers)
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

.getGGFacetDataCount = function(x,xbuild,layer,facet){
  data=xbuild$data[[layer]]
  points = nrow(data[data$PANEL==facet,])
}
## NOT CURRENTLY USED 
#.getGGLayerMapping = function(x,xbuild,layer){
#  mapping = xbuild$plot$layers[[layer]]$mapping
#  if (length(mapping)>0)
#    return(paste0("Layer ",layer," maps ",paste0(names(mapping)," to ",mapping,collapse=", "),"\n")) 
#  else
#    return(NULL)
#}
.getGGLayerAes = function(x,xbuild,layer){
  layeraes = list()
  params = xbuild$plot$layers[[layer]]$aes_params
  for (i in seq_along(params))
    layeraes[[i]] = list(aes=names(params)[i],mapping=params[[i]])
  return(layeraes)
}

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

.getGGLegends = function(x,xbuild) {
  legends = list()
  labels = .getGGLegend(x,xbuild)
  labels = labels[which(names(labels) %in% 
                          c("colour","fill","size","shape","alpha","radius",
                            "linetype"))]
  names = names(labels)
  guides = .getGGGuides(x,xbuild)
  for (i in seq_along(labels)) {
    name = names[i]
    mapping = labels[[i]]
    levels = .getGGFactorLevels(x,xbuild,mapping)
    isfactor = if (!is.null(levels)) TRUE
    hidden = if (!is.null(guides[[name]]) && guides[[name]]=="none") TRUE
    legend = .VIlist(aes=name,mapping=unname(mapping),
                     isfactor=isfactor,levels=levels,hidden=hidden)
    legends[[i]] = legend
  }
  return(legends)
}

.getGGLegend = function(x,xbuild) {
  return(x$labels)
}

.getGGGuides = function(x,xbuild) {
  return(xbuild$plot$guides)
}

# If var is a factor variable, return the levels, otherwise null
.getGGFactorLevels = function(x,xbuild,var) {
  if (var %in% colnames(x$data) && 'factor' %in% class(x$data[[var]])) 
    levels(x$data[[var]])
  else
    NULL
}

.getGGPlotData = function(x,xbuild,layer) {
  # This returns a data frame -- useable by MakeAccessible, but will need to change
  # if it's going to be used by VI via the whisker template
  return(xbuild$data[[layer]])
}

.getGGSmoothMethod = function(x,xbuild,layer) {
  return(xbuild$plot$layers[[layer]]$stat_params$method)
}

.getGGSmoothSEflag = function(x,xbuild,layer) {
  return(xbuild$plot$layers[[layer]]$stat_params$se)
}
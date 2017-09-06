## Textify performs whisker rendering
## First parameter is a list of objects.  
## Second parameter is the name of a template file.
## Each object is rendered using the template of the same name 
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

# This function adds flags to the VIstruct object that are only 
# required because of the limitations of mustache templating, as well
# as implementing the threshold for printing by setting "largecount" flags.
# Mustache can't check a field's value, only whether it's present or not.
# So flags are either set to true or not included at all
.VIpreprocess = function(x,threshold=10) {
  if (x$npanels==1) x$singlepanel = TRUE
  if (x$nlayers==1) x$singlelayer = TRUE
  if (length(x$panelrows)==0) x$singlerow = TRUE   
  if (length(x$panelcols)==0) x$singlecol = TRUE
  if (length(x$panelrows)>0 && length(x$panelcols)>0) x$panelgrid = TRUE
  for (paneli in 1:x$npanels)
    for (layeri in 1:x$nlayers) {
      typeflag = paste0(x$panels[[paneli]]$panellayers[[layeri]]$type,"type")
      x$panels[[paneli]]$panellayers[[layeri]][[typeflag]] = TRUE
      n = x$panels[[paneli]]$panellayers[[layeri]]$n
      if (n>1) x$panels[[paneli]]$panellayers[[layeri]]$s = TRUE
      if (n>threshold) x$panels[[paneli]]$panellayers[[layeri]]$largecount = TRUE
    }  
  return(x)
}
print.VIgraph = function(x, ...) {
  cat(x$text,sep="\n")
  invisible(x)
}

.VIlist = function(...) {
  l = list(...)
  l[(lapply(l,length)>0)] 
}

# threshold specifies how many points, lines, etc will be explicitly listed.
# Greater numbers will be summarised (e.g. "is a set of 32 horizontal lines" vs
# "is a set of 3 horizontal lines at 5, 7.5, 10")
VI.ggplot = function(x, Describe=FALSE, threshold=10, 
                     template=system.file("whisker/VIdefault.txt",package="BrailleR"), ...) {
  VIstruct = .VIstruct.ggplot(x)
  text = .VItextify(list(VIgg=.VIpreprocess(VIstruct,threshold)),template)[[1]]
  VIgraph=list(VIgg=VIstruct, text=text)
  class(VIgraph) = "VIgraph"
  print(VIgraph)
}

.VIstruct.ggplot = function(x) {
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
  panels = .getGGPanelList(x,xbuild)
  panelrows = as.list(.getGGFacetRows(x,xbuild))
  panelcols = as.list(.getGGFacetCols(x,xbuild))
  layerCount = .getGGLayerCount(x,xbuild);
  VIstruct = .VIlist(annotations=annotations,xaxis=xaxis,yaxis=yaxis,
              legends=legends,panels=panels,
              npanels=length(panels),nlayers=layerCount,
              panelrows=panelrows,panelcols=panelcols,
              type="ggplot")
  class(VIstruct) = "VIstruct"
  return(VIstruct)
}

.getGGLayers = function(x,xbuild,panel) {
  layerCount = .getGGLayerCount(x,xbuild)
  layers = list()
  for (layeri in 1:layerCount) {
    layeraes = .getGGLayerAes(x,xbuild,layeri)
    layer = .VIlist(layernum=layeri,layeraes=layeraes)
    data =.getGGPlotData(x,xbuild,layeri,panel)
    layer$data = data
    n = nrow(data)
    layer$n = n
    layerClass = .getTextGGLayerType(x,xbuild,layeri)
    if (layerClass == "GeomHline") {
      layer$type = "hline"
      layer$hlinetype = TRUE
      layer$yintercept = data$yintercept
    } else if (layerClass == "GeomPoint") {
      layer$type = "point"
      points = unname(as.list(data.frame(t(cbind(1:nrow(data),cbind(data$x,data$y))))))
      points = lapply(points,function(x) {names(x)=c("pointnum","x","y"); x})
      layer$points = points
    } else if (layerClass == "GeomBar") {
      layer$type = "bar"
      bars = unname(as.list(data.frame(t(cbind(1:nrow(data),data$x,data$y)))))
      bars = lapply(bars,function(x) {names(x)=c("barnum","x","y"); x})
      layer$bars = bars
    } else if (layerClass == "GeomLine") {
      layer$type = "line"
      points = unname(as.list(data.frame(t(cbind(1:nrow(data),data$x,data$y)))))
      points = lapply(points,function(x) {names(x)=c("pointnum","x","y"); x})
      layer$points = points
    } else if (layerClass == "GeomBoxplot") {
      layer$type = "box"
      nOutliers = sapply(data$outliers,length)
      # Might want to report high and low outliers separately?
      boxes = unname(as.list(data.frame(t(cbind(1:nrow(data),data$x,data$ymin,
                                        data$lower,data$middle,data$upper,
                                        data$ymax,unname(nOutliers))))))
      boxes = lapply(boxes,function(x) {names(x)=c("boxnum","x","ymin","lower",
                                                   "middle","upper","ymax",
                                                   "noutliers"); x})
      layer$boxes = boxes
      # Would like to include outlier detail as well.
      # Boxes is currently a list of vectors.  If we wanted to include outliers
      # within each boxes object for reporting, then boxes would need to become
      # a list of lists.
    } else if (layerClass == "GeomSmooth") {
      layer$type = "smooth"
      layer$method = .getGGSmoothMethod(x,xbuild,layeri)
      layer$ci = if (.getGGSmoothSEflag(x,xbuild,layeri)) TRUE
    } else {
      layer$type = "unknown"
    }
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

# The location of this item is changing in an upcoming ggplot version
.getTextGGXTicks = function(x,xbuild){
  if ("panel_ranges" %in% names(xbuild$layout))
    xbuild$layout$panel_ranges[[1]]$x.labels   # ggplot 2.2.1
  else
    xbuild$layout$panel_params[[1]]$x.labels   # dev version as at 5 Sept 2017
}

# The location of this item is changing in an upcoming ggplot version
.getTextGGYTicks = function(x,xbuild){
  if ("panel_ranges" %in% names(xbuild$layout))
    xbuild$layout$panel_ranges[[1]]$y.labels   # ggplot 2.2.1
  else
    xbuild$layout$panel_params[[1]]$y.labels   # dev version as at 5 Sept 2017
}

.getGGLayerCount = function(x,xbuild){
  count=length(xbuild$plot$layers)
}

.getTextGGLayerType = function(x,xbuild,layer){
  plotClass = class(xbuild$plot$layers[[layer]]$geom)[1]
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

# Getting facet row and col names from a different place than the 
# rest of the panel info. Does it matter?
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

.getGGPlotData = function(x,xbuild,layer,panel) {
  # This returns a data frame -- useable by MakeAccessible, but will need to change
  # if it's going to be used by VI via the whisker template
  fulldata = xbuild$data[[layer]]
  return(fulldata[fulldata$PANEL==panel,])
}

.getGGSmoothMethod = function(x,xbuild,layer) {
  return(xbuild$plot$layers[[layer]]$stat_params$method)
}

.getGGSmoothSEflag = function(x,xbuild,layer) {
  return(xbuild$plot$layers[[layer]]$stat_params$se)
}

.getGGPanelList = function(x,xbuild) {
  f = .getGGFacetLayout(x,xbuild)
  panels = list()
  names = colnames(f)
  panelvars = names[which(!names %in% c("PANEL","ROW","COL","SCALE_X","SCALE_Y"))]
  for (i in seq_along(f$PANEL)) {
    panel = list()
    panel[["panelnum"]] = as.character(f$PANEL[i])
    panel[["row"]] = f$ROW[i]
    panel[["col"]] = f$COL[i]
    vars = list()
      for (j in seq_along(panelvars)) {
        vars[[j]] = list(varname=as.character(panelvars[j]),
                         value=as.character(f[[i,panelvars[j]]]))
      }
    panel[["vars"]] = vars
    panel[["panellayers"]] = .getGGLayers(x,xbuild,i)
    panels[[i]] = panel
  }
  return(panels)  
}
# This returns a data frame with fields PANEL, ROW, COL, one column
# for each faceted variable, SCALE_X, and SCALE_Y
# e.g. for facets=cut~color the data frame contains:
#    PANEL, ROW, COL, cut, color, SCALE_X, SCALE_Y
# The name of this item is panel_layout in ggplot 2.2.1 but looks like
# it's going to be just layout in the next ggplot version
.getGGFacetLayout = function(x,xbuild) {
  if ("panel_layout" %in% names(xbuild$layout))
    return(xbuild$layout$panel_layout)
  else
    return(xbuild$layout$layout)
}
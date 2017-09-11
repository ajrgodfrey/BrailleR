### This file is for internal functions used by VI.ggplot
### These functions access the objects created by ggplot and ggplot_build,
### and may be sensitive to changes in those structure in later ggplot versions.

## Annotations
.getGGTitle = function(x,xbuild){
  if(is.null(x$labels$title)){
    text = NULL
  } else {
    text =  x$labels$title
  }
  return(invisible(text))
}

.getGGSubtitle = function(x,xbuild){
  if(is.null(x$labels$subtitle)){
    text = NULL
  } else {
    text =  x$labels$subtitle
  }
  return(invisible(text))
}

.getGGCaption = function(x,xbuild){
  if(is.null(x$labels$caption)){
    text = NULL
  } else {
    text =  x$labels$caption
  }
  return(invisible(text))
}

## Axes
.getGGXLab = function(x,xbuild){
  return(x$labels$x)
}

.getGGYLab = function(x,xbuild){
  return(x$labels$y)
}

.getGGXTicks = function(x,xbuild,layer){
  # The location of this item is changing in an upcoming ggplot version
  if ("panel_ranges" %in% names(xbuild$layout))
    return(xbuild$layout$panel_ranges[[layer]]$x.labels)   # ggplot 2.2.1
  else
    return(xbuild$layout$panel_params[[layer]]$x.labels)   # dev version as at 5 Sept 2017
}

.getGGYTicks = function(x,xbuild,layer){
  # The location of this item is changing in an upcoming ggplot version
  if ("panel_ranges" %in% names(xbuild$layout))
    return(xbuild$layout$panel_ranges[[layer]]$y.labels)   # ggplot 2.2.1
  else
    return(xbuild$layout$panel_params[[layer]]$y.labels)   # dev version as at 5 Sept 2017
}

# Guides
.getGGGuideLabels = function(x,xbuild) {
  labels = x$labels
  # Note: checking against char string "NA" is correct - label is set that way.
  labels = labels[which(names(labels) %in% 
                          c("colour","fill","size","shape","alpha","radius",
                            "linetype") & labels!="NA")]
  return(labels)
}

.getGGGuides = function(x,xbuild) {
  return(xbuild$plot$guides)
}

# Coordinates
.getGGCoord = function(x,xbuild) {
  return(class(x$coordinates)[1])
}

## Scales
.getGGScaleFree = function(x,xbuild) {
  free = x$facet$params$free
  if (is.null(free))
    return(FALSE)
  else
    return (free$x | free$y)
}

.getGGScale = function(x,xbuild,var) {
  scalelist = xbuild$plot$scales$scales
  scale = which(sapply(scalelist, function(x) var %in% x$aesthetics))
  scalediscrete = if ("ScaleDiscrete" %in% class(scalelist[[scale]])) TRUE
  return(list(scalediscrete=scalediscrete,
              range=scalelist[[scale]]$range$range))
}

.getGGTransInverse = function(x,xbuild,var) {
  scalelist = x$scales$scales
  scale = which(sapply(scalelist, function(x) var %in% x$aesthetics))
  if (is.null(scale) || is.null(scale$trans))
      return(NULL)
  else
    return(scale$trans$inverse)
}

# Small helper function for .getGGPanelScale
.findScale = function(x,var,panel) {
  panelIndex = min(panel,length(x))
  var %in% x[[panelIndex]]$aesthetics
}

.getGGPanelScale = function(x,xbuild,var,panel) {
  # Need to find the scale that matches the var we're translating
  # Depending on scalefree and layout, we might have separate scales
  # for each panel or just one
  scales = xbuild$layout$panel_scales
  findscale = which(sapply(scales, .findScale, var, panel))
  if (length(findscale)==1) {
    panelIndex = min(panel,length(scales[findscale]))
    return(xbuild$layout$panel_scales[[findscale]][[panelIndex]])
  } else {
    return(NULL) # Something went wrong -- no matching scale, or more than one
  }
}

## Facets
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
  else if (length(x$facet$params$facets)>0) # If nothing on left side of tilde
    return(names(x$facet$params$facets))   # then it's stored like this (??)
  else
    return(NULL)
}

# This returns a data frame with fields PANEL, ROW, COL, plus one column
# for each faceted variable, plus SCALE_X and SCALE_Y
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

## Layers
.getGGLayerCount = function(x,xbuild){
  count=length(xbuild$plot$layers)
}

.getGGLayerType = function(x,xbuild,layer){
  plotClass = class(xbuild$plot$layers[[layer]]$geom)[1]
}

# Report on non-default aesthetics set on this layer 
.getGGLayerAes = function(x,xbuild,layer){
  layeraes = list()
  params = xbuild$plot$layers[[layer]]$aes_params
  params = params[which(!(names(params) %in% c("x","y")))]  # Exclude x, y
  for (i in seq_along(params))
    layeraes[[i]] = list(aes=names(params)[i],mapping=params[[i]])
  return(layeraes)
}


# Plot data
# Layer-specific mapping overrides the higher level one
# Mapping is an expression to be evaluated in the x$data environment
# Will return null if there is no mapping (e.g. for y with stat_bin)
.getGGMapping = function(x,xbuild,layer,var) {
  m = xbuild$plot$layers[[layer]]$mapping
  if (!is.null(m) & !is.null(m[[var]]))
    return(m[[var]])
  ## Variable mappings shouldn't be in aes_params, but can end up there
  m=xbuild$plot$layers[[layer]]$aes_params[[var]]
  if (!is.null(m))
    return(m)
  else
    return(xbuild$plot$mapping[[var]])
}

.getGGPlotData = function(x,xbuild,layer,panel) {
  # This returns a data frame -- useable by MakeAccessible, but will need to change
  # if it's going to be used by VI via the whisker template
  fulldata = xbuild$data[[layer]]
  return(fulldata[fulldata$PANEL==panel,])
}

# Get the original data values for variable var in the given layer
# NOT CURRENTLY IN USE
# Dangerous since the original data may have changed or no longer be present in the env
.getGGRawValues = function(x,xbuild,layer,var) {
  map = .getGGMapping(x,xbuild,layer,var)
  if (class(x$layers[[layer]]$data) == "waiver")
    return(eval(map,x$data))
  else
    return(eval(map,x$layers[[layer]]$data))
}



# Smooth layer details
.getGGSmoothMethod = function(x,xbuild,layer) {
  return(xbuild$plot$layers[[layer]]$stat_params$method)
}

.getGGSmoothSEflag = function(x,xbuild,layer) {
  return(xbuild$plot$layers[[layer]]$stat_params$se)
}



### This file is for internal functions used by VI.ggplot
### These functions access the objects created by ggplot and ggplot_build,
### and may be sensitive to changes in those structure in later ggplot versions.

## All of these functions take as parameters:
##   x = the object created by ggplot
##   xbuild = the object resulting from ggplot_build(x)
# Some also take a panel or layer index

## Annotations
.getGGTitle = function(x, xbuild) {
  if (is.null(x$labels$title)) {
    text = NULL
  } else {
    text =  x$labels$title
  }
  return(invisible(text))
}

.getGGSubtitle = function(x, xbuild) {
  if (is.null(x$labels$subtitle)) {
    text = NULL
  } else {
    text =  x$labels$subtitle
  }
  return(invisible(text))
}

.getGGCaption = function(x, xbuild) {
  if (is.null(x$labels$caption)) {
    text = NULL
  } else {
    text =  x$labels$caption
  }
  return(invisible(text))
}

## Axes
.getGGXLab = function(x, xbuild) {
  return(x$labels$x)
}

.getGGYLab = function(x, xbuild) {
  return(x$labels$y)
}

.getGGXTicks = function(x, xbuild, layer) {
  # The location of this item is changing in an upcoming ggplot version
  if ("panel_ranges" %in% names(xbuild$layout)) {
    return(xbuild$layout$panel_ranges[[layer]]$x.labels)   # ggplot 2.2.1
  }
  else {
    xlabs <- xbuild$layout$panel_params[[1]]$x$get_labels()
    return (xlabs[!is.na(xlabs)])
  }
}

.getGGYTicks = function(x, xbuild, layer) {
  # The location of this item is changing in an upcoming ggplot version
  if ("panel_ranges" %in% names(xbuild$layout)) {
    return(xbuild$layout$panel_ranges[[layer]]$y.labels)   # ggplot 2.2.1
  }
  else {
    ylabs <- xbuild$layout$panel_params[[1]]$y$get_labels()
    return (ylabs[!is.na(ylabs)])
  }
}

# Guides
.getGGGuideLabels = function(x, xbuild) {
  labels = x$labels
  # Note: checking against char string "NA" is correct - label is set that way.
  labels = labels[which(names(labels) %in% 
                          c("colour", "fill", "size", "shape", "alpha", "radius", "linetype") & labels != "NA")]
  return(labels)
}

.getGGGuides = function(x, xbuild) {
  return(xbuild$plot$guides)
}

# Coordinates
.getGGCoord = function(x, xbuild) {
  return(class(x$coordinates)[1])
}

#Bar Orientation
.findBarOrientation = function(x, xbuild, layer) {
  flipped = xbuild$plot$layers[[layer]]$geom_params$flipped_aes
  if (flipped == TRUE)
    return("horizontal")
  else
    return("vertical")
}

## Scales
.getGGScaleFree = function(x, xbuild) {
  free = x$facet$params$free
  if (is.null(free))
    return(FALSE)
  else
    return (free$x | free$y)
}

.getGGScale = function(x, xbuild, aes) {
  scalelist = xbuild$plot$scales$scales
  scale = which(sapply(scalelist, function(x) aes %in% x$aesthetics))
  if (any(scale))
    return(scalelist[[scale]])
  else
    return(NULL)
}

.getGGTransInverse = function(x, xbuild, var) {
  scalelist = x$scales$scales
  scale = which(sapply(scalelist, function(x) var %in% x$aesthetics))
  if (is.null(scale) || is.null(scale$trans))
      return(NULL)
  else
    return(scale$trans$inverse)
}

# Small helper function for .getGGPanelScale
.findScale = function(x, var, panel) {
  panelIndex = min(panel, length(x))
  var %in% x[[panelIndex]]$aesthetics
}

.getGGPanelScale = function(x, xbuild, var, panel) {
    ## Need to find the scale that matches the var we're translating
    ## Depending on scalefree and layout, we might have separate scales
    ## for each panel or just one
    if (packageVersion("ggplot2") < "3.0.0") {
        scales = xbuild$layout$panel_scales
    } else {
        scales = list(xbuild$layout$panel_scales_x,
                      xbuild$layout$panel_scales_y)
    }
    findscale = which(sapply(scales, .findScale, var, panel))
    if (length(findscale) == 1) {
        panelIndex = min(panel, length(scales[[findscale]]))
        return(scales[[findscale]][[panelIndex]])
    } else {
        ## Something went wrong -- no matching scale, or more than one
        return(NULL) 
    }
}

## Facets
# Getting facet row and col names from a different place than the 
# rest of the panel info. Does it matter?
.getGGFacetRows = function(x, xbuild) {
  if (length(x$facet$params$rows) > 0)
    return(names(x$facet$params$rows))
  else
    return(NULL)
}

.getGGFacetCols = function(x, xbuild) {
  if (length(x$facet$params$cols) > 0)
    return(names(x$facet$params$cols))
  else if (length(x$facet$params$facets) > 0) # If nothing on left side of tilde in facet formula
    return(names(x$facet$params$facets))      # then it's stored like this (??)
  else
    return(NULL)
}

# This returns a data frame with fields PANEL, ROW, COL, plus one column
# for each faceted variable, plus SCALE_X and SCALE_Y
# e.g. for facets=cut~color the data frame contains:
#    PANEL, ROW, COL, cut, color, SCALE_X, SCALE_Y
# The name of this item is panel_layout in ggplot 2.2.1 but looks like
# it's going to be just layout in the next ggplot version
.getGGFacetLayout = function(x, xbuild) {
  if ("panel_layout" %in% names(xbuild$layout))
    return(xbuild$layout$panel_layout)
  else
    return(xbuild$layout$layout)
}

## Layers
.getGGLayerCount = function(x, xbuild) {
  count=length(xbuild$plot$layers)
}

.getGGLayerType = function(x, xbuild, layer) {
  plotClass = class(xbuild$plot$layers[[layer]]$geom)[1]
}

# Report on non-default aesthetics set on this layer 
.getGGLayerAes = function(x, xbuild, layer) {
  layeraes = list()
  params = xbuild$plot$layers[[layer]]$aes_params
  params = params[which(!(names(params) %in% c("x", "y")))]  # Exclude x, y
  values = .convertAes(as.data.frame(params, stringsAsFactors=FALSE))
  for (i in seq_along(params))
    layeraes[[i]] = list(aes=names(params)[i], mapping=values[,i])
  return(layeraes)
}

# Find those aesthetics that are varying within this layer 
# (e.g not all points in a scatterplot have the same colour)
.findVaryingAesthetics = function(x, xbuild, layer) {
  aeslist = c("colour", "fill", "linetype", "alpha", "size", "weight", "shape")
  data = xbuild$data[[layer]]
  names = names(data)
  data = data[names[names %in% aeslist]]
  data = data[sapply(data, function(col) { length(unique(col)) > 1 })]
  return(names(data))
}

# Layer position
.getGGLayerPosition = function(x, xbuild, layer) {
  pos = switch (class(x$layers[[layer]]$position)[1],
    PositionDodge = "dodge",
    PositionFill = "fill",
    PositionIdentity = "identity",
    PositionJitter = "jitter",
    PositionJitterdodge = "jitterdodge",
    PositionNudge = "nudge",
    PositionStack = "stack",
    class(x$layers[[layer]]$position)[1]
    )
  return(pos)
}

# Plot data
# Layer-specific mapping overrides the higher level one
# Mapping is an expression to be evaluated in the x$data environment
# Will return null if there is no mapping (e.g. for y with stat_bin)
.getGGMapping = function(x, xbuild, layer, aes) {
  m = xbuild$plot$layers[[layer]]$mapping
  if (!is.null(m) & !is.null(m[[aes]]))
    return(m[[aes]])
  m=xbuild$plot$layers[[layer]]$aes_params[[aes]]
  if (!is.null(m))
    return(m)
  if (xbuild$plot$layers[[layer]]$inherit.aes)
    return(xbuild$plot$mapping[[aes]])
  else
    return(NULL)
}

.getGGPlotData = function(x, xbuild, layer, panel) {
  # This returns a data frame -- useable by MakeAccessible, but will need to change
  # if it's going to be used by VI via the whisker template
  fulldata = xbuild$data[[layer]]
  return(fulldata[fulldata$PANEL == panel,])
}

# Get the original data values for variable var in the given layer
# NOT CURRENTLY IN USE
# Dangerous since the original data may have changed or no longer be present in the env
# Also note that the returned data won't necessarily align to the plot data -- e.g. if
# facets are present or a stat other than identity is in play
.getGGRawValues = function(x, xbuild, layer, var) {
  map = .getGGMapping(x, xbuild, layer, var)
  if (class(x$layers[[layer]]$data) == "waiver")
    return(eval(map,x$data))
  else
    return(eval(map,x$layers[[layer]]$data))
}

# Smooth layer details

.getGGSmoothParams = function(x, xbuild, layer) {
  return(xbuild$plot$layers[[layer]]$stat_params)
}

.getGGSmoothMethod = function(x, xbuild, layer) {
  Out = xbuild$plot$layers[[layer]]$stat_params$method
  if(is.null(Out))          Out = c("lowess")
  return(Out)
}

.getGGSmoothSEflag = function(x, xbuild, layer) {
  return(xbuild$plot$layers[[layer]]$stat_params$se)
}

.getGGSmoothLevel = function(x, xbuild, layer) {
 Out = xbuild$plot$layers[[layer]]$stat_params$level
  if(is.null(Out))           Out = 0.95
  return(Out) 
} 

.isGuideHidden = function(x, xbuild, aes) {
#  Need to look through all layers to figure out whether this aesthetic is involved, and
#  if so, has show.legend been specified?
  someLayerShows = FALSE
  for (layer in xbuild$plot$layers) {
    mapped = aes %in% names(layer$mapping) ||
                (layer$inherit.aes && aes %in% names(xbuild$plot$mapping))
    if (mapped && (is.na(layer$show.legend) || layer$show.legend)) {
       someLayerShows = TRUE
     }
  }
  if (!someLayerShows)
    return(TRUE)
  scale = .getGGScale(x, xbuild, aes)
  if (!is.null(scale) && !is.null(scale$guide) && scale$guide %in% c("none",FALSE))
    return(TRUE)
  guides = xbuild$plot$guides
  if (!is.null(guides) && !is.null(guides[[aes]]) && guides[[aes]] %in% c("none",FALSE))
    return(TRUE)
  legend.position = xbuild$plot$theme$legend.position
  if (!is.null(legend.position) && legend.position == "none")
    return(TRUE)
  return(FALSE)
}
#Helper list for finding whether words start with vowels to give them an/a accordingly
.giveAnOrA =function(wordChosen){
  vowels = c("a", "e", "i", "o", "u")
  AnA = ifelse(is.element(substr(wordChosen, 1,1), vowels), "an", "a")
  return(AnA)
}



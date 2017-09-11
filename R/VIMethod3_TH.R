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
    if (is.null(x[[i]])) {
      result[[i]] = character(0)
    } else {
    render = whisker::whisker.render(templates[names(x[i])],x[[i]],
                                     partials=templates)
    result[[i]] = as.vector(strsplit(render,"<br>",fixed=TRUE)[[1]])
    }
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
  if (is.null(x))
    return(NULL)
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
      if (!is.null(n)) {
        if (n>1) x$panels[[paneli]]$panellayers[[layeri]]$s = TRUE
        if (n>threshold) x$panels[[paneli]]$panellayers[[layeri]]$largecount = TRUE
      }
    }  
  return(x)
}

### Print function for the object created by VI.ggplot
### Prints the text component of the object
print.VIgraph = function(x, ...) {
  cat(x$text,sep="\n")
  invisible(x)
}

# Small helper function - builds list excluding items that are null or length 0
.VIlist = function(...) {
  l = list(...)
  l[(lapply(l,length)>0)] 
}

# Returns the VIgraph object with the text trimmed down to only those rows
# containing the specified pattern.  Passes extra parameters on to grepl.
# Note that only the text portion of the VIgraph is modified; the complete
# VIgg structure is still included
VIgrep = function(pattern,x,...) {
  if (class(x) != "VIgraph") {
    message(paste("VIgrep doesn't know how to process this object.",
                  "Only the output from running VI on a ggplot object can be processed by VIgrep."))
    return(NULL)
  }
  x$text = x$text[grepl(pattern,x$text,...)]
  x
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
  return(VIgraph)
}

# Builds the VIgg structure describing the graph
.VIstruct.ggplot = function(x) {
  xbuild = suppressMessages(ggplot_build(x))
  # If this is a plot we really can't deal with, say so now
  if (!(.getGGCoord(x,xbuild) %in% c("CoordCartesian","CoordFixed"))) {
    message("VI cannot process ggplot objects with flipped or non-Cartesian coordinates")
    return(NULL)
  }
  title = .getGGTitle(x,xbuild)
  subtitle = .getGGSubtitle(x,xbuild)
  caption = .getGGCaption(x,xbuild)
  annotations = .VIlist(title=title,subtitle=subtitle,caption=caption)
  xlabel = .getGGXLab(x,xbuild)
  ylabel = .getGGYLab(x,xbuild)
  if (!.getGGScaleFree(x,xbuild)) {    # Can talk about axis ticks at top level unless scale_free
    samescale = TRUE
    xticklabels = .getGGXTicks(x,xbuild,1)
    yticklabels = .getGGYTicks(x,xbuild,1)
  } else {
    samescale = NULL
    xticklabels = NULL
    yticklabels = NULL
  }
  xaxis = .VIlist(xlabel=xlabel,xticklabels=xticklabels,samescale=samescale)
  yaxis = .VIlist(ylabel=ylabel,yticklabels=yticklabels,samescale=samescale)
  legends = .buildLegends(x,xbuild)
  panels = .buildPanels(x,xbuild)
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

.buildLegends = function(x,xbuild) {
  legends = list()
  labels = .getGGGuideLabels(x,xbuild)
  names = names(labels)
  guides = .getGGGuides(x,xbuild)
  for (i in seq_along(labels)) {
    name = names[i]
    mapping = labels[[i]]
    scaleinfo = .getGGScale(x,xbuild,name)
    scalediscrete = scaleinfo$scalediscrete
    if (!is.null(scalediscrete)) {
      scalelevels = scaleinfo$range
      scalefrom = NULL
      scaleto = NULL
    } else {
      scalelevels = NULL
      scalefrom = scaleinfo$range[1]
      scaleto = scaleinfo$range[2]
    }
    hidden = if (!is.null(guides[[name]]) && (guides[[name]]=="none" || guides[[name]]==FALSE)) TRUE
    legend = .VIlist(aes=name,mapping=unname(mapping),
                     scalediscrete=scalediscrete,scalelevels=scalelevels,
                     scalefrom=scalefrom,scaleto=scaleto,
                     hidden=hidden)
    legends[[i]] = legend
  }
  return(legends)
}

.buildPanels = function(x,xbuild) {
  f = .getGGFacetLayout(x,xbuild)
  panels = list()
  names = colnames(f)
  panelvars = names[which(!names %in% c("PANEL","ROW","COL","SCALE_X","SCALE_Y"))]
  for (i in seq_along(f$PANEL)) {
    panel = list()
    panel[["panelnum"]] = as.character(f$PANEL[i])
    panel[["row"]] = f$ROW[i]
    panel[["col"]] = f$COL[i]
    scalefree = .getGGScaleFree(x,xbuild)
    panel[["samescale"]] = if (!scalefree) TRUE
    if (scalefree) { 
      panel[["xticklabels"]] = .getGGXTicks(x,xbuild,i)
      panel[["yticklabels"]] = .getGGYTicks(x,xbuild,i)
      panel[["xlabel"]] = .getGGXLab(x,xbuild) # Won't actually change over the panels
      panel[["ylabel"]] = .getGGYLab(x,xbuild) # But we still want to mention them
      
    }
    vars = list()
      for (j in seq_along(panelvars)) {
        vars[[j]] = list(varname=as.character(panelvars[j]),
                         value=as.character(f[[i,panelvars[j]]]))
      }
    panel[["vars"]] = vars
    panel[["panellayers"]] = .buildLayers(x,xbuild,i)
    panels[[i]] = panel
  }
  return(panels)  
}

.buildLayers = function(x,xbuild,panel) {
  layerCount = .getGGLayerCount(x,xbuild)
  layers = list()
  for (layeri in 1:layerCount) {
    layeraes = .getGGLayerAes(x,xbuild,layeri)
    layer = .VIlist(layernum=layeri,layeraes=layeraes)
    data =.getGGPlotData(x,xbuild,layeri,panel)
    layer$data = data
    n = nrow(data)
    if (length(data$group)>0 && max(data$group)>0)  # ungrouped data have group = -1 
      ngroups = length(unique(data$group))
    else
      ngroups = 1
    layerClass = .getGGLayerType(x,xbuild,layeri)
    if (layerClass == "GeomHline") {
      layer$type = "hline"
      layer$n = n
      layer$hlinetype = TRUE
      map = .mapDataValues(x,xbuild,list("yintercept"),panel,list(yintercept=data$yintercept))
      if (!is.null(map$badTransform)) {
        layer$badtransform = TRUE
        layer$ransform = map$badTransform
      } 
      layer$yintercept = map$value$yintercept
    } else if (layerClass == "GeomPoint") {
      layer$type = "point"
      layer$n = n
      map = .mapDataValues(x,xbuild,list("x","y"),panel,list(x=data$x,y=data$y))
      if (!is.null(map$badTransform)) {
        layer$badtransform = TRUE
        layer$ransform = map$badTransform
      } 
      xvals = map$value$x
      yvals = map$value$y
      points = unname(as.list(data.frame(t(cbind(as.character(1:nrow(data)),
                                                 xvals,yvals)),stringsAsFactors=FALSE)))
      points = lapply(points,function(x) {names(x)=c("pointnum","x","y"); x})
      layer$points = points
    } else if (layerClass == "GeomBar") {
      layer$type = "bar"
      layer$n = n
      map = .mapDataValues(x,xbuild,list("x","y"),panel,list(x=data$x,y=data$y))
      if (!is.null(map$badTransform)) {
        layer$badtransform = TRUE
        layer$ransform = map$badTransform
      } 
      xvals = map$value$x
      yvals = map$value$y
      bars = unname(as.list(data.frame(t(cbind(as.character(1:nrow(data)),xvals,yvals)),stringsAsFactors=FALSE)))
      bars = lapply(bars,function(x) {names(x)=c("barnum","x","y"); x})
      layer$bars = bars
    } else if (layerClass == "GeomLine") {
      layer$type = "line"
      # Lines are funny - each item in the data is a point
      # The number of actual lines depends on the group parameter
      layer$n = ngroups
      map = .mapDataValues(x,xbuild,list("x","y"),panel,list(x=data$x,y=data$y))
      if (!is.null(map$badTransform)) {
        layer$badtransform = TRUE
        layer$ransform = map$badTransform
      } 
      xvals = map$value$x
      yvals = map$value$y
      points = unname(as.list(data.frame(t(cbind(as.character(1:nrow(data)),xvals,yvals)),stringsAsFactors=FALSE)))
      points = lapply(points,function(x) {names(x)=c("pointnum","x","y"); x})
      layer$points = points
    } else if (layerClass == "GeomBoxplot") {
      ##  ***** NEED TO TRANSFORM ALL THE VALUES (except NOUTLIERS) -- NOT YET DONE *****
      layer$type = "box"
      layer$n = n
      nOutliers = sapply(data$outliers,length)
      map = .mapDataValues(x,xbuild,list("x","ymin","lower","middle","upper","ymax"),panel,
                                    list(x=data$x,ymin=data$ymin,lower=data$lower,middle=data$middle,
                                         upper=data$upper,ymax=data$ymax))
      if (!is.null(map$badTransform)) {
        layer$badtransform = TRUE
        layer$ransform = map$badTransform
      } 
      x = map$value$x
      # Might want to report high and low outliers separately?
      boxes = unname(as.list(data.frame(t(cbind(as.character(1:nrow(data)),map$value$x,
                                                map$value$ymin,map$value$lower,map$value$middle,
                                                map$value$upper,map$value$ymax,
                                                unname(nOutliers))),stringsAsFactors=FALSE)))
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


# Converts data values back to their original scales -- converting factor
# variables back to their levels, and undoing transforms
.mapDataValues = function(x,xbuild,varlist,panel,valuelist) {
  badTransform = NULL
  transformed = list()
  for (var in varlist) {
    value = valuelist[[var]]
    scale = .getGGPanelScale(x,xbuild,var,panel)

    if (is.null(scale))   # No scale - just return the stored value
      r = value
    else if (("ScaleDiscrete" %in% class(scale))) { # Try to map back to levels
      map = scale$range$range
      if (is.null(map))
        r = value
      else {
        mapping = as.character(map[value])
        if (length(mapping) != length(value))  # Can happen with jittered data
          r = value     # Something's gone wrong - bail
        else
          r = mapping
      }
    } else {  # Continuous scale - try to undo any transform
      if (is.null(scale$trans)) {   # No transform
        r = value
      } else if (is.null(scale$trans$inverse)) {
        badTransform = scale$trans$name
        r = value
      } else {
        r = scale$trans$inverse(value)
      }
    }
    transformed[[var]] = r
  }
  return(list(value=transformed,badTransform=badTransform))
}

# For now, limit all values printed to 2 decimal places.  Should do something smarter -- what does
# ggplot itself do?
.cleanPrint = function(x) {
  if (is.numeric(x))
    return(round(x,2))
  else
    return(x)
}
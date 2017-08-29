textify.VIgg = function(x) {
  VItemplate = "
{{^annotations}}
This is an untitled chart.
{{/annotations}}
{{#annotations}}
{{#title}}This chart titled '{{title}}' {{/title}}
{{^title}}This untitled chart {{/title}}
{{#subtitle}}has the subtitle {{subtitle}}.{{/subtitle}}
{{^subtitle}}has no subtitle.{{/subtitle}}<br>
{{#caption}}It has caption {{caption}}.<br>{{/caption}}
{{/annotations}}
{{^xaxis}}It has no x-axis.<br>{{/xaxis}}
{{#xaxis}}It has x-axis {{xlabel}} with labels {{xticklabels}}<br>{{/xaxis}}
{{^yaxis}}It has no y-axis.<br>{{/yaxis}}
{{#yaxis}}It has y-axis {{ylabel}} with labels {{yticklabels}}<br>{{/yaxis}}
{{#colour}}Colour is used to represent {{colourlabel}}
{{#colourfactor}}, a factor with levels: {{factorlevels}}{{/colourfactor}}.<br>
{{/colour}}
{{#fillcolour}}Fill colour is used to represent {{fillcolourlabel}}
{{#fillcolourfactor}}, a factor with levels: {{/fillcolourfactor}}{{fillcolourfactor}}.<br>
{{/fillcolour}}
{{#nlayers}}It has {{nlayers}} layers.<br>{{/nlayers}}
{{#layers}}
{{>layerTemplate}}
{{/layers}}
"
  layerTemplate = "
{{#layernum}}Layer {{layernum}} is {{/layernum}}
{{^layernum}}The chart is {{/layernum}}
{{#lineflag}}
a line chart with {{segments}} segments.<br>
{{/lineflag}}
{{#hlineflag}}
a horizontal line at position {{yval}}.<br>
  {{/hlineflag}}
"
  template=gsub("\n","",VItemplate)
  layerTemplate=gsub("\n","",layerTemplate)
  return(gsub("<br>","\n",
              whisker.render(template,x,partials=list(layerTemplate=layerTemplate))))
}

print.VIgg = function(x, ...) {
  cat(textify.VIgg(x))
}

.VIlist = function(...) {
  l = list(...)
  l[lapply(l,length)>0] 
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
  layers = list()
  VIgg = .VIlist(annotations=annotations,xaxis=xaxis,yaxis=yaxis,
              colour=colour,fillcolour=fillcolour,layers=layers)
  class(VIgg) = "VIgg"
  return(VIgg)
}

# Just saving this here until I've fully replicated it above
.oldVI.ggplot = function(x, Describe=FALSE, ...) {
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
  facetRows=.getGGFacetRows(x);
  facetCols=.getGGFacetCols(x);
  if (!is.null(facetRows) | !is.null(facetCols)) {
    facetTxt = "The chart is faceted "
    if (!is.null(facetRows)) 
      facetTxt = paste0(facetTxt," with ", paste0(paste(names(facetRows),collapse=", ")," as the rows"))
    if (!is.null(facetRows) & !is.null(facetCols))
      facetTxt = paste0(facetTxt," and")
    if (!is.null(facetCols))
      facetTxt = paste0(facetTxt," with ", paste0(paste(names(facetCols),collapse=", ")," as the columns"))
    facetTxt = paste0(facetTxt,"\n")
    VItext["facets"] = facetTxt;
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
    return(x$facet$params$rows)
  else
    return(NULL)
}
.getGGFacetCols = function(x){
  if (length(x$facet$params$cols)>0)
    return(x$facet$params$cols)
  else
    return(NULL)
}
.getGGPlotData = function(x,n) {
  return(suppressMessages(ggplot_build(x))$data[[n]])
}

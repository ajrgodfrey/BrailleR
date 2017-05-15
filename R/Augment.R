
Augment = function(x) {
            UseMethod("Augment")
          }

Augment.default =
    function(x) {
    message("Nothing done to augment this graph object.")
    return(invisible(x))
}

Augment.Augmented =
    function(x) {
return(invisible(x))
}

Augment.boxplot = function(x) {
      x=.AugmentBase(x)
      x$NBox = length(x$n)
      x$VarGroup = ifelse(x$NBox > 1, 'group', 'variable')
      x$VarGroupUpp = ifelse(x$NBox > 1, 'Group', 'This variable')
      x$IsAre = ifelse(x$NBox > 1, 'are', 'is')
      x$Boxplots = ifelse(x$NBox > 1, paste(x$NBox, 'boxplots'), 'a boxplot')
      x$VertHorz = ifelse(x$horizontal, 'horizontally', 'vertically')
      ##vs This should be done when one actually wants to use the names
      ##
      ## if (x$NBox > 1) {
      ##     x$names = paste0('"', x$names, '"')
      ## } else {
      ##   x$names = NULL
      ## }
      return(invisible(x))
}

Augment.dotplot = function(x) {
      x=.AugmentBase(x)
      x$NPlot = length(x$vals)
      x$VarGroup = ifelse(x$NPlot > 1, 'group', 'variable')
      x$VarGroupUpp = ifelse(x$NPlot > 1, 'Group', 'This variable')
      x$IsAre = ifelse(x$NPlot > 1, 'are', 'is')
      x$dotplots = ifelse(x$NPlot > 1, paste(x$NPlot, 'dotplots'), 'a dotplot')
      x$VertHorz = ifelse(x$vertical, 'vertically', 'horizontally')
return(invisible(x))
}

Augment.eulerr = 
    function(x) {
      X <- x[["coefficients"]][, 1L]
      Y <- x[["coefficients"]][, 2L]
      r <- x[["coefficients"]][, 3L]

x$TextPositions=list(x=X, y=Y)
      return(invisible(x))
    }


Augment.gg = Augment.ggplot = function(x) {
      x$ExtraArgs$main <- ifelse(is.null(x$labels$title), "", x$labels$title)
      x$ExtraArgs$sub <- ifelse(is.null(x$labels$subtitle), "", x$labels$subtitle)
      x$ExtraArgs$xlab <- ifelse(is.null(x$labels$x), "", x$labels$x)
      x$ExtraArgs$ylab <- ifelse(is.null(x$labels$y), "", x$labels$y)
      class(x)=c(class(x), "Augmented") # order change here means updates are possible using functions in UpdateGraphs.R
      return(invisible(x))
}


Augment.histogram = function(x) {
    x$ExtraArgs$main <- if (is.null(x$ExtraArgs$main)) {paste("Histogram of", x$xname)} else {x$ExtraArgs$main}
    x$ExtraArgs$xlab <- if (is.null(x$ExtraArgs$xlab)) {x$xname} else {x$ExtraArgs$xlab}
    x$ExtraArgs$ylab <- if (is.null(x$ExtraArgs$ylab)) {"Frequency"} else {x$ExtraArgs$ylab}
    x$NBars = length(x$counts)
    x=.AugmentBase(x)
return(invisible(x))
}

Augment.scatterplot = 
    function(x) {
      x=.AugmentBase(x)

      VLength = nrow(x$data)
NBreaks= 6 #specified as something from 6 to 10 depending on how many obs there are.
      Breaks = round(seq(0, VLength, length.out= NBreaks+1),0)
      BinEnds =Breaks[-1]
      BinStarts = Breaks[-(NBreaks+1)] + 1 # not overlapping
      POI = list(MeanX=0, MedianX=0, MinX=0, MaxX=0, SDX=0, MeanY=0, MedianY=0, MinY=0, MaxY=0, SDY=0, CorXY=0, N=0) # and whatever else we like
      for(i in 1:NBreaks){
        POI$MeanX[i] = mean(x$data[BinStarts[i]:BinEnds[i], "x"])
        POI$MeanY[i] = mean(x$data[BinStarts[i]:BinEnds[i], "y"])
        POI$MedianX[i] = median(x$data[BinStarts[i]:BinEnds[i], "x"])
        POI$MedianY[i] = median(x$data[BinStarts[i]:BinEnds[i], "y"])
        POI$MinX[i] = min(x$data[BinStarts[i]:BinEnds[i], "x"])
        POI$MinY[i] = min(x$data[BinStarts[i]:BinEnds[i], "y"])
        POI$MaxX[i] = max(x$data[BinStarts[i]:BinEnds[i], "x"])
        POI$MaxY[i] = max(x$data[BinStarts[i]:BinEnds[i], "y"])
        POI$SDX[i] = sd(x$data[BinStarts[i]:BinEnds[i], "x"])
        POI$SDY[i] = sd(x$data[BinStarts[i]:BinEnds[i], "y"])
        POI$N[i] = nrow(x$data[BinStarts[i]:BinEnds[i], ])
        POI$CorXY[i] = cor(x$data[BinStarts[i]:BinEnds[i], "x"], x$data[BinStarts[i]:BinEnds[i], "y"])
      }
      x$GroupSummaries = POI
      return(invisible(x))
    }


Augment.tsplot = 
  function(x) {
    x$ExtraArgs$xlab <- if (is.null(x$ExtraArgs$xlab)) {"Time"} else {x$ExtraArgs$xlab}
    x=.AugmentBase(x)
    series =x [[1]]
    if (is.na(match(NA, series))) {
      x$GroupSummaries <- .TsSplitEqual(series, breaks=10)
      x$Continuous <- TRUE
    } else {
      x$GroupSummaries <- .TsSplitDiscont(series)
      x$Continuous <- FALSE
    }
    return(invisible(x))
  }

.TsSplitDiscont = function(series) {
  POI = list(Mean=vector(), Median=vector(), SD=vector(), N=vector())
  current <- vector()
  for(i in 1:length(series)) {
    if (!is.na(series[i])) {
      current <- append(current, series[i])
      next
    }
    if (length(current) > 0) {
      POI <- .TsSumSegment(POI, current)
      current <- vector()
    }
  }
  if (length(current) > 0) {
    POI <- .TsSumSegment(POI, current)
  }
}

.TsSumSegment = function(poi, segment, position=length(poi$N)+1) {
  poi$Mean[position] = mean(segment, na.rm=T)
  poi$Median[position] = median(segment, na.rm=T)
  poi$SD[position] = sd(segment, na.rm=T)
  poi$N[position] = sum(!is.na(segment))
  return(invisible(poi))
}

.TsSplitEqual = function(series, breaks=10) {
  NBreaks= 10 #specified as something from 6 to 10 depending on how many obs there are.
  VLength = length(series)
  Breaks = round(seq(0, VLength, length.out= NBreaks+1),0)
  BinEnds =Breaks[-1]
  BinStarts = Breaks[-(NBreaks+1)] + 1 # not overlapping
  POI = list(Mean=0, Median= 0, SD=0, N=0) # and whatever else we like
  for(i in 1:NBreaks){
    POI <- .TsSumSegment(POI, series[BinStarts[i]:BinEnds[i]], i)
  }
  return(invisible(POI))
}


.AugmentBase = function(x){
    x$par$xaxp = par()$xaxp
    x$par$yaxp = par()$yaxp
    x$xTicks = seq(x$par$xaxp[1], x$par$xaxp[2], length.out=x$par$xaxp[3]+1)
    x$yTicks = seq(x$par$yaxp[1], x$par$yaxp[2], length.out=x$par$yaxp[3]+1)
    x$ExtraArgs$main <- if (is.null(x$ExtraArgs$main)) {""} else {x$ExtraArgs$main}
    x$ExtraArgs$sub <- if (is.null(x$ExtraArgs$sub)) {""} else {x$ExtraArgs$sub}
    x$ExtraArgs$xlab <- if (is.null(x$ExtraArgs$xlab)) {""} else {x$ExtraArgs$xlab}
    x$ExtraArgs$ylab <- if (is.null(x$ExtraArgs$ylab)) {""} else {x$ExtraArgs$ylab}
      class(x)=c("Augmented", class(x))
      return(invisible(x))
      }

.AugmentedGrid = function(x){
# x$xTicks = seq(x$xaxp[1], x$xaxp[2], length.out=x$xaxp[3]+1)
# x$yTicks = seq(x$yaxp[1], x$yaxp[2], length.out=x$yaxp[3]+1)
 class(x)=c("Augmented", class(x))
return(invisible(x))
}

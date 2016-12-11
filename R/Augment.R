Augment = function(x) {
            UseMethod("Augment")
          }

Augment.default =
    function(x) {
    message("Nothing done.")
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
      if (x$NBox > 1) {
        x$names = paste0('"', x$names, '"')
      } else {
        x$names = NULL
      }
      return(invisible(x))
}

Augment.ggplot = function(x) {
return(invisible(x))
}

Augment.histogram = function(x) {
x=.AugmentBase(x)
return(invisible(x))
}

.AugmentBase = function(x){
      x$xaxp = par()$xaxp
      x$yaxp = par()$yaxp
      x$xTicks = seq(x$xaxp[1], x$xaxp[2], length.out=x$xaxp[3]+1)
      x$yTicks = seq(x$yaxp[1], x$yaxp[2], length.out=x$yaxp[3]+1)
      class(x)=c("Augmented", class(x))
      return(invisible(x))
      }

.AugmentedGrid = function(x){
# x$xTicks = seq(x$xaxp[1], x$xaxp[2], length.out=x$xaxp[3]+1)
# x$yTicks = seq(x$yaxp[1], x$yaxp[2], length.out=x$yaxp[3]+1)
class(x)=c("Augmented", class(x))
return(invisible(x))
}

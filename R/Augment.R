Augment = function(x) {
            UseMethod("Augment")
          }

Augment.default =
    function(x) {
return(invisible(x))
}

Augment.boxplot = function(x) {
      x$NBox = length(x$n)
      x$VarGroup = ifelse(x$NBox > 1, 'group', 'variable')
      x$VarGroupUpp = ifelse(x$NBox > 1, 'Group', 'This variable')
      x$IsAre = ifelse(x$NBox > 1, 'are', 'is')
      x$Boxplots = ifelse(x$NBox > 1, paste(NBox, 'boxplots'), 'a boxplot')
      x$VertHorz = ifelse(x$horizontal, 'horizontally', 'vertically')
      if (x$NBox > 1) {
        x$names = paste0('"', x$names, '"')
      } else {
        x$names = NULL
      }
      x=.Augment(x)
      return(invisible(x))
}

Augment.ggplot = function(x) {
return(invisible(x))
}

Augment.histogram = function(x) {
return(invisible(x))
}

.Augment=function(x){
if(!is.null(x)){
class(x)=c("Augmented", class(x))
}
return(invisible(x))
}

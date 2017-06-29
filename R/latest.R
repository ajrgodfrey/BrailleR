## Constructs the center of the scatterplot
.AddXMLAddScatterCenter = function(root, sp=NULL) {
  annotation = .AddXMLAddAnnotation(root, position=4, id="center", kind="grouped")
  gs = sp$GroupSummaries
  len = length(gs$N)
    XML::addAttributes(
           annotation$root, speech="Scatter Plot",
           speech2=paste("Scatter Plot divided into",
                         len, "sub intervals of equal width"),
           type="Center")
  annotations <- list()
  for (i in 1:len) {
    annotations[[i]] = .AddXMLtimeseriesSegment(
      root, position=i, mean=gs$MeanY[i], median=gs$MedianY[i], sd=gs$SDY[i], n=gs$N[i])
  }
  annotations[[i + 1]] = .AddXMLAddAnnotation(
    root, position=0, id=.AddXMLmakeId("box", "1.1.1"), kind="passive")
  .AddXMLAddComponents(annotation, annotations)
  .AddXMLAddChildren(annotation, annotations)
  .AddXMLAddParents(annotation, annotations)
  return(invisible(annotation))
}

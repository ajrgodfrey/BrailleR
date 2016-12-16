AddXML = function(x, file) {
            UseMethod("AddXML")
          }

AddXML.default =
    function(x, file) {
return(invisible("nothing done"))
}

AddXML.boxplot = function(x, file) {
    doc = .AddXMLdocument("boxplot")
    root = XML::xmlRoot(doc)
    annotations = .AddXMLaddNode(root, "annotations")
    .AddXMLaddXAxis(annotations, label=x$xlab)
    .AddXMLaddYAxis(annotations, label=x$ylab)
    XML::saveXML(doc=doc, file=file)
}

AddXML.dotplot = function(x, file) {
    doc = .AddXMLdocument("dotplot")
    root = XML::xmlRoot(doc)
    annotations = .AddXMLaddNode(root, "annotations")
    .AddXMLaddXAxis(annotations, label=x$xlab)
    .AddXMLaddYAxis(annotations, label=x$ylab)
    XML::saveXML(doc=doc, file=file)
}


AddXML.eulerr = function(x, file) {
    doc = .AddXMLdocument("eulerr")
    root = XML::xmlRoot(doc)
    annotations = .AddXMLaddNode(root, "annotations")
    XML::saveXML(doc=doc, file=file)
}

AddXML.ggplot = function(x, file) {
    doc = .AddXMLdocument("ggplot")
    root = XML::xmlRoot(doc)
    annotations = .AddXMLaddNode(root, "annotations")
    .AddXMLaddXAxis(annotations, label=x$xlab)
    .AddXMLaddYAxis(annotations, label=x$ylab)
    XML::saveXML(doc=doc, file=file)
}

AddXML.histogram = function(diag, file) {
    doc = .AddXMLhistogram(diag)
    XML::saveXML(doc=doc, file=file)
}


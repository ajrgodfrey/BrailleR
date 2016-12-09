AddXML = function(x, file) {
            UseMethod("AddXML")
          }

AddXML.default =
    function(x, file) {
return(invisible("nothing done"))
}

AddXML.histogram = function(x, file) {
    .AddXMLActive = NULL
    .AddXMLPassive = NULL
    .AddXMLGrouped = NULL
    doc = .AddXMLdocument("histogram")
    root = XML::xmlRoot(doc)
    annotations = .AddXMLaddNode(root, "annotations")
    .AddXMLaddXAxis(annotations, label=x$xlab)
    .AddXMLaddYAxis(annotations, label=x$ylab)
    XML::saveXML(doc=doc, file=file)
}


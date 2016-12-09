AddXML = function(x, file) {
            UseMethod("AddXML")
          }

AddXML.default =
    function(x, file) {
return(invisible("nothing done"))
}

AddXML.histogram = function(x, file) {
    .AddXMLActive = NULL
    .AddXMLPASSIVE = NULL
    .AddXMLGROUPED = NULL
    doc = .AddXMLdocument("histogram")
    root = XML::xmlRoot(doc)
    annotations = .AddXMLaddNode(root, "annotations")
    ## TODO: This is only a test. This value has to be extracted from the model.
    .AddXMLaddXaxis(annotations, label="Ozone")
    XML::saveXML(doc=doc, file=file)
}


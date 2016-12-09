
.AddXMLaddXaxis = function(root, values=NULL, label="", groupPosition=2) {
    position = 1
    .AddXMLaddLabel(root, label=label, position=position, id="xlab", axis="xaxis")
}


.AddXMLaddLabel = function(root, label="", position=1, id="", axis="") {
    annotation = .AddXMLaddAnnotation(root, position=position,
                                      id=paste("graphics-plot-1", id, "1.1", sep="-"), type="active")
    XML::addAttributes(annotation$root, speech=paste("Label", label), type="Label")
    if (axis != "") {
        .AddXMLaddNode(annotation$parents, "grouped", axis)
    }
    annotation$root
}

.AddXMLaddAnnotation = function(root, position=1, id="", type="active") {
    annotation = .AddXMLaddNode(root, "annotation")
    .AddXMLaddNode(annotation, type, id)
    .AddXMLStoreComponent(id, type)
    list(root = annotation,
          position = .AddXMLaddNode(annotation, "position", content=position),
          parents = .AddXMLaddNode(annotation, "parents"),
          component = .AddXMLaddNode(annotation, "component"),
          neighbours = .AddXMLaddNode(annotation, "neighbours"))
}


.AddXMLdocument = function(tag = "histogram") {
    doc = XML::newXMLDoc()
    top = XML::newXMLNode(tag, doc = doc)
    XML::ensureNamespace(top, c(sre = "http://www.chemaccess.org/sre-schema"))
    doc
}

.AddXMLaddNode = function(node, tag, content="") {
    newNode = XML::newXMLNode(paste("sre:", tag, sep=""), parent = node)
    if (content != "") {
        XML::newXMLTextNode(content, parent=newNode)
    }
    newNode
}

.AddXMLActive = NULL
.AddXMLPassive = NULL
.AddXMLGrouped = NULL

.AddXMLStoreComponent = function(id, type) {
    set = switch(type,
                  active = .AddXMLActive,
                  passive = .AddXMLPassive,
                  grouped = .AddXMLGrouped)
    c(set, id)
}

## Annotating axes
.AddXMLaddXAxis = function(root, values=NULL, label="", groupPosition=2) {
    .AddXMLaddAxis(root, values, label, groupPosition, "x axis", "xaxis", "xlab", "bottom")
}

.AddXMLaddYAxis = function(root, values=NULL, label="", groupPosition=3) {
    .AddXMLaddAxis(root, values, label, groupPosition, "y axis", "yaxis", "ylab", "left")
}

.AddXMLaddAxis = function(root, values, label, groupPosition, name, groupId, labelId, lineId) {
    position = 0
    labelNode = .AddXMLaxisLabel(root, label=label, position=position <- position + 1,
                     id=labelId, axis=groupId)
    lineNode = .AddXMLaxisLine(root, id=lineId, axis=groupId)
    tickNodes = .AddXMLaxisValues(root, values=values,
                              position=position <- position + 1, id=lineId, axis=groupId)
    annotations = c(list(labelNode, lineNode), tickNodes)
    .AddXMLaxisGroup(root, groupId, name, values=values, label=label,
                     annotations=annotations, position=groupPosition)
}


## Aux method for axis group
.AddXMLaxisGroup = function(root, id, name, values=NULL, label="", annotations=NULL, position=1) {
    annotation = .AddXMLaddAnnotation(root, position=position, id=id, type="grouped")
    clone <- function(x) .AddXMLclone(annotation$component, x$element)
    lapply(annotations, clone)
    print(label)
    XML::addAttributes(annotation$root, speech=paste(name, label),
                       speech2=paste(name, label, "with values from", values[1], "to", values[length(values)]),
                       type="Axis")
    annotation
}

## Aux methods for axes annotation.
.AddXMLaxisLabel = function(root, label="", position=1, id="", axis="") {
    annotation = .AddXMLaddAnnotation(root, position=position,
                                      id=.AddXMLmakeId(id, "1.1"), type="active")
    XML::addAttributes(annotation$root, speech=paste("Label", label), type="Label")
    if (axis != "") {
        .AddXMLaddNode(annotation$parents, "grouped", axis)
    }
    annotation
}

.AddXMLaxisLine = function(root, position=1, id="", axis="") {
    annotation = .AddXMLaddAnnotation(root, position=position,
                                      id=.AddXMLmakeId(id, "line", "1.1"), type="passive")
    XML::addAttributes(annotation$root, type="Line")
    if (axis != "") {
        .AddXMLaddNode(annotation$parents, "grouped", axis)
    }
    annotation
}

.AddXMLaxisValues = function(root, values=NULL, position=1, id="", axis="") {
    annotations <- list()
    for (i in 1:length(values)) {
        valueId = .AddXMLmakeId(id, "axis", "labels", paste("1.1", i, sep="."))
        value = .AddXMLaddAnnotation(root, position=position + i - 1,
                                     id=valueId, type="active")
        XML::addAttributes(value$root, speech=paste("Value", values[i]), type="Value")
        
        tickId = .AddXMLmakeId(id, "axis", "ticks", paste("1.1", i, sep="."))
        tick = .AddXMLaddAnnotation(root, id=tickId, type="passive")
        XML::addAttributes(tick$root, type="Tick")

        .AddXMLaddNode(value$component, "passive", tickId)
        .AddXMLaddNode(tick$component, "active", valueId)

        if (axis != "") {
            .AddXMLaddNode(value$parents, "grouped", axis)
            .AddXMLaddNode(tick$parents, "grouped", axis)
        }
        annotations[[2 * i - 1]] = value
        annotations[[2 * i]] = tick
    }
    annotations
}


.AddXMLmakeId = function(...) {
    paste("graphics-plot-1", ..., sep="-")
}

.AddXMLaddAnnotation = function(root, position=1, id="", type="active") {
    annotation = .AddXMLaddNode(root, "annotation")
    element = .AddXMLaddNode(annotation, type, id)
    ## This should be changed!
    .AddXMLStoreComponent(id, type)
    list(root = annotation,
         element = element,
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

# A shallow clone function for leaf nodes only. Avoids problems with duplicating
# namespaces.
.AddXMLclone = function(root, node) {
    newNode = XML::newXMLNode(XML::xmlName(node, full=TRUE), parent = root)
    XML::newXMLTextNode(XML::xmlValue(node), parent=newNode)
    newNode
}

## Store components for top level Element
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

## Annotating different types of diagrams.
##
## Histogram annotation.
.AddXMLhistogram = function(diag) {
    .AddXMLcomponents <<- list()
    doc = .AddXMLdocument("histogram")
    root = XML::xmlRoot(doc)
    annotations = .AddXMLaddNode(root, "annotations")

    ## title = AddXMLaddTitle()

    xlab <- if (is.null(diag$xlab)) {diag$xname} else {diag$xlab}
    ylab <- if (is.null(diag$ylab)) {"Frequency"} else {diag$ylab}
    xaxis = .AddXMLaddXAxis(annotations, label=xlab, values=diag$xTicks)
    yaxis = .AddXMLaddYAxis(annotations, label=ylab, values=diag$yTicks)
    
    ## That's probably the only one that is diagram dependent.
    center = .AddXMLaddHistogramCenter(
        annotations, mids=diag$mids, counts=diag$counts, density=diag$density, breaks=diag$breaks)
    .AddXMLaddChart(annotations, type="Histogram", children=list(xaxis, yaxis, center))
    doc
}

## Annotating title elements

## Annotating axes
##
## Generic axis annotation function.
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

## Parameterisation for x-axis
.AddXMLaddXAxis = function(root, values=NULL, label="", groupPosition=2) {
    .AddXMLaddAxis(root, values, label, groupPosition, "x axis", "xaxis", "xlab", "bottom")
}

## Parameterisation for x-axis
.AddXMLaddYAxis = function(root, values=NULL, label="", groupPosition=3) {
    .AddXMLaddAxis(root, values, label, groupPosition, "y axis", "yaxis", "ylab", "left")
}


## Aux method for axis group
.AddXMLaxisGroup = function(root, id, name, values=NULL, label="", annotations=NULL, position=1) {
    annotation = .AddXMLaddAnnotation(root, position=position, id=id, kind="grouped")
    .AddXMLaddComponents(annotation, annotations)
    .AddXMLaddChildren(annotation, annotations)
    .AddXMLaddParents(annotation, annotations)
    XML::addAttributes(annotation$root, speech=paste(name, label),
                       speech2=paste(name, label, "with values from", values[1], "to", values[length(values)]),
                       type="Axis")
    annotation
}


## Aux methods for axes annotation.
##
## Axis labelling
.AddXMLaxisLabel = function(root, label="", position=1, id="", axis="") {
    annotation = .AddXMLaddAnnotation(root, position=position,
                                      id=.AddXMLmakeId(id, "1.1"), kind="active")
    XML::addAttributes(annotation$root, speech=paste("Label", label), type="Label")
    annotation
}

## Axis line
.AddXMLaxisLine = function(root, position=1, id="", axis="") {
    annotation = .AddXMLaddAnnotation(root, position=position,
                                      id=.AddXMLmakeId(id, "line", "1.1"), kind="passive")
    XML::addAttributes(annotation$root, type="Line")
    annotation
}

## Axis values and ticks
.AddXMLaxisValues = function(root, values=NULL, position=1, id="", axis="") {
    annotations <- list()
    for (i in 1:length(values)) {
        valueId = .AddXMLmakeId(id, "axis", "labels", paste("1.1", i, sep="."))
        value = .AddXMLaddAnnotation(root, position=position + i - 1,
                                     id=valueId, kind="active")
        XML::addAttributes(value$root, speech=paste("Value", values[i]), type="Value")
        
        tickId = .AddXMLmakeId(id, "axis", "ticks", paste("1.1", i, sep="."))
        tick = .AddXMLaddAnnotation(root, id=tickId, kind="passive")
        XML::addAttributes(tick$root, type="Tick")

        .AddXMLaddNode(value$component, "passive", tickId)
        .AddXMLaddNode(tick$component, "active", valueId)

        annotations[[2 * i - 1]] = value
        annotations[[2 * i]] = tick
    }
    annotations
}

## Constructs the center of the histogram 
.AddXMLaddHistogramCenter = function(root, mids=NULL, counts=NULL, density=NULL, breaks=NULL) {
    annotation = .AddXMLaddAnnotation(root, position=4, id="center", kind="grouped")
    XML::addAttributes(annotation$root, speech="Histogram bars",
                       speech2=paste("Histogram with", length(mids), "bars"),
                       type="Center")
    annotations <- list()
    for (i in 1:length(mids)) {
        annotations[[i]] = .AddXMLcenterBar(root, position=i, mid=mids[i],
                                            count=counts[i], density=density[i],
                                            start=breaks[i], end=breaks[i + 1])
    }
    .AddXMLaddComponents(annotation, annotations)
    .AddXMLaddChildren(annotation, annotations)
    .AddXMLaddParents(annotation, annotations)
    annotation
}


.AddXMLcenterBar = function(root, position=1, mid=NULL, count=NULL, density=NULL, start=NULL, end=NULL) {
    annotation = .AddXMLaddAnnotation(root, position=position,
                                      id=.AddXMLmakeId("rect", paste("1.1", position, sep=".")),
                                      kind="active")
    XML::addAttributes(annotation$root,
                       speech=paste("Bar", position, "at", mid, "with value", count),
                       speech2=paste("Bar", position, "between x values", start,
                                     "and", end, " with y value", count, "and density", density),
                       type="Bar")
    annotation
}


## Auxiliary methods for annotations
##
## Construct a gridSVG id.
.AddXMLmakeId = function(...) {
    paste("graphics-plot-1", ..., sep="-")
}

## Construct an SRE annotation element.
.AddXMLaddAnnotation = function(root, position=1, id="", kind="active") {
    annotation = .AddXMLaddNode(root, "annotation")
    element = .AddXMLaddNode(annotation, kind, id)
    ## This should be changed!
    node = list(root = annotation,
                element = element,
                position = .AddXMLaddNode(annotation, "position", content=position),
                parents = .AddXMLaddNode(annotation, "parents"),
                children = .AddXMLaddNode(annotation, "children"),
                component = .AddXMLaddNode(annotation, "component"),
                neighbours = .AddXMLaddNode(annotation, "neighbours"))
    .AddXMLstoreComponent(id, node)
    node
}

## Construct the basic XML annotation document.
.AddXMLdocument = function(tag = "histogram") {
    doc = XML::newXMLDoc()
    top = XML::newXMLNode(tag, doc = doc)
    XML::ensureNamespace(top, c(sre = "http://www.chemaccess.org/sre-schema"))
    doc
}

## Add a new node with tag name and optionally text content to the given root.
.AddXMLaddNode = function(root, tag, content="") {
    node = XML::newXMLNode(paste("sre:", tag, sep=""), parent = root)
    if (content != "") {
        XML::newXMLTextNode(content, parent=node)
    }
    node
}

# A shallow clone function for leaf nodes only. Avoids problems with duplicating
# namespaces.
.AddXMLclone = function(root, node) {
    newNode = XML::newXMLNode(XML::xmlName(node, full=TRUE), parent = root)
    XML::newXMLTextNode(XML::xmlValue(node), parent=newNode)
    newNode
}

## Add components to an annotation
.AddXMLaddComponents = function(annotation, nodes) {
    clone <- function(x) if (XML::xmlName(x$element) != "grouped") {
                             .AddXMLclone(annotation$component, x$element)   
                         }
    lapply(nodes, clone)
}

## Add children to an annotation
.AddXMLaddChildren = function(annotation, nodes) {
    clone <- function(x) if (XML::xmlName(x$element) != "passive") {
                             .AddXMLclone(annotation$children, x$element)   
                         }
    lapply(nodes, clone)
}


## Add parent to an annotations
.AddXMLaddParents = function(parent, nodes) {
    clone <- function(x) .AddXMLclone(x$parents, parent$element)
    lapply(nodes, clone)
}


## Store components for top level Element
.AddXMLcomponents = list()

.AddXMLstoreComponent = function(id, element) {
    .AddXMLcomponents[[id]] <<- element
}

.AddXMLaddChart = function(root, children=NULL, speech="", speech2="", type="") {
    annotation = .AddXMLaddAnnotation(root, id="chart", kind="grouped")
    XML::addAttributes(annotation$root, speech=speech, speech2=speech2, type=type)
    print(.AddXMLcomponents)
    .AddXMLaddComponents(annotation, .AddXMLcomponents)
    .AddXMLaddChildren(annotation, children)
    .AddXMLaddParents(annotation, children)
    annotation
}

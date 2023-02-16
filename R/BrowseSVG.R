# Currently only supports working the current directory.
BrowseSVG <- function(file = "test", key = TRUE, footer = TRUE, view = interactive(), ggplot_object = NULL) {
  # Required file for correct execution
  xmlFileName <- paste0(file, ".xml")
  svgFileName <- paste0(file, ".svg")

  if (!(file.exists(xmlFileName) && file.exists(svgFileName))) {
    warning("You do not have both a svg and xml file in current wd. Please create these with SVGThis()/AddXML() or use MakeAccessibleSVG()")
    return(invisible())
  }

  # Read and clean xml file
  xmlString <- xmlFileName |>
    readLines() |>
    gsub("sre:", "", x = _) |>
    gsub(" *<[a-zA-Z]+/>", "", x = _)

  # Read svg file
  svgString <- svgFileName |>
    readLines()

  # Add Describe and VI
  # Some formatting is to be done to make it work with the templates
  if (!is.null(ggplot_object)) {
    # Get the Describe output
    Description <- Describe(ggplot_object, whichLayer = "all")
    if (isa(Description, "multiDescription")) {
      Description <- unclass(Description)
      Description <- lapply(seq_along(Description), function(i) {
        Description[[i]]$name <- names(Description)[[i]]
        Description[[i]]
      })
    } else {
      Description <- unclass(Description)
    }

    # setNames(rep(NULL, length(length(ggplot_object$layers))))
    # Get the VI output
    VI <- VI(ggplot_object)
    # Need to make a list with names to get mustache list looping working.
    VI.text <- as.list(VI$text) |>
      stats::setNames(rep("text", length(VI$text)))
  } else {
    VI.text <- Description <- NULL
  }


  # Whiskers prep and rendering
  data <- list(
    xml = xmlString,
    svg = svgString,
    footer = footer,
    key = key,
    title = file,
    description = Description,
    has_description = !is.null(Description),
    vi = VI.text
  )

  htmlTemplate <- system.file("whisker/SVG/template.html", package = "BrailleR") |>
    readLines()

  renderedText <- whisker.render(htmlTemplate, data = data) |>
    # Remove commas that are added to the data instead of new lines.
    gsub("(> *)(,)( *<)", "\\1\n\\3", x = _) |> # In SVG and XML
    gsub("(\\.)(,)", "\\1<br>", x = _) # In the VI and the Describe

  # Write the rendered text to html file
  fileName <- paste0(file, ".html")
  writeLines(renderedText, con = paste0(file, ".html"))
  close(file(fileName))

  if (view) {
    browseURL(fileName)
  }
}

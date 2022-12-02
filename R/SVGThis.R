
# this file is only for the SVGThis method and associated utility functions.
# SVGThis.default() needs interactive session but specific methods need not be

# this from Paul via maps example
## chekc it is not already incorporated into new version of gridSVG.
.addInfo <- function(name, title, desc) {
  grid::grid.set(
      name,
      grid::gTree(
          children = grid::gList(
              elementGrob("title", children = grid::gList(textNodeGrob(title))),
              elementGrob("desc", children = grid::gList(textNodeGrob(desc))),
              grid::grid.get(name)), name = name), redraw = FALSE)
}

# next is partly from Paul via maps example, with additions from Jonathan
.MakeTigerReady =
    function(svgfile) {  # for alterations needed on all SVG files
      if (file.exists(svgfile)) {
        cat("\n", file = svgfile, append = TRUE)  # otherwise warnings returned
                                                  # on readLines() below
        temp <- readLines(con = svgfile)
        writeLines(gsub("ISO8859-1", "ASCII", temp), con = svgfile)
      } else {
        .FileDoesNotExist(svgfile)
      }
      return(invisible(NULL))
    }

# method is mostly Jonathan's use of Paul/Simon's work
SVGThis = function(x, file = "test.svg", ...) {
            UseMethod("SVGThis")
          }

SVGThis.default =
    function(x, file = "test.svg", ...) {
      if (is.null(x)) {  # must be running interactively
        if (dev.cur() > 1) {  # there must also be an open graphics/grid device

          if (length(grid::grid.ls(print = FALSE)$name) == 0) {  # if not grid
                                                                 # already, then
                                                                 # convert
            gridGraphics::grid.echo()
          }

          # then export to SVG
          gridSVG::grid.export(name = file)
          .MakeTigerReady(svgfile = file)
          # no specific processing to be done in this function.
        }  # end open device condition
            else {  # no current device
          warning("There is no current graphics device to convert to SVG.\n")
        }
      }  # end interactive condition
          else {  # not interactive session
        warning(
            "The default SVGThis() method only works for objects of specific classes.\nThe object supplied does not yet have a method written for it.\n")
      }
      return(invisible(NULL))
    }

SVGThis.boxplot =
    function(x, file = "test.svg", ...) {
      # really should check that the boxplot wasn't plotted already before...
      # but simpler to just do the plotting ourselves and close the device later
      x  # ensure we create a boxplot on a new graphics device
      gridGraphics::grid.echo()  # boxplot() currently uses graphics package
      gridSVG::grid.export(name = file)
      dev.off()  # remove our graph window
      .MakeTigerReady(svgfile = file)
      return(invisible(NULL))
    }

SVGThis.dotplot =
    function(x, file = "test.svg", ...) {
      # really should check that the dotplot wasn't plotted already before...
      # but simpler to just do the plotting ourselves and close the device later
      x  # ensure we create a dotplot on a new graphics device
      gridGraphics::grid.echo()  # dotplot() currently uses graphics package
      gridSVG::grid.export(name = file)
      dev.off()  # remove our graph window
      .MakeTigerReady(svgfile = file)
      return(invisible(NULL))
    }

SVGThis.eulerr = 
    function(x, file = "test.svg", ...) {
      x=Augment(x)
      X = stats::coef(x)[, 1L]
      Y = stats::coef(x)[, 2L]
      R = stats::coef(x)[, 3L]
      Labels = rownames(x$coefficients)
      TextX = x$TextPositions$x
      TextY = x$TextPositions$y

      pushViewport(dataViewport(c(X-R, X+R), c(Y-R, Y+R))) 
      grid.circle(X, Y, R, default.units="native", name="VennCircles") 
      grid.text(Labels, TextX, TextY, default.units="native",           name="VennLabels")

      gridSVG::grid.export(name = file)
      dev.off()

      .MakeTigerReady(svgfile = file)
      return(invisible(NULL))
    }

# if createDevice is TRUE (the default) SVGThis will create its own
# (non-displaying) graphics device and destroy it when complete
# if FALSE it will use the currently active device
SVGThis.ggplot =
    function(x, file = "test.svg", createDevice = TRUE, ...) {
#      x=Augment(x)
#      grid.force()
      if (createDevice) 
        pdf(NULL)
      print(x)
      gridSVG::grid.export(name = file)
      if (createDevice) 
        dev.off()
      .MakeTigerReady(svgfile = file)
      return(invisible(NULL))
    }


SVGThis.histogram =
    function(x, file = "test.svg", ...) {
      # really should check that the histogram wasn't plotted already before...
      # but simpler to just do the plotting ourselves and close the device later
      x  # ensure we create a histogram on a new graphics device
      gridGraphics::grid.echo()  # hist() currently uses graphics package
      # use gridSVG ideas in here
      gridSVG::grid.garnish(
          "graphics-plot-1-bottom-axis-line-1", title = "the x axis")
      gridSVG::grid.garnish(
          "graphics-plot-1-left-axis-line-1", title = "the y axis")
      # these titles are included in the <g> tag not a <title> tag
      .addInfo("graphics-plot-1-bottom-axis-line-1", title = "the x axis",
              desc = "need something much smarter in here")
      .addInfo("graphics-plot-1-left-axis-line-1", title = "the y axis",
              desc = "need something much smarter in here")
#.SVGThisBase(x)
      # add class-specific content to svg file from here onwards
      # short descriptions should be automatic, such as axis labels or marks
      # long descriptions need to be constructed, such as describe all axis marks together
      # find some way to embed the object from which the graph was created
      gridSVG::grid.export(name = file)
      dev.off()  # remove our graph window
      .MakeTigerReady(svgfile = file)
      return(invisible(NULL))
    }

.SVGThisBase = function(x){
      # use gridSVG ideas in here
      gridSVG::grid.garnish(
          "graphics-plot-1-bottom-axis-line-1", title = "the x axis")
      gridSVG::grid.garnish(
          "graphics-plot-1-left-axis-line-1", title = "the y axis")
      # these titles are included in the <g> tag not a <title> tag
      .addInfo("graphics-plot-1-bottom-axis-line-1", title = "the x axis",
              desc = "need something much smarter in here")
      .addInfo("graphics-plot-1-left-axis-line-1", title = "the y axis",
              desc = "need something much smarter in here")
}

SVGThis.scatterplot = function(x, file = "test.svg", ...) {
x$x= x$data$x
x$y = x$data$y
x$data=NULL
      suppressWarnings(do.call(plot, x))  # ensure we create a plot on a new graphics device
      gridGraphics::grid.echo()  # plot() uses graphics package
      gridSVG::grid.export(name = file)
      dev.off()  # remove our graph window
      .MakeTigerReady(svgfile = file)
      .FileCreated(file)
      return(invisible(NULL))
}

SVGThis.tsplot = function(x, file = "test.svg", ...) {
      suppressWarnings(do.call(plot, x))  # ensure we create a plot on a new graphics device
      gridGraphics::grid.echo()  # plot() uses graphics package
      gridSVG::grid.export(name = file)
      dev.off()  # remove our graph window
      .MakeTigerReady(svgfile = file)
      .FileCreated(file)
      return(invisible(NULL))
}

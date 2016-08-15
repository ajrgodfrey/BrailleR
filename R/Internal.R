FindCSSFile =
    function(file) {
      out = NULL
      if (file.exists(paste0(getOption("BrailleR.Folder"), "/css/", file))) {
        out = normalizePath(paste0(getOption("BrailleR.Folder"), "/css/", file))
      }
      if (file.exists(file)) {
        out = file
      }
      return(out)
    }


GetAxisTicks =
    function(x) {
      A = x[1]
      B = x[2]
      Ticks = x[3]
      paste(paste0(seq(A, B - Ticks, (B - A) / Ticks), ",", collapse = " "),
            "and", B, collapse = " ")
    }


InQuotes = function(x) {
             Out = paste0('"', x, '"')
           }


### from examples for toupper() with slight alteration to allow for BrailleR options.
.simpleCap <- function(x) {
  if (getOption("BrailleR.MakeUpper")) {
    s <- strsplit(x, " ")[[1]]
    out = paste0(toupper(substring(s, 1, 1)), substring(s, 2))
  } else {
    out = x
  }
  return(out)
}

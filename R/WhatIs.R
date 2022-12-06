## N.B. The first function was created before glimpse() was working nicely for a screen reader user; 
## it is somewhat redundant now, but kept for backwards compatibility

check_it = CheckIt = function(x, ...){
    dplyr::glimpse(x)
    return(x)
}


what_is = WhatIs = function(x, ...){
cat("\n")
VI(x, ...)
cat("\n")
return(    invisible(x))
}

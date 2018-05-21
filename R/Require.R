#' @rdname Require
#' @title Load a package by installing it if necessary
#' @aliases Require
#' @description It is easier to run a script if we know the necessary packages will be installed if they are not already. Installation uses the RStudio mirror of CRAN. 
#' @return logical: to say that the package has been successfully loaded (invisible)
#' @seealso require from the base package
#' @author Jonathan Godfrey
#' @export Require
#' @param pkg the package to be loaded.

Require = function(pkg){
pkg=deparse(substitute(pkg))
if(!base::require(pkg)){
utils::chooseCRANmirror(ind=1)
utils::install.packages(InQuotes(pkg))
}
base::require(pkg)
}


Require = function(pkg){
pkg = as.character(substitute(pkg))
if(!base::require(pkg, character.only=TRUE, warn.conflicts=FALSE)){
utils::chooseCRANmirror(ind=1)
utils::install.packages(pkg)
}
suppressPackageStartupMessages(base::require(pkg, character.only=TRUE, warn.conflicts=FALSE))
}

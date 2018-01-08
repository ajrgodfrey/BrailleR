for(pkg in pkgList){
if(!do.call(require, list(pkg))) install.packages(pkg)
do.call(library, list(pkg))
}

MakeSlideShow = function(Folder, Style = getOption("BrailleR.SlidesCSS"), ContentsSlide = FALSE){
if(dir.exists(Folder)){
# find the CSS file wanted.
StyleUsed=NULL
if(file.exists(Style)){StyleUsed=Style}
if(file.exists(paste0("./",Folder,"/",Style))){StyleUsed=paste0("./",Folder,"/",Style)}

if(!is.null(StyleUsed)){
# get lists of master slides and output slides
MasterSlideSet=list.files(path="slides", pattern="Rmd", full.names=TRUE)
SlideSet=gsub("slides/", "", MasterSlideSet)
OutSet=gsub(".Rmd", ".html", SlideSet)
# make temporary copy of slides
file.copy(from=MasterSlideSet, to=SlideSet, overwrite=TRUE)

if(ContentsSlide){
for(i in SlideSet){ # add contents link
}
}

for(i in 2:length(SlideSet)){ #  add back link
    cat(paste0("\n\n[back](", OutSet[i-1], ")"), file=SlideSet[i], append=TRUE)}
for(i in 1:(length(SlideSet)-1)){ # add next link
    cat(paste0(" [next](", OutSet[i+1], ")"), file=SlideSet[i], append=TRUE)}

for(i in SlideSet){
knit2html(i, stylesheet= StyleUsed)
# remove temporary files
file.remove(sub(".Rmd", ".md", i))
file.remove(i)
}

}# end css file condition
else{warning("Cannot find the specified css file.")}
} # end folder existence condition
else{warning("Specified folder does not exist. No action taken.")}
return(invisible(NULL))
}

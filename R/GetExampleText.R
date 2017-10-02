GetExampleText =
function (topic, package = NULL, lib.loc = NULL, character.only = FALSE, 
    outFile = "") 
{
    if (!character.only) {
        topic <- substitute(topic)
        if (!is.character(topic)) 
            topic <- deparse(topic)[1L]
    }


    pkgpaths <- find.package(package, lib.loc, verbose =  FALSE)

    NS <- getNamespace("utils")
    index.search <- get("index.search", NS)
    .getHelpFile <- get(".getHelpFile", NS)

    file <- index.search(topic, pkgpaths, TRUE)
    if (!length(file)) {
        warning(gettextf("no help found for %s", sQuote(topic)), 
            domain = NA)
        return(invisible())
    }

    packagePath <- dirname(dirname(file))
    pkgname <- basename(packagePath)
    lib <- dirname(packagePath)


    if(outFile=="") outFile = tempfile("Rex")
    tools::Rd2ex(.getHelpFile(file), outFile, commentDontrun = TRUE, 
        commentDonttest = TRUE)

    if (!file.exists(outFile)) {
        warning(gettextf("%s has a help file but no examples", 
            sQuote(topic)), domain = NA)
        return(invisible())
    }
ExLines = readLines(outFile)
headerEnds = which(ExLines=="### ** Examples")
return(ExLines[-c(1:headerEnds)])
}


# as supplied by Duncan Murdoch
# is pretty much the utils::history with use of file.edit() at the end.

history = function (max.show = 25, reverse = FALSE, pattern, ...) {
    file1 <- tempfile("Rrawhist")
    savehistory(file1)
    rawhist <- readLines(file1)
    unlink(file1)
    if (!missing(pattern))
        rawhist <- unique(grep(pattern, rawhist, value = TRUE,
            ...))
    nlines <- length(rawhist)
    if (nlines) {
        inds <- max(1, nlines - max.show):nlines
        if (reverse)
            inds <- rev(inds)
    }
    else inds <- integer()
    file2 <- tempfile("hist")
    writeLines(rawhist[inds], file2)
    file.edit(file2)
}

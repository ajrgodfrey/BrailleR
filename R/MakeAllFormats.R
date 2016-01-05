

#' @rdname MakeAllFormats
#' @title Prepare the options for conversion of an R markdown file.
#' @aliases MakeAllFormats
#' @description  Make a pandoc options file for use with a named R markdown file.
#' @details The options are based on the current best set of possible outcomes. The two html file options use different representations of any mathematical equations. The Microsoft Word file uses the native equation format which is not accessible for blind people using screen readers.
#' @return Nothing in the R console/terminal. The function is used for its side effects in the working directory.
#' @author A. Jonathan R. Godfrey.

#' @export MakeAllFormats
#' @param RmdFile The name of the R markdown file to be converted.
#' @param BibFile Name of the bibtex database file to include.
MakeAllFormats = function(RmdFile, BibFile="")
{
Settings=readLines(system.file("Foo.pandoc", package="BrailleR"))

FullFile=unlist(strsplit(RmdFile, split=".", fixed=TRUE))[1]
# switch foo.bib to BibFile
Settings=gsub("foo.bib", BibFile, Settings)

# switch all Foo to RmdFile stem
Settings=gsub("foo", FullFile, Settings)
writeLines(Settings, con = paste0(FullFile, ".pandoc"))
}

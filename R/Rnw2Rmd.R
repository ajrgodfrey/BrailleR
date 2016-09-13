Rnw2Rmd = function(file){
FindReplace(file, "<<>>=", "```{r}")
FindReplace(file, "<<", "```{r ")
FindReplace(file, "@", "```")
FindReplace(file, ">>=", "}")
FindReplace(file, "\\Sexpr{", "`{r ")
FindReplace(file, "results=hide", 'results="hide"')
FindReplace(file, "\\title{", "# ")
FindReplace(file, "\\author{", "### ")
FindReplace(file, "\\section{", "## ")
FindReplace(file, "\\subsection{", "### ")
FindReplace(file, "\\maketitle", "")
FindReplace(file, "\\begin{document}", "")
FindReplace(file, "\\ ", " ")
FindReplace(file, "\\end{document}", "")
FindReplace(file, "\\begin{equation}", "\n$$")
FindReplace(file, "\\end{equation}", "$$\n")
FindReplace(file, "\\today", "")
FindReplace(file, "\\date{}", "")
FindReplace(file, "\\cite{", "@")
# clean out excessive blank lines from the end.
Txt = readLines(file)
NoLines=length(Txt)
while(all(Txt[(NoLines-1):NoLines] == "")) {NoLines=NoLines-1}
writeLines(Txt[1:NoLines], con=file)
return(invisible(NULL))
}


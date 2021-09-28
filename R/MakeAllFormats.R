
MakeAllFormats =
    function(RmdFile, BibFile = "") {
      Settings = readLines(system.file("Foo.pandoc", package = "BrailleR"))

      FullFile = unlist(strsplit(RmdFile, split = ".", fixed = TRUE))[1]
      # switch foo.bib to BibFile
      Settings = gsub("foo.bib", BibFile, Settings)

      # switch all Foo to RmdFile stem
      Settings = gsub("foo", FullFile, Settings)
      writeLines(Settings, con = paste0(FullFile, ".pandoc"))
    }

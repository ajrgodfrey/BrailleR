.CheckForPython27 = # ripe for removal
    function(){
    PyPath = Sys.which("python")
    }


.AddHeadingTags =
    function(htmlfile, outfile=htmlfile, LowestHeadingLevel){
      InFile = readLines(htmlfile)
      TagDetails = .FindHeadingSizes(htmlfile)
      for(i in 1:min(length(TagDetails$Sizes), LowestHeadingLevel)){
cat("Font size", TagDetails$Sizes[i], "being turned into", TagDetails$HeadingTags[i], "\n")
        TempText = gsub(paste0('(.*)font-size:', TagDetails $Sizes[i], 'px">(.*)'), 
            paste0("\\1font-size:", TagDetails$Sizes[i], 'px"><', TagDetails$HeadingTags[i], ">\\2</",
            TagDetails$HeadingTags[i], ">"), InFile)
        InFile = TempText
      }
      writeLines(TempText, outfile)
    }

.FindHeadingSizes =
    function(htmlfile){
      InFile = readLines(htmlfile)
      tempText = gsub("(.*)font-size:([0-9]+)px(.*)", "\\2", InFile)
      TextSize = suppressWarnings(as.integer(tempText))
    TextSize[1]=0
      for(i in 2:length(TextSize)){
        TextSize[i] = ifelse(is.na(TextSize[i]), TextSize[i-1], TextSize[i])
      }
      SizeFreqs = tapply(TextSize,TextSize,length)
      BodySize = as.integer(names(SizeFreqs)[which.max(SizeFreqs)])
      SizesUsed = as.integer(names(SizeFreqs))
      HSizes = SizesUsed[SizesUsed > BodySize] 
      return(list(Sizes = sort(HSizes, TRUE), HeadingTags = paste0("h", 1:length(HSizes))))
    }

.DoubleGrave2LeftQuote  =
    function(htmlfile, outfile=htmlfile){
      InFile = readLines(htmlfile)
      tempText = gsub("(.*)``(.*)", '\\1"\\2', InFile)
      writeLines(tempText, outfile)
    }

.AddParagraphTagsBetweenDivs =
    function(htmlfile, outfile=htmlfile){
      InFile = readLines(htmlfile)
      tempText = gsub("(.*)</div><div(.*)", "\\1</div><p><div\\2", InFile)
      writeLines(tempText, outfile)
    }

.PageNumbers2Headings =
    function(htmlfile, outfile=htmlfile, HeadingTag="h6"){
      InFile = readLines(htmlfile)
      tempText = gsub("(.*)Page ([0-9]+)</a>(.*)", paste0("\\1<", HeadingTag, ">Page \\2</", HeadingTag, "></a>\\3"), InFile)
      writeLines(tempText, outfile)
    }


.FindLastPage =
    function(htmlfile){
    ReadIn = readLines(htmlfile)
    NLines=length(ReadIn)
    PageHooks = ReadIn[NLines-1]
    SepPageHooks = unlist(strsplit(PageHooks, '">'))
NSepPageHooks = length(SepPageHooks )
LastPageNo = as.integer(unlist(strsplit(SepPageHooks[NSepPageHooks], "</a>"))[1])
return(LastPageNo)
}

.RemoveLigatures =
    function(infile, outfile=infile){
            shell(paste0('python "', file.path(system.file(
                            "Python/latin2html.py", package = "BrailleR")),
 '" "', infile, '" > "', outfile, '"'))
      return(invisible(NULL))
    }

.PullPDFMinerUsingPip = 
    function(){
      if(shell('python -c "import pdfminer"')==0){
        system("pip install -U pdfminer")
      } else {
        system("pip install pdfminer")
      }
      return(invisible(TRUE))
    }



.IsPDFMinerAvailable =
    function(){
      Success = FALSE
      ifTestPython() && shell('python -c "import pdfminer"')==0){
        Success = TRUE
      }else{
        if(TestPython()){
          Success = .PullPDFMinerUsingPip()
        }else{
          warning("This function requires installation of Python.\n")
message("You can install Python with the GetPython3() function.\n")
        }
      }
      return(invisible(Success))
    }


pdf2html =
    function(pdffile, htmlfile=sub(".pdf", ".html", pdffile), HeadingLevels=4, PageTag="h6"){
      Success = FALSE
      if (.IsPDFMinerAvailable()) {
        shell(paste("pdf2txt.py -O TempDir -o tempfile.html -t html", pdffile))
        .RemoveLigatures("tempfile.html", htmlfile)
        file.remove("tempfile.html")
.AddHeadingTags(htmlfile, LowestHeadingLevel=HeadingLevels)
.PageNumbers2Headings(htmlfile, outfile=htmlfile, HeadingTag=PageTag)
        Success = TRUE
      } else {
        warning("There was a problem and no conversion was possible.\n")
      }
      return(invisible(Success))
    }

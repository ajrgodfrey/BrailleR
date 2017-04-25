
.BoxplotText = function(fivenum, outliers=NULL, horizontal=FALSE){
Outs=length(outliers)
TextOuts = ifelse(Outs==0, "no", as.character(Outs))
ShortText = paste("Min", fivenum[1], "Lower quartile", fivenum[2], "Median", fivenum[3], "Upper quartile", fivenum[4], "Max", fivenum[5], "with", TextOuts, ifelse(Outs==1, "outlier.", "outliers."))

Text1 = Text2 = Text3 = Text4 = Text5 = Text6 = ""

        if (Outs>0) {
          Text1 = paste(ifelse(Outs==1, "An outlier is", "Outliers are"), 'marked at:', outliers)
        } else{
          Text1 = "no outliers"
        }
        Text2 = paste('The whiskers extend to', fivenum[1], 'and', fivenum[5],
            'from the ends of the box, \nwhich are at', fivenum[2], 'and',
            fivenum[4], '\n')
        BoxLength = fivenum[4] - fivenum[2]
        Text3 = paste('The median,', fivenum[3], 'is',
            round(100 * (fivenum[3] - fivenum[2]) / BoxLength, 0),
            '% from the', ifelse(horizontal, 'left', 'lower'),
            'end of the box to the', ifelse(horizontal, 'right', 'upper'),
            'end.\n')
        Text4 = paste('The', ifelse(horizontal, 'right', 'upper'), 'whisker is',
            round((fivenum[5] -
                   fivenum[4]) / (fivenum[2] - fivenum[1]), 2),
            'times the length of the', ifelse(horizontal, 'left', 'lower'),
            'whisker.\n')

 LongText = c(Text1, Text2, Text3, Text4) 
return(invisible(list(Short=ShortText, Long=LongText)))
}

.GetAxisTicks =
    function(x) {
      A = x[1]
      B = x[2]
      Ticks = x[3]
      paste(paste0(seq(A, B - Ticks, (B - A) / Ticks), ",", collapse = " "),
            "and", B, collapse = " ")
    }


.ScatterPlotText = function(x, MedianX=x$GroupSummaries$MedianX, MedianY=x$GroupSummaries$MedianY, MeanX=x$GroupSummaries$MeanX, MeanY=x$GroupSummaries$MeanY, MinX=x$GroupSummaries$MinX, MinY=x$GroupSummaries$MinY, MaxX=x$GroupSummaries$MaxX, MaxY=x$GroupSummaries$MaxY, SDX=x$GroupSummaries$SDX, SDY=x$GroupSummaries$SDY, CorXY=x$GroupSummaries$CorXY, N=x$GroupSummaries$N){

ShortText = paste("Around X=", MedianX, "there are", N, "y values with median =", MedianY, "over the range", MinY, "to", MaxY)
LongText = paste("X=", MedianX, "has y values with median =", MedianY, "over the range", MinY, "to", MaxY, "; the values have a correlation of", CorXY)
return(invisible(list(Short=ShortText, Long=LongText)))
}


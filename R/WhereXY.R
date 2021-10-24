WhereXY =
    function(x, y = NULL, grid = c(4, 4), xDist = "uniform", yDist = xDist,
             addmargins = TRUE) {

      if (is.null(y)) {
        x = as.matrix(x)
        if (length(x[1, ]) != 2) {
          .NoYNeeds2X() 
        }
        y = x[, 2]
        if (!is.numeric(y)) {
          .XOrYNotNumeric(which="y")
        }
        x = x[, 1]
        if (!is.numeric(x)) {
          .XOrYNotNumeric(which="x")
        }
      }
      XMin = min(x, na.rm = TRUE)
      YMin = min(y, na.rm = TRUE)
      XMax = max(x, na.rm = TRUE)
      YMax = max(y, na.rm = TRUE)
      XRange = XMax - XMin
      YRange = YMax - YMin

      if (xDist == "uniform") {
        XNew = cut(x, breaks = grid[1], labels = FALSE)
      } else {
        XMean = mean(x, na.rm = TRUE)
        XSD = sd(x, na.rm = TRUE)
        XBreaks = c((1 - 0.1 * sign(XMin)) * XMin,
                    XMean + XSD * qnorm((1:(grid[1] - 1)) / grid[1]),
                    (1 + 0.1 * sign(XMax)) * XMax)
        XNew = cut(x, breaks = XBreaks, labels = FALSE)
      }

      if (yDist == "uniform") {
        #YBreaks <- seq(YMax+0.001*YRange,YMin-0.001*YRange, length.out=grid[2]+1)
        YNew = cut(y, breaks = grid[2], labels = FALSE)
      } #cut(y,breaks=YBreaks, labels=FALSE)}
        else {
        YMean = mean(y, na.rm = TRUE)
        YSD = sd(y, na.rm = TRUE)
        YBreaks = c((1 - 0.1 * sign(YMin)) * YMin,
                    YMean + YSD * qnorm((1:(grid[2] - 1)) / grid[2]),
                    (1 + 0.1 * sign(YMax)) * YMax)
        YNew = cut(y, breaks = YBreaks, labels = FALSE)
      }

      XNew <- factor(XNew, levels = c(1:grid[1]))
      YNew <- factor(YNew, levels = c(1:grid[2]))
      Output = tapply(x, list(YNew, XNew), length)
      Output[is.na(Output)] = 0
      Output = Output[rev(1:grid[2]), ]
      if (addmargins) {
        Output = addmargins(Output)
      }
      return(Output)
    }



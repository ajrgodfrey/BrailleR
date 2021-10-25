# still need to insert factor name in  error message; look for which


.BlankStop =     function() {
stop("\n")
return(invisible(NULL))
    }

.FactorNotFactor =     function(which=NULL) {
stop("The factor is not stored as a factor.\nTry using as.factor() on a copy of the data.frame.")
return(invisible(NULL))
    }

.GroupNotFactor =     function() {
stop("The group variable is not a factor.\nTry using as.factor() on a copy of the data.frame.")
return(invisible(NULL))
    }

.MissingFolder =     function() {
stop("Specified folder does not exist.\n")
return(invisible(NULL))
    }

.MissingMethod =     function() {
stop("Specified method is not yet available.\n")
return(invisible(NULL))
    }


.NoBrailleRFolder=     function() {
stop("No permanent MyBrailleR folder was found.\n Use `SetupBrailleR()` to fix this problem.")
return(invisible(NULL))
    }


.NoResponse =     function() {
stop("You must specify either the Response or the ResponseName.")
return(invisible(NULL))
    }


.NotADataFrame =     function() {
stop("The named dataset is not a data.frame.")
return(invisible(NULL))
    }


.NotAProperFileName =     function() {
stop('file must be a character string or connection')
return(invisible(NULL))
    }

.NotViewable =     function() {
stop("The named data is not a data.frame, matrix, or vector so cannot be viewed.")
return(invisible(NULL))
    }



.NoYNeeds2X =     function() {
stop("If y is not supplied, x must have two numeric columns")
return(invisible(NULL))
    }


.PredictorNotNumeric =     function() {
stop("The predictor variable is not numeric.")
return(invisible(NULL))
    }

.ResponseNotNumeric =     function() {
stop("The response variable is not numeric.")
return(invisible(NULL))
    }

.ResponseNotAVector =     function() {
stop("Input response is not a vector.")
return(invisible(NULL))
    }

.XOrYNotNumeric =     function(which="y") {
stop("The x or y variable is not numeric.")
return(invisible(NULL))
    }


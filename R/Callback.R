# with much help from Gabe Becker
BrailleR <- NULL


ShowMe <- function(file = NULL, n=1) {
      if (interactive()) {
if(is.null(file)){ file = paste0(tempfile(), ".txt")}
.SessionLogWorker(file = file, n=n) 
browseURL(file)
      } else {
        .InteractiveOnly()
      }
return(invisible(NULL))
}


GrabLast <- function(file = "", n=1) {
      if (interactive()) {
.SessionLogWorker(file = file, n=n) 
      } else {
        .InteractiveOnly()
      }
return(invisible(NULL))
}

SessionLog <- function(file = "", n=NULL) {
      if (interactive()) {
.SessionLogWorker(file = file, n=NULL) 
      } else {
        .InteractiveOnly()
      }
return(invisible(NULL))
}

.SessionLogWorker <- function(file = "", n=NULL) {
    df <- .get_session_log() 
if(!is.null(n)){
NRows = nrow(df)
df = df[(NRows+1-n): NRows, ]
}
    mapply(function(expr, pr) cat(c(paste(">", paste(expr, collapse = "\n")), pr, ""), sep = "\n", file = file),
           expr = df$expr,
           pr = df$pr_output)
    invisible(NULL)
}


.callback <- function(expr, value, success, printed, env) {
    if(!success)
        return(TRUE)

    if(printed)
        prout <- tryCatch(capture.output(print(value)), error = function(e) "error during callback")
    else
        prout <- ""
        rw <- data.frame(expr = I(list(deparse(expr))),
                         val_class = I(list(class(value))),
                         pr_output = I(list(prout)))
    if(exists("session_log", env))
        env$session_log <- c(env$session_log,list(rw))
    else
        env$session_log <- list(rw)
    TRUE
}


.get_session_log <- function() {
    do.call(rbind, BrailleR$session_log)
}



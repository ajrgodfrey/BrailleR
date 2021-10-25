.R2txt.vars <- new.env()

R2txt <- function(cmd, res, s, vis) {
  if (.R2txt.vars$first) {
    .R2txt.vars$first <- FALSE
    if (.R2txt.vars$res) {
      sink()
      close(.R2txt.vars$outcon)
      .R2txt.vars$outcon <- textConnection(NULL, open = 'w')
      sink(.R2txt.vars$outcon, split = TRUE)
    }
  } else {

    if (.R2txt.vars$cmd) {
      cmdline <- deparse(cmd)
      cmdline <- gsub(
          '    ', paste("\n", .R2txt.vars$continue, sep = ''), cmdline)
      cmdline <- gsub(
          '}', paste("\n", .R2txt.vars$continue, "}", sep = ''), cmdline)
      cat(.R2txt.vars$prompt, cmdline, "\n", sep = '', file = .R2txt.vars$con)
    }
    if (.R2txt.vars$cmdfile) {
      cmdline <- deparse(cmd)
      cmdline <- gsub('    ', "\n ", cmdline)
      cmdline <- gsub('}', "\n}", cmdline)
      cat(cmdline, "\n", file = .R2txt.vars$con2)
    }

    if (.R2txt.vars$res) {
      tmp <- textConnectionValue(.R2txt.vars$outcon)
      if (length(tmp)) {
        cat(tmp, sep = '\n', file = .R2txt.vars$con)
        sink()
        close(.R2txt.vars$outcon)
        .R2txt.vars$outcon <- textConnection(NULL, open = 'w')
        sink(.R2txt.vars$outcon, split = TRUE)
      }
    }
  }

  TRUE
}

txtStart <- function(file, commands = TRUE, results = TRUE, append = FALSE,
                     cmdfile, visible.only = TRUE) {

  tmp <- TRUE
  if (is.character(file)) {
    if (append) {
      con <- file(file, open = 'a')
    } else {
      con <- file(file, open = 'w')
    }
    tmp <- FALSE
  } else if (any(class(file) == 'connection')) {
    con <- file
  } else {
    .NotAProperFileName()  
  }
  if (tmp && isOpen(con)) {
    .R2txt.vars$closecon <- FALSE
  } else {
    .R2txt.vars$closecon <- TRUE
    if (tmp) {
      if (append) {
        open(con, open = 'a')
      } else {
        open(con, open = 'w')
      }
    }
  }
  .R2txt.vars$vis <- visible.only
  .R2txt.vars$cmd <- commands
  .R2txt.vars$res <- results
  .R2txt.vars$con <- con
  .R2txt.vars$first <- TRUE

  if (results) {
    .R2txt.vars$outcon <- textConnection(NULL, open = 'w')
    sink(.R2txt.vars$outcon, split = TRUE)
  }

  if (!missing(cmdfile)) {
    tmp <- TRUE
    if (is.character(cmdfile)) {
      con2 <- file(cmdfile, open = 'w')
      tmp <- FALSE
    } else if (any(class(cmdfile) == 'connection')) {
      con2 <- cmdfile
    }
    if (tmp && isOpen(con2)) {
      .R2txt.vars$closecon2 <- FALSE
    } else {
      .R2txt.vars$closecon2 <- TRUE
      if (tmp) {
        open(con2, open = 'w')
      }
    }
    .R2txt.vars$con2 <- con2
    .R2txt.vars$cmdfile <- TRUE
  } else {
    .R2txt.vars$cmdfile <- FALSE
  }

  .R2txt.vars$prompt <- unlist(options('prompt'))
  .R2txt.vars$continue <- unlist(options('continue'))

  options(prompt = paste('txt', .R2txt.vars$prompt, sep = ''),
          continue = paste('txt', .R2txt.vars$continue, sep = ''))

  message('Output being copied to text file,\nuse txtStop() to end.\n')
  addTaskCallback(R2txt, name = 'r2txt')
  invisible(NULL)
}

txtStop <- function() {
  removeTaskCallback('r2txt')
  if (.R2txt.vars$closecon) {
    close(.R2txt.vars$con)
  }
  if (.R2txt.vars$cmdfile && .R2txt.vars$closecon2) {
    close(.R2txt.vars$con2)
  }
  options(prompt = .R2txt.vars$prompt, continue = .R2txt.vars$continue)
  if (.R2txt.vars$res) {
    sink()
    close(.R2txt.vars$outcon)
  }
  evalq(rm(list = ls()), envir = .R2txt.vars)
  invisible(NULL)
}

txtComment <- function(txt, cmdtxt) {
  .R2txt.vars$first <- TRUE
  if (!missing(txt)) {
    cat("\n", txt, "\n\n", file = .R2txt.vars$con)
  }
  if (!missing(cmdtxt)) {
    cat("# ", cmdtxt, "\n", file = .R2txt.vars$con2)
  }
}

txtSkip <- function(expr) {
  .R2txt.vars$first <- TRUE
  expr
}




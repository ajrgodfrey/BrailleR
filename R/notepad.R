MyBrailleR = function(){
      if (interactive()) {
        if (.Platform$OS.type == "windows") {
          browseURL(getOption("BrailleR.Folder"))
        } else {
          .WindowsOnly()
        }
      } else {
        .InteractiveOnly()
      }
return(invisible(NULL))
}

Notepad = notepad = function(file=""){
      if (interactive()) {
        if (.Platform$OS.type == "windows") {
shell(paste('notepad', file), wait=FALSE)
        } else {
          .WindowsOnly()
        }
      } else {
        .InteractiveOnly()
      }
return(invisible(NULL))
}



Explorer = explorer = function(){
      if (interactive()) {
        if (.Platform$OS.type == "windows") {
shell('explorer "."', wait=FALSE)
        } else {
          .WindowsOnly()
        }
      } else {
        .InteractiveOnly()
      }
return(invisible(NULL))
}


CMD = cmd = function(){
      if (interactive()) {
        if (.Platform$OS.type == "windows") {
shell('cmd', wait=FALSE)
        } else {
          .WindowsOnly()
        }
      } else {
        .InteractiveOnly()
      }
return(invisible(NULL))
}



Notepad = notepad= function(file=""){
      if (interactive()) {
        if (.Platform$OS.type == "windows") {
shell(paste('notepad', file), wait=FALSE)
        } else {
          warning(
              "This function is for users running R under the Windows operating system.\n")
        }
      } else {
        warning("This function is meant for use in interactive mode only.\n")
      }
return(invisible(NULL))
}



Explorer = explorer = function(){
      if (interactive()) {
        if (.Platform$OS.type == "windows") {
shell('explorer "."', wait=FALSE)
        } else {
          warning(
              "This function is for users running R under the Windows operating system.\n")
        }
      } else {
        warning("This function is meant for use in interactive mode only.\n")
      }
return(invisible(NULL))
}


CMD = cmd = function(){
      if (interactive()) {
        if (.Platform$OS.type == "windows") {
shell('cmd', wait=FALSE)
        } else {
          warning(
              "This function is for users running R under the Windows operating system.\n")
        }
      } else {
        warning("This function is meant for use in interactive mode only.\n")
      }
return(invisible(NULL))
}


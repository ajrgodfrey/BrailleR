.FileCreated =     function(file=NULL) {
NewFile = ifelse(is.null(file), "", file)
message(NewFile, " has been created in your MyBrailleR directory.")
return(invisible(NULL))
    }


# getting some useful batch files for admin tasks
# Windows users only

MakeAdminBatch =
    function() {
      if (interactive()) {
        if (.Platform$OS.type == "windows") {
MyBrailleRFolder = .MyBrailleRName()
.MakeRBatch(MyBrailleRFolder)
.FileCreated("RBatch.bat")
.MakeRTerminal(MyBrailleRFolder)
.FileCreated("RTerminal.bat")
.MakeRenderAllMd(MyBrailleRFolder)
.FileCreated("RenderAllMD.bat")
.MakeRenderAllQmd(MyBrailleRFolder)
.FileCreated("RenderAllQmd.bat")
.MakeRenderAllRmd(MyBrailleRFolder)
.FileCreated("RenderAllRmd.bat")
.MakeUpdatePackages(MyBrailleRFolder) # needs commands
.MoveOntoPath()
.ConsultHelpPage()

        } else {
          .WindowsOnly()
        }
      } else {
        .InteractiveOnly()
      }
      return(invisible(NULL))
    }

.FindRInstallPathText = '@echo off
FOR /F "skip=2 tokens=2,*" %%A IN (\'reg.exe query "HKlm\\Software\\R-core\\r" /v "InstallPath"\') DO set "InstallPath=%%B"
\n'

.RFolderText = '"%InstallPath%\\bin\\x64\\'

.RTerminalText = paste0(.FindRInstallPathText, .RFolderText, 'rterm.exe" --save\n')
.RScriptText = paste0(.FindRInstallPathText, .RFolderText, 'rscript.exe"')
.RBatchText = paste0(.FindRInstallPathText, .RFolderText, 'r.exe" CMD BATCH --vanilla --quiet %1\n') 

.MakeRScriptBatch = function(commands="getRversion()", where=".",file="test.bat"){
.FullRScriptText = paste0(.RScriptText, ' -e "', commands, '"\n') 
cat(.FullRScriptText, file=paste0(where, "/", file))
      return(invisible(NULL))
}


.MakeRBatch = function(where="."){
cat(.RBatchText, file=paste0(where, "/RBatch.bat"))
      return(invisible(NULL))
}

.MakeRTerminal = function(where="."){
cat(.RTerminalText, file=paste0(where, "/RTerminal.bat"))
      return(invisible(NULL))
}



.MakeUpdatePackages = function(where="."){
UpdatePkgsComs = paste(readLines(system.file("Scripts/UpdatePackages.R", package = "BrailleR")), collapse=";")
.MakeRScriptBatch(commands=UpdatePkgsComs, where=where, file="UpdateRPackages.bat")
      return(invisible(NULL))
}

.MakeRenderAllMd = function(where="."){
cat(.RenderAllMdText, file=paste0(where, "/RenderAllMD.bat"))
      return(invisible(NULL))
}

.MakeRenderAllQmd = function(where="."){
cat(.RenderAllQmdText, file=paste0(where, "/RenderAllQmd.bat"))
      return(invisible(NULL))
}



.RenderAllQmdText = '@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
FOR %%f IN (*.Qmd) DO (
SET NewName=%%f
quarto render "!NewName!"
)\n'

.RenderAllMdText = '@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
FOR %%f IN (*.md) DO (
SET MDName=%%f
SET HTMLName=!MDName:.md=.html!
pandoc "!MDName!" -o "!HTMLName!"
)\n'


.MakeRenderAllRmd = function(where="."){
.MakeRScriptBatch(commands="BrailleR::ProcessAllRmd()", where=where, file="RenderAllRmd.bat")
      return(invisible(NULL))
}


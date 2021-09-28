\name{MakeBatch}
\alias{MakeBatch}
\title{Create batch files for processing R scripts and markdown files under Windows}
\description{Convenience function for creating batch files that can be used under Windows to process R scripts and Rmarkdown files. It may also be possible to  use them in conjunction with the  Open With dialogue in Windows Explorer; this makes use of file associations so that R scripts and Rmd files are (in effect) executable.}
\usage{
MakeBatch(file=NULL)
}
\arguments{
  \item{file}{A character string for the file to be processed. The file need not yet exist. The extension must be either R or Rmd and is case sensitive.}
}
\details{
These batch files are not for use in an R session. They do need to be created in an interactive session, so that users can process R scripts and Rmarkdown files without needing to open an R session later. 

If a file is specified, the function will create a single batch file that will process the file appropriately. Processing an R script will generate a Rout file, while an Rmd file is converted into HTML.

If no file is specified, the function creates various files in the current working directory. 

Files starting with the word test are for testing the batch files. An R script and an Rmarkdown file were created as well as the batch files that will process them into a Rout file and  an HTML document respectively. Pressing <enter> on these test*.bat files will process the test files appropriately.

The other three batch files (ending in .bat) need to be moved to a folder on the user's path so that they can be called from anywhere. They could also be manually edited to suit the user's needs.

The path.txt file shows the user what folders are already on the path list. The user can review this list and decide to alter the system variable if they so choose. The path.txt file has no value otherwise.}
\author{A. Jonathan R. Godfrey with testing by JooYoung Seo}
\section{Further instructions}{
Once the RBatch.bat file has been moved to the desired folder that is included in the path for your system you can follow the following steps to get this function working fully.

1. Open windows explorer, and browse to the folder containing the test files.

2. Select the test.R script.

3. Under the File menu, look for the item Open with... (This might already be a submenu for some users; if so, the last item is Choose default program.)

4. We are going to choose to use a program on our computer. Do not go looking on the internet to see which program we need.

5. You may be able to write  a description of the file type. This is an R script but it may not yet be registered as such. Providing this detail is optional.

6. When given the chance to browse for the program to open the test.R script, browse to the folder where you placed Rbatch.bat and select it.

7. When you select OK, the test.R script will be processed by RBatch.bat and a new file test.Rout will be created.

8. Open test.Rout in any text editor you like. This file has the appearance of an R session window except for some processing time detail at the end. You will be able to read the commands that were originally in test.R as well as the output from these commands.
}
\value{The names of created files.}

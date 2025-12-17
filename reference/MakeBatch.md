# Create batch files for processing R scripts and markdown files under Windows

Convenience function for creating batch files that can be used under
Windows to process R scripts, R markdown, and quarto files. The main
idea is that a user can click on the batch files within Windows Explorer
to get the desired task done faster.

## Usage

``` r
MakeBatch(file=NULL, static = FALSE)


MakeAdminBatch()
```

## Arguments

- file:

  A character string for the file to be processed. The file need not yet
  exist. The extension must be one of Qmd, R, or Rmd.

- static:

  Should a fixed version of R be used? It will be the current version if
  set to TRUE or allowed to vary with new installations.

## Details

These batch files are not for use in an R session. They do need to be
created in an interactive session though. They are to provide users a
means to process R scripts, quarto and Rmarkdown documents without
needing to open an R session thereafter.

If a file is specified, the function will create a single batch file
that will process the file appropriately. Processing an R script will
generate a Rout file, while an Rmd file is converted into HTML. Quarto
files are tied to two batch files; one renders the document and should
be used first, while the other is for the continuous previewing of the
document in a browser.

If no file is specified, the MakeBatch() function creates various files
in the current working directory to show how the tools can be used.

Files starting with the word test are for testing the batch files. An R
script and an Rmarkdown file were created as well as the batch files
that will process them into a Rout file and an HTML document
respectively. Pressing \<enter\> on these test\*.bat files will process
the test files appropriately.

The other three batch files (ending in .bat) and any created using
MakeAdminBatch() need to be moved to a folder on the user's path so that
they can be called from anywhere. They could also be manually edited to
suit the user's needs.

The path.txt file shows the user what folders are already on the path
list. The user can review this list and decide to alter the system
variable if they so choose. The path.txt file has no value otherwise.

## Author

A. Jonathan R. Godfrey with testing by JooYoung Seo

## Further instructions

Once the RBatch.bat file has been moved to the desired folder that is
included in the path for your system you can follow the steps below to
get full value from this functionality.

1\. Open windows explorer, and browse to the folder containing the test
files.

2\. Select the test.R script.

3\. Under the File menu, look for the item Open with... (This might
already be a submenu for some users; if so, the last item is Choose
default program.)

4\. We are going to choose to use a program on our computer. Do not go
looking on the internet to see which program we need.

5\. You may be able to write a description of the file type. This is an
R script but it may not yet be registered as such. Providing this detail
is optional.

6\. When given the chance to browse for the program to open the test.R
script, browse to the folder where you placed Rbatch.bat and select it.

7\. When you select OK, the test.R script will be processed by
RBatch.bat and a new file test.Rout will be created.

8\. Open test.Rout in any text editor you like. This file has the
appearance of an R session window except for some processing time detail
at the end. You will be able to read the commands that were originally
in test.R as well as the output from these commands.

## Value

NULL. The user is informed about the files that are created by way of
message().

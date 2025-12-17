# Save a transcript of commands and/or output to a text file.

These functions save a transcript of your commands and their output to a
script file.

They work as combinations of `sink` and `history` with a couple of extra
bells and whistles.

## Usage

``` r
txtStart(file, commands=TRUE, results=TRUE, append=FALSE, cmdfile,
          visible.only=TRUE)

txtOut(Filename=NULL)

txtStop()

txtComment(txt,cmdtxt)

txtSkip(expr)
```

## Arguments

- file:

  Text file to save transcript in

- Filename:

  A filename to be given for the `txtOut` command. If this is not
  specified, the user will be prompted for a filename. If the user
  presses the enter key, a filename will be automatically generated that
  is based on the current date and time.

- commands:

  Logical, should the commands be echoed to the transcript file

- results:

  Logical, should the results be saved in the transcript file

- append:

  Logical, should we append to `file` or replace it

- cmdfile:

  A filename to store commands such that it can be `source`d or copied
  and pasted from

- visible.only:

  Should non-printed output be included, not currently implemented.

- txt:

  Text of a comment to be inserted into `file`

- cmdtxt:

  Text of a comment to be inserted into `cmdfile`

- expr:

  An expression to be executed without being included in `file` or
  `cmdfile`

## Details

These functions are used to create transcript/command files of your R
session. In the original TeachingDemos package from which the functions
were obtained, there are 3 sets of functions. Those starting with
"txt",those starting with "etxt", and those starting with wdtxt.

The "txt" functions create a plain text transcript while the "etxt"
functions create a text file with extra escapes and commands so that it
can be post processed with enscript (an external program) to create a
postscript file and can include graphics as well. The postscript file
can be converted to pdf or other format file. The "wdtxt" functions will
insert the commands and results into a Microsoft Word document.

Users wishing to have the additional functionality that the "etxt" and
"wdtxt" functions provide are advised to make use of the TeachingDemos
package.

If `results` is TRUE and `commands` is FALSE then the result is similar
to the results of `sink`. If `commands` is true as well then the results
will show both the commands and results similar to the output on the
screen. If both `commands` and `results` are FALSE then pretty much the
only thing these functions will accomplish is to waste some computing
time.

If `cmdfile` is specified then an additional file is created with the
commands used (similar to the `history` command), this file can be used
with `source` or copied and pasted to the terminal.

The Start function specifies the file/directory to create and starts the
transcript, The prompts are changed to remind you that the
commands/results are being copied to the transcript. The Stop function
stops the recording and resets the prompts.

The txtOut function is a short cut for the txtStart command that uses
the current date and time in the filenames for the transcript and
command files. This function is not part of the TeachingDemos package.

The R parser strips comments and does some reformatting so the
transcript file may not match exactly with the terminal output. Use the
`txtComment` functions to add a comment. This will show up as a line
offset by whitespace in the transcript file. If `cmdtxt` is specified
then that line will be inserted into `cmdfile` preceded by a hash symbol
so it will be skipped if sourced or copied.

The `txtSkip` function will run the code in `expr` but will not include
the commands or results in the transcript file (this can be used for
side computations, or requests for help, etc.).

## Value

Most of these commands do not return anything of use. The exception is:

`txtSkip` returns the value of `expr`.

## Author

Greg Snow, <greg.snow@imail.org> is the original author, but Jonathan
Godfrey <a.j.godfrey@massey.ac.nz> is responsible for the implementation
in the BrailleR package (including the `txtOut()` function), and should
therefore be your first point of contact with any problems. If you find
the functions useful, you may wish to send a vote of thanks in Greg's
direction.

## Note

These commands do not do any fancy formatting of output, just what you
see in the regular terminal window. If you want more formatted output
then you should look into `Sweave` or the use of markdown documents..

Do not use these functions in combination with the R2HTML package or
`sink`.

## See also

[`sink`](https://rdrr.io/r/base/sink.html),
[`history`](http://ajrgodfrey.github.io/BrailleR/reference/history.md),
[`Sweave`](https://rdrr.io/r/utils/Sweave.html), the odfWeave package,
the R2HTML package, the R2wd package

## Examples

``` r
if (FALSE) { # \dontrun{
txtStart()
txtComment('This is todays transcript')
date()
x <- rnorm(25)
summary(x)
stem(x)
txtSkip(?hist)
hist(x)
Sys.Date()
Sys.time()
} # }
```

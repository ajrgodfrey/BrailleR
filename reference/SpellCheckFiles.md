# Spell checking a file or all files within a specified folder

Check spelling using hunspell. A new print method is also used.

## Usage

``` r
SpellCheckFiles(file = ".", ignore = character(), 
    local.ignore = TRUE, global.ignore = TRUE) 

# S3 method for class 'wordlist'
print(x, ...)
```

## Arguments

- file:

  The filename of an individual file, or an individual folder.

- ignore:

  The character vector of words to be ignored by hunspell

- local.ignore:

  Use a local file of words to be ignored. This file has the same name
  as the file with .ignore.txt tacked on the end and is colocated with
  the file being checked. If the file argument is set to a folder then
  the local.ignore can be set to the name of a file in the current
  working directory.

- global.ignore:

  Use the global word list called words.ignore.txt found in the
  MyBrailleR folder

- x:

  the object to be printed

- ...:

  other parameters pass to the print method

## Value

A list object with each item of the list being the findings from spell
checking each file. The words not found in the dictionary are given as
well as the line numbers where they were found.

## Details

The global list of words to be ignored needs to be saved in the user's
MyBrailleR folder. It can be updated as often as the user likes. It
should have one word per line, and contain no space, tab or punctuation
characters.

## Author

A. Jonathan R. Godfrey wrote these functions but leaned heavily on
functions found in the devtools package.

## See also

The hunspell package and functions therein.

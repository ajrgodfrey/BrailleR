# Open standard Windows tools quickly

Many standard Windows tools can be opened from the Run dialogue, but
this starts them in the standard locations, when R users may want them
opened or saved in the current working directory.

## Usage

``` r
Notepad(file = "")
```

## Arguments

- file:

  A character string for the file to be opened; it will be created if it
  does not yet exist.

## Value

NULL. The functions are for their external effects only. Control is
still available in the R console/terminal.

## Details

If a file specified does not yet exist in the current folder, the
standard notepad editor asks the user if a new file is wanted.

## Author

A. Jonathan R. Godfrey

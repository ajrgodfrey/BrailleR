# Create a template for a new function

An R script for a new function is created in the working directory. It
includes Roxygen commented lines for the documentation with sensible
defaults where possible.

## Usage

``` r
NewFunction(FunctionName, args = NULL, NArgs = 0)
```

## Arguments

- FunctionName:

  The name of the function and file to create.

- args:

  a vector of argument names

- NArgs:

  an integer number of arguments to assign to the function.

## Details

A file is saved in the current working directory that has a template for
a function with a set of arguments (if supplied). The file still needs
serious editing before insertion into a package.

## Value

No objects are created in the workspace. The only outcome is the
template file and a message to let the user know the job was completed.

## Author

A. Jonathan R. Godfrey.

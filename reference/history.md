# View the history of the current workspace

A substitute for the history function from the utils package.

## Usage

``` r
history(max.show = 25, reverse = FALSE, pattern, ...)
```

## Arguments

- max.show :

  The maximum number of lines to show. Inf will give all of the
  currently available history.

- reverse :

  logical. If true, the lines are shown in reverse order. Note: this is
  not useful when there are continuation lines.

- pattern :

  A character string to be matched against the lines of the history.
  When supplied, only unique matching lines are shown.

- ...:

  Arguments to be passed to grep when doing the matching.

## Value

Nothing is returned to the workspace. This function exists for the
creation and viewing of the temporary file that holds the list of
commands issued in the current workspace.

## Details

This function exists because the standard history function in the utils
package opens the internal pager that cannot be used by a blind person's
screen reading software.

## Author

Duncan Murdoch, with testing by A. Jonathan R. Godfrey.

## See also

the original [`history`](https://rdrr.io/r/utils/savehistory.html)
function.

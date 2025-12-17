# Prepare BrailleR settings for specific braille embossers

Convenience functions for setting package options based on
experimentation using specific embossers.

## Usage

``` r
Premier100()
```

## Value

Nothing. The functions are only used to set package options.

## Details

These functions are only relevant for owners of the specified embossers.
Ownership of these models means the user has access to fonts that are
licenced to the user.

The Premier 100 embosser uses standard 11 by 11.5 inch fanfold braille
paper. Printing in landscape or portrait is possible.

## Author

A. Jonathan R. Godfrey.

## See also

[`ChooseEmbosser`](http://ajrgodfrey.github.io/BrailleR/reference/SetOptions.md)

## Examples

``` r
# \donttest{
#Premier100() # Specify use of the Premier 100 embosser.
#ChooseEmbosser() # reset to default: using no embosser.
# }
```

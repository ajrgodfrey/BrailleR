# Set package options

A set of convenience functions to alter the settings that control how
much output is generated and displayed by other BrailleR functions.

## Usage

``` r
GoBlind()
GoSighted()


GoAdvanced()
GoNovice()

LatexOn()
LatexOff()

ViewOn()
ViewOff()
```

## Details

The function names should be fairly self explanatory. `GoBlind()` and
`GoSighted()` control use of the
[`VI()`](http://ajrgodfrey.github.io/BrailleR/reference/VI.md) method
which provides extra information about graphical objects for the
assistance of blind users; `GoAdvanced` (less verbose) and `GoNovice()`
(more verbose) control how much output a user will be given; `ViewOn()`
and `ViewOff()` are for the automatic opening of `HTML` pages created by
BrailleR functions; and `LatexOn()` and `LatexOff()` control the
production of tables into LaTeX via the xtable package.

## Value

Nothing is returned. These functions are only used for their side
effects.

## Author

A. Jonathan R. Godfrey

## See also

See these settings applied as default arguments to
[`UniDesc`](http://ajrgodfrey.github.io/BrailleR/reference/UniDesc.md)

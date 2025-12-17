# String manipulation of the output produced by VI.ggplot

Allows the output from VI.ggplot to be searched and replaced based on a
search pattern.

## Usage

``` r
# S3 method for class 'VIgraph'
grep(pattern, x, ...)
# S3 method for class 'VIgraph'
gsub(pattern, replacement, x, ...)
```

## Arguments

- pattern:

  Regular expression for matching, as per `grep`

- replacement:

  Replacement text, as per `gsub`

- x:

  object returned by `VI.ggplot`

- ...:

  other arguments passed on to `grep` or `gsub` to control matching
  behaviour

## Details

The BrailleR package redefines the `grep` and `gsub` functions as
generic functions (that dispatch on the `x` argument), with
[`base::grep`](https://rdrr.io/r/base/grep.html) and
[`base::gsub`](https://rdrr.io/r/base/grep.html) as the default methods.
This `grep.VIgraph` method behaves like
[`base::grep`](https://rdrr.io/r/base/grep.html) with `value=TRUE`
(i.e., it returns the matched values, not the indices).

## Value

Returns a new object of the same type as that returned by VI.ggplot, but
with the text component restricted to only those lines that matched the
pattern or with the text component replaced.

## Author

Debra Warren and Paul Murrell

## Examples

``` r
if (require(ggplot2)) {
    grep("axis", VI(qplot(1,1)))
    gsub("labels", "tick labels", VI(qplot(1,1)))
}
#> Warning: `qplot()` was deprecated in ggplot2 3.4.0.
#> This is an untitled chart with no subtitle or caption.
#> It has x-axis '1' with tick labels 0.950, 0.975, 1.000, 1.025 and 1.050.
#> It has y-axis '1' with tick labels 0.950, 0.975, 1.000, 1.025 and 1.050.
#> The chart is a set of 1 big solid circle point of which about 100% can be seen.
#> The points are at:
#> (1, 1)
```

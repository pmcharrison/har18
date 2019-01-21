---
output: github_document
---

<!-- README.md is generated from README.Rmd. Please edit that file -->


# har18: Implementation of Harrison & Pearce's (2018) Harmonicity Model

[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![Travis build status](https://travis-ci.org/pmcharrison/har18.svg?branch=master)](https://travis-ci.org/pmcharrison/har18)
[![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/pmcharrison/har18?branch=master&svg=true)](https://ci.appveyor.com/project/pmcharrison/har18)
[![Coverage status](https://coveralls.io/repos/github/pmcharrison/har18/badge.svg)](https://coveralls.io/r/pmcharrison/har18?branch=master)

Harmonicity is an important predictor of a chord's consonance.
This package provides methods for estimating a chord's harmonicity,
after Harrison & Pearce (2018) and Milne (2013).

## Installation 

You can install this package from GitHub:

```r
if (!require(devtools)) install.packages("devtools")
devtools::install_github("pmcharrison/har18")
```

## Example usage

A major chord is more harmonic than a diminished chord, as expected:


```r
library(har18)

pc_harmonicity("0 4 7")
#> [1] 0.9373149
pc_harmonicity("0 3 6")
#> [1] 0.7225033
```

By default, the package implements the method of Harrison & Pearce (2018).
Setting the option `method = "peak"` reproduces the method of Milne (2013).


```r
pc_harmonicity("0 4 7", method = "peak")
#> [1] 0.7170107
pc_harmonicity("0 3 6", method = "peak")
#> [1] 0.5896047
```

## References

Harrison, P. M. C., & Pearce, M. T. (2018). An energy-based generative sequence model for testing sensory theories of Western harmony. In Proceedings of the 19th International Society for Music Information Retrieval Conference. Paris, France. Retrieved from https://arxiv.org/abs/1807.00790

Milne, A. J. (2013). A computational model of the cognition of tonality. The Open University, Milton Keynes, England.

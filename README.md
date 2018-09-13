# `ppp`: Progressbars that fit into a `dplyr::mutate %>% purrr::map*` pipeline

## Installation

```r
devtools::install_github("cszang/ppp")
```

## Examples

A few packages...

```r
library(rlang)
library(tidyr)
library(dplyr)
library(purrr)
library(ppp)
```

A slow function to be used with `purrr::map*`:

```r
slow_mean <- function(x, .var) {
  Sys.sleep(1)
  .var <- rlang::enexpr(.var)
  mean(x[[.var]])
}
```

Setting up and updating progressbar is now part of the pipeline; it's default name is `.pb`. We decorate our function `slow_mean` to make it update the progressbar:

```r
mtcars %>%
  dplyr::group_by(carb) %>%
  tidyr::nest() %>%
  spawn_pb() %>%
  dplyr::mutate(mean_qsec = purrr::map_dbl(data, decorate_pb(slow_mean), qsec))
```

Since we can name the progressbars, we can have multiple sequential progress bars, like so:

```r
mtcars %>%
  dplyr::group_by(carb) %>%
  tidyr::nest() %>%
  spawn_pb(.pb_qsec) %>%
  spawn_pb(.pb_disp) %>%
  dplyr::mutate(mean_qsec = purrr::map_dbl(data, decorate_pb(slow_mean, .pb_qsec), qsec),
                mean_disp = purrr::map_dbl(data, decorate_pb(slow_mean, .pb_disp), disp))
```

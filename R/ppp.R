
#' Spawn a progressbar
#'
#' @param x a data.frame or tibble
#' @param .name the name of the progressbar
#' @param .times multiply number of steps
#'
#' @return returns x unchanged
#' @importFrom dplyr progress_estimated
#' @importFrom R6 R6Class
#' @export
spawn_pb <- function(x, .name = .pb, .times = 1) {
  .name <- substitute(.name)
  n <- nrow(x) * .times
  eval(substitute(.name <<- dplyr::progress_estimated(n)))
  x
}

#' Decorate a function to update a progressbar
#'
#' @param f a function
#' @param pb the name of the progressbar
#'
#' @return a decorated variant of the original function
#' @importFrom dplyr progress_estimated
#' @importFrom R6 R6Class
#' @export
decorate_pb <- function(f, pb = .pb) {
  function(...) {
    pb$tick()$print()
    f(...)
  }
}

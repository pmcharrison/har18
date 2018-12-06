#' @export
cosine_similarity <- function(x, y) {
  numerator <- sum(x * y)
  denominator <-
    sqrt(sum(x ^ 2)) *
    sqrt(sum(y ^ 2))
  numerator / denominator
}

#' @export
sweep_harmonic_template <- function(x,
                                    num_harmonics = 12,
                                    rho = 0.75,
                                    sigma = 6.83,
                                    array_dim = 1200,
                                    ...) {
  UseMethod("sweep_harmonic_template")
}

#' @export
sweep_harmonic_template.pc_set <- function(x,
                                           num_harmonics = 12,
                                           rho = 0.75,
                                           sigma = 6.83,
                                           array_dim = 1200,
                                           ...) {
  hrep::pc_milne_spectrum(x,
                           num_harmonics = num_harmonics,
                           rho = rho,
                           sigma = sigma,
                           array_dim = array_dim) %>%
    sweep_harmonic_template(num_harmonics = num_harmonics,
                            rho = rho,
                            sigma = sigma)
}

#' @export
sweep_harmonic_template.pc_milne_spectrum <- function(x,
                                                       num_harmonics = 12,
                                                       rho = 0.75,
                                                       sigma = 6.83,
                                                       ...) {
  x <- as.numeric(x)
  array_dim <- length(x)
  res <- numeric(array_dim)
  template <- hrep::pc_milne_spectrum(hrep::pc_set(0),
                                       array_dim = array_dim,
                                       num_harmonics = num_harmonics,
                                       rho = rho,
                                       sigma = sigma)
  for (i in seq_len(array_dim)) {
    indices <- 1 + (seq(from = i - 1, length.out = array_dim) %% array_dim)
    res[i] <- cosine_similarity(template, x[indices])
  }
  hrep::.pc_milne_spectrum(res)
}

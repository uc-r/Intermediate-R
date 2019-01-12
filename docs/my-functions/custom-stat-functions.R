variance <- function(x) {
  n <- length(x)
  m <- mean(x)
  (1/(n - 1)) * sum((x - m)^2)
}

std_dev <- function(x) {
  sqrt(variance(x))
}


std_error <- function(x) {
  n <- length(x)
  sqrt(variance(x) / n)
}

skewness <- function(x) {
  n <- length(x)
  v <- variance(x)
  m <- mean(x)
  third.moment <- (1 / (n - 2)) * sum((x - m)^3)
  third.moment / (v^(3 / 2))
}
test_that("AD test gives same results for a data frame and a vector", {
  data <- data.frame(
    strength = c(
      79.9109621761937,
      77.9447436346388,
      79.717168019752,
      87.3547460860547,
      76.2404769192413,
      75.7026911300246,
      79.5952709280298,
      76.7833784980155,
      77.5791472067831,
      78.4164523339268,
      79.2819398818745,
      77.6346481930964,
      81.2182937743241,
      81.1826431730731,
      86.0561762593461,
      82.1837784884495,
      80.7564920650884,
      79.3614980225488
    ))
  res_vec1 <- anderson_darling_normal(
    x = data$strength)

  # value from STAT17 (0.0840)
  expect_equal(res_vec1$osl, 0.0840, tolerance = 0.002)

  res_df <- anderson_darling_normal(
    data,
    strength)

  expect_equal(res_vec1$osl, res_df$osl)
})

test_that("AD test matches results from STAT17 (normal)", {
  data <- data.frame(
    strength = c(
      137.4438,
      139.5395,
      150.89,
      141.4474,
      141.8203,
      151.8821,
      143.9245,
      132.9732,
      136.6419,
      138.1723,
      148.7668,
      143.283,
      143.5429,
      141.7023,
      137.4732,
      152.338,
      144.1589,
      128.5218
    ))
  res_vec <- anderson_darling_normal(x = data$strength)
  expect_equal(res_vec$osl, 0.465, tolerance = 0.002)
  # Do it again but pass in a data.frame
  res_df <- anderson_darling_normal(data, strength)
  expect_equal(res_vec$osl, res_df$osl)
})

test_that("AD test matches results from STAT17 (lognormal)", {
  data <- data.frame(
    strength = c(
      137.4438,
      139.5395,
      150.89,
      141.4474,
      141.8203,
      151.8821,
      143.9245,
      132.9732,
      136.6419,
      138.1723,
      148.7668,
      143.283,
      143.5429,
      141.7023,
      137.4732,
      152.338,
      144.1589,
      128.5218
    ))
  res_vec <- anderson_darling_lognormal(x = data$strength)
  expect_equal(res_vec$osl, 0.480, tolerance = 0.002)
  # Do it again but pass in a data.frame
  res_df <- anderson_darling_lognormal(data, strength)
  expect_equal(res_vec$osl, res_df$osl)
})

test_that("AD test matches results from STAT17 (weibull)", {
  data <- data.frame(
    strength = c(
      137.4438,
      139.5395,
      150.89,
      141.4474,
      141.8203,
      151.8821,
      143.9245,
      132.9732,
      136.6419,
      138.1723,
      148.7668,
      143.283,
      143.5429,
      141.7023,
      137.4732,
      152.338,
      144.1589,
      128.5218
    )
  )
  # OSL: 0.179
  res_vec <- anderson_darling_weibull(x = data$strength)
  expect_equal(res_vec$osl, 0.179, tolerance = 0.002)
  # Do it again but pass in a data.frame
  res_df <- anderson_darling_weibull(data, strength)
  expect_equal(res_vec$osl, res_df$osl)
})

test_that("ad_p_unknown_parameters matches normal results from Lawless", {
  # Comparison with the results from:
  # J. F. Lawless, \emph{Statistical models and methods for lifetime data}.
  # New York: Wiley, 1982.
  # See page 458
  fcn <- function(a, n) {
    ad_p_normal_unknown_param(a / (1 + 4 / n - 25 / n ^ 2), n)
  }

  n <- 5
  expect_equal(fcn(0.576, n), 0.15, tolerance = 0.002 / 0.15)
  expect_equal(fcn(0.656, n), 0.10, tolerance = 0.002 / 0.10)
  expect_equal(fcn(0.787, n), 0.05, tolerance = 0.002 / 0.05)
  expect_equal(fcn(0.918, n), 0.025, tolerance = 0.002 / 0.025)
  expect_equal(fcn(1.092, n), 0.01, tolerance = 0.002 / 0.01)

  n <- 10
  expect_equal(fcn(0.576, n), 0.15, tolerance = 0.002 / 0.15)
  expect_equal(fcn(0.656, n), 0.10, tolerance = 0.002 / 0.10)
  expect_equal(fcn(0.787, n), 0.05, tolerance = 0.002 / 0.05)
  expect_equal(fcn(0.918, n), 0.025, tolerance = 0.002 / 0.025)
  expect_equal(fcn(1.092, n), 0.01, tolerance = 0.002 / 0.01)

  n <- 20
  expect_equal(fcn(0.576, n), 0.15, tolerance = 0.002 / 0.15)
  expect_equal(fcn(0.656, n), 0.10, tolerance = 0.002 / 0.10)
  expect_equal(fcn(0.787, n), 0.05, tolerance = 0.002 / 0.05)
  expect_equal(fcn(0.918, n), 0.025, tolerance = 0.002 / 0.025)
  expect_equal(fcn(1.092, n), 0.01, tolerance = 0.002 / 0.01)
})

test_that("ad_p_unknown_parameters matches weibull results from Lawless", {
  # Comparison with the results from:
  # J. F. Lawless, \emph{Statistical models and methods for lifetime data}.
  # New York: Wiley, 1982.
  # See p. 455
  fcn <- function(a, n) {
    ad_p_weibull_unknown_param(a / (1 + 0.2 / sqrt(n)), n)
  }

  n <- 5
  expect_equal(fcn(0.474, n), 0.25, tolerance = 0.002 / 0.25)
  expect_equal(fcn(0.637, n), 0.10, tolerance = 0.002 / 0.10)
  expect_equal(fcn(0.757, n), 0.05, tolerance = 0.002 / 0.05)
  expect_equal(fcn(0.877, n), 0.025, tolerance = 0.002 / 0.025)
  expect_equal(fcn(1.038, n), 0.01, tolerance = 0.002 / 0.01)

  n <- 10
  expect_equal(fcn(0.474, n), 0.25, tolerance = 0.002 / 0.25)
  expect_equal(fcn(0.637, n), 0.10, tolerance = 0.002 / 0.10)
  expect_equal(fcn(0.757, n), 0.05, tolerance = 0.002 / 0.05)
  expect_equal(fcn(0.877, n), 0.025, tolerance = 0.002 / 0.025)
  expect_equal(fcn(1.038, n), 0.01, tolerance = 0.002 / 0.01)

  n <- 20
  expect_equal(fcn(0.474, n), 0.25, tolerance = 0.002 / 0.25)
  expect_equal(fcn(0.637, n), 0.10, tolerance = 0.002 / 0.10)
  expect_equal(fcn(0.757, n), 0.05, tolerance = 0.002 / 0.05)
  expect_equal(fcn(0.877, n), 0.025, tolerance = 0.002 / 0.025)
  expect_equal(fcn(1.038, n), 0.01, tolerance = 0.002 / 0.01)
})

test_that("print.anderson_darling contains expected values", {
  data <- data.frame(
    strength = c(
      137.4438,
      139.5395,
      150.89,
      141.4474,
      141.8203,
      151.8821,
      143.9245,
      132.9732,
      136.6419,
      138.1723,
      148.7668,
      143.283,
      143.5429,
      141.7023,
      137.4732,
      152.338,
      144.1589,
      128.5218
    ))
  res_vec <- anderson_darling_normal(x = data$strength)
  # should include the distribution
  expect_output(print(res_vec), "distribution.*normal", ignore.case = TRUE)
  # should include the signficance for known parameters
  expect_output(print(res_vec), "OSL.*0.464.*unknown", ignore.case = TRUE)
  # conclusion should be printed
  expect_output(print(res_vec), "conclusion.*is drawn.*alpha.*0.05",
                ignore.case = TRUE)
  expect_false(res_vec$reject_distribution)

  # if alpha is adjusted to be above OSL, the conclusion should be reversed
  res_vec <- anderson_darling_normal(x = data$strength, alpha = 0.470)
  expect_output(print(res_vec), "conclusion.*is not drawn.*alpha.*0.47",
                ignore.case = TRUE)
  expect_true(res_vec$reject_distribution)
})

test_that("glance method produces expected results", {
  x <- c(
    137.4438,
    139.5395,
    150.89,
    141.4474,
    141.8203,
    151.8821,
    143.9245,
    132.9732,
    136.6419,
    138.1723,
    148.7668,
    143.283,
    143.5429,
    141.7023,
    137.4732,
    152.338,
    144.1589,
    128.5218
  )
  res <- anderson_darling_lognormal(x = x)
  glance_res <- glance(res)

  expect_equal(glance_res$osl[1], 0.480, tolerance = 0.002)
  expect_equal(glance_res$dist[1], "Lognormal")
  expect_equal(glance_res$n[1], 18)
  expect_equal(glance_res$A[1], 0.277, tolerance = 0.005)
  expect_equal(glance_res$alpha, 0.05)
  expect_equal(glance_res$reject_distribution, FALSE)
})

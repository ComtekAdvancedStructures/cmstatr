suppressMessages(library(dplyr))
suppressMessages(library(ggplot2))


test_that("stat_esf", {
  skip_if_not_installed("vdiffr")
  vdiffr::expect_doppelganger("stat_esf", {
    carbon.fabric.2 %>%
      filter(test == "WT" & condition == "RTD") %>%
      group_by(batch) %>%
      ggplot(aes(x = strength, color = batch)) +
      stat_esf(pad = TRUE) +
      ggtitle("Distribution of Data For Each Batch")
  })
})

test_that("stat_normal_surv_func", {
  skip_if_not_installed("vdiffr")
  vdiffr::expect_doppelganger("stat_normal_surv_func", {
    carbon.fabric.2 %>%
      filter(test == "WT" & condition == "RTD") %>%
      group_by(batch) %>%
      ggplot(aes(x = strength, color = batch)) +
      stat_normal_surv_func() +
      ggtitle("Distribution of Data For Each Batch")
  })
})

test_that("stat_normal_surv_func and stat_esf", {
  skip_if_not_installed("vdiffr")
  vdiffr::expect_doppelganger("stat_normal_surv_func and stat_esf", {
    set.seed(100)
    data.frame(
      strength = c(rnorm(400, 100, 10),
                   rnorm(400, 120, 10),
                   rnorm(400, 140, 10)),
      batch = c(rep("A", 400), rep("B", 400), rep("C", 400))
    ) %>%
      group_by(batch) %>%
      ggplot(aes(x = strength, color = batch)) +
      stat_esf(pad = TRUE) +
      stat_normal_surv_func() +
      ggtitle("Distribution of Data For Each Batch")
  })
})

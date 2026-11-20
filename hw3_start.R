# P8108 Survival Analysis, Fall 2026 | Homework 3
# Keep this file and hw3_actg320.csv in your working directory.
# Set case_remainder before sourcing if you will knit your analysis. To find
# it, take the last two digits of the numeric part of your UNI and divide by
# four, keeping the remainder. Without a UNI, choose any two-digit number
# (00-99) and use it throughout. Record only the letter in your write-up.
# In the R console, sourcing this file also lets you enter the remainder.

d <- read.csv("hw3_actg320.csv")
stopifnot(identical(names(d), c("id", "months", "event", "trt", "cd4", "k100")),
          !anyNA(d), !anyDuplicated(d$id), all(d$months > 0),
          all(d$cd4 >= 0), all(d$event %in% 0:1),
          all(d$trt %in% 0:1), all(d$k100 %in% 0:1))

d$x <- d$cd4 / 50
d$band <- factor(ifelse(d$cd4 < 50, "low", ifelse(d$cd4 <= 100, "mid", "high")),
                 levels = c("high", "mid", "low"))

if (!exists("case_remainder", inherits = FALSE)) {
  if (!interactive()) {
    stop("Set case_remainder to 0, 1, 2, or 3 before sourcing hw3_start.R.")
  }
  case_remainder <- as.numeric(readline("Enter only the remainder (0-3): "))
}
stopifnot(length(case_remainder) == 1L, is.numeric(case_remainder),
          case_remainder %in% 0:3)

profiles <- data.frame(case = c("A", "B", "C", "D"),
                       trt = c(0L, 1L, 0L, 1L),
                       k100 = c(0L, 0L, 1L, 1L),
                       band = factor(rep("low", 4), levels = levels(d$band)),
                       stringsAsFactors = FALSE)
profile <- profiles[case_remainder + 1L, , drop = FALSE]
case <- profile$case
message("Assigned case: ", case)

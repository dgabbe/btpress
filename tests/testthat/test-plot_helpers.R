context("Plot_helpers functions")

test_that("psi_to_bar works", {
  expect_equal(psi_to_bar(100), 6.8947)
})

test_that("lb_to_kg works", {
  expect_equal(lb_to_kg(10), 4.5359)
})

test_that("dual_weight works", {
  expect_equal(dual_weight(10), "10 lbs\n5 kg")
})

test_that("dual_pressure works", {
  expect_equal(dual_pressure(50), "50 psi\n3.4 bar")
})

test_that("dual_pressure_point Front works", {
  expect_equal(dual_pressure_point(32, "Front", 70), "32mm Front\n70 psi | 4.8 bar")
})

test_that("dual_pressure_point Rear works", {
  expect_equal(dual_pressure_point(32, "Rear", 70), "32mm Rear\n70 psi | 4.8 bar")
})


# dual_pressure_point
#
# plot_title
#
# rider_expand_limits

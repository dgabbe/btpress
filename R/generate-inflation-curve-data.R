#' Nominal tire sizes.
#'
#' Also happen to be the ones Compass Bicycle sells.
#'
#' 14-Jun-2017: Updated to include all sizes.
#' @export
tire_sizes_mm <- c(23, 25, 28, 32, 35, 38, 42, 44, 48, 54)

#' X axis values for wheel loads in lbs
#'
#' Based on the Bicycle Quarterly chart which is in kilograms
#' @export
wheel_loads_lbs <- c(66, 77, 88, 100, 110, 121, 132, 143, 154)

#' Compute the 15\% droop tire pressure based on wheel load and tire size
#'
#' The emperical, imperial centric formula is from the
#' \href{http://www.biketinker.com/2010/bike-resources/optimal-tire-pressure-for-bicycles/}{BikeTinker}
#'
#' @param weight_lbs is the load on the bicycle wheel and typically 40 - 60 percent
#' of the total weight of the rider, bike and carried items.
#'
#' @param tire_size_mm is the nominal size of the tire from the casing label or directly
#'  measured diameter.
#'
#' @return pressure, psi
#' @export
droop_pressure_psi <- function(weight_lbs, tire_size_mm) {
  return(153.6 * weight_lbs / tire_size_mm**1.5785 - 7.1685)
}


#' Generate a data set point.
#'
#' Used to build data to display inflation curves on base inflation plot.
#'
#' @param wheel_load_lbs Self-explanatory
#' @param tire_size_mm Self-explanatory
#'
#' @return c(wheel load, tire size, and droop pressure)
#' @export
inflation_datum <- function(wheel_load_lbs, tire_size_mm) {
  return(
    c(
      wheel_load_lbs,
      tire_size_mm,
      droop_pressure_psi(wheel_load_lbs, tire_size_mm)
      )
    )
}

inflation_data <- matrix(
  ncol = 3,
  byrow = TRUE,
  dimnames=list(c(), c("wheel_load_lbs", "tire_size_mm", "tire_pressure_psi"))
)

# Figure out double nested apply semantics!
# Even worse - first row is NAs because of inflation_data has no info in it for
# first rbind call.
for(wl in wheel_loads_lbs){
  for(ts in tire_sizes_mm){
    inflation_data <- rbind(inflation_data, inflation_datum(wl, ts))
  }
}

inflation_data <- as.data.frame(inflation_data)
inflation_data <- inflation_data[-c(1), ] # hack alert!
inflation_data$tire_size_mm <- as.factor(inflation_data$tire_size_mm)
inflation_data$label  <- paste(inflation_data$tire_size_mm, "mm", sep = "")

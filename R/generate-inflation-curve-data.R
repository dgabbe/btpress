#' Nominal tire sizes.
#'
#' Also happen to be the ones Compass Bicycle sells.
#'
#' 14-Jun-2017: Updated to include all sizes.
#' @export
tire_sizes_mm <- as.integer(c(23, 25, 28, 32, 35, 38, 42, 44, 48, 54))

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

#' @importFrom tibble add_row
#' @importFrom tibble tribble
#' @export
inflation_data <- tibble::tribble(~wheel_load_lbs, ~tire_size_mm, ~tire_pressure_psi, ~tire_size_text)
for(wl in wheel_loads_lbs){
  for(ts in tire_sizes_mm){
    inflation_data <- tibble::add_row(
      inflation_data,
      wheel_load_lbs = wl,
      tire_size_mm = as.integer(ts),
      tire_pressure_psi = droop_pressure_psi(wl, ts),
      tire_size_text = paste(ts, "mm", sep = "")
    )
  }
}

#' @export
max_psi <- 120

#' @export
min_psi <- 15

#' @importFrom dplyr filter
inflation_data <- dplyr::filter(inflation_data, tire_pressure_psi <= max_psi, tire_pressure_psi >= min_psi)
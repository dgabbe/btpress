#' Nominal tire sizes
#'
#' Widths from Compass Bicycle catalog.
#'
#' @export
tire_sizes_mm <- function() {
  as.integer(c(20, 23, 25, 28, 32, 35, 38, 42, 44, 48, 55, 58))
}

#' X axis values for wheel loads in lbs
#'
#' Based on the Bicycle Quarterly chart which is in kilograms
#' @export
wheel_loads_lbs <- function() { c(66, 77, 88, 100, 110, 121, 132, 143, 154) }

x_max_wheel_load <- ceiling(max(wheel_loads_lbs()) / 10) * 10
x_min_wheel_load <- floor(min(wheel_loads_lbs()) / 10) * 10

#' Generate the dataset for drawing the inflation curves
#'
#' Assign it to a variable if you want to explore it.
#'
#' @param wheel_loads Vector containing the major X axis loads.
#' @param tire_sizes Vector containing the different tire widths.
#' @param min_psi Lowest pressure to plot.
#' @param max_psi Highest pressure to plot.
#'
#' @return tibble
#' @include min_max_limits.R
#' @export
generate_inflation_data <- function(
  wheel_loads = wheel_loads_lbs(),
  tire_sizes = tire_sizes_mm(),
  min_psi = min_tire_psi,
  max_psi = max_tire_psi
) {
  d <- tibble::tribble(~wheel_load_lbs, ~tire_size_mm, ~tire_pressure_psi, ~tire_size_text)
  for(wl in wheel_loads){
    for(ts in tire_sizes){
      d <- tibble::add_row(
        d,
        wheel_load_lbs = wl,
        tire_size_mm = as.integer(ts),
        tire_pressure_psi = droop_pressure_psi(wl, ts),
        tire_size_text = paste(ts, "mm", sep = "")
      )
    }
  }
  d <- dplyr::filter(d, tire_pressure_psi <= max_psi, tire_pressure_psi >= min_psi)
  return(d)
}

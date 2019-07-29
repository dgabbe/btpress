#' Compute the 15\% droop tire pressure based on wheel load and tire size
#'
#' Original research used rims with internal widths of \~19mm. Today's wider
#' rims can add increase the volume of a tire by 33\%.
#'
#' The emperical, imperial centric formula is from the
#' \href{https://www.biketinker.com/2010/bike-resources/optimal-tire-pressure-for-bicycles/}{BikeTinker}
#'
#' @param weight_lbs is the load on the bicycle wheel and typically 40 - 60
#'   percent of the total weight of the rider, bike and carried items.
#'
#' @param tire_size_mm is the nominal size of the tire from the casing label or
#'   directly measured diameter.
#'
#' @return pressure, psi
#' @export
droop_pressure_psi <- function(weight_lbs, tire_size_mm) {
  return(153.6 * weight_lbs / tire_size_mm**1.5785 - 7.1685)
}

# !!! correct for units !!!
droop_pressure_bar <- function(weight_kgs, tire_size_mm) {
  return(153.6 * weight_kgs / tire_size_mm**1.5785 - 7.1685)
}

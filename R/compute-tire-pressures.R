#' Compute front and rear tire pressures based on data for bike and rider.
#'
#' @param rider_weight_lbs Weight of rider dressed with biking shoes and helmet.
#' @param bike_weight_lbs Weight of bike
#' @param load_lbs Weight of accessories carried on the bike such as water bottles, repair kit, pump, etc.
#' @param front_tire_casing_compensation Supple casings require about 15\% more pressure to maintain shape.
#' @param front_tire_size_mm Measured or side wall marking.
#' @param rear_tire_casing_compensation Supple casings require about 15\% more pressure to maintain shape.
#' @param rear_tire_size_mm Measured or side wall marking.
#' @param front_distribution Decimal representation of percentage of bike plus rider weight on the front wheel.
#'
#' @return data.frame that used by ggplot to display tire pressures
#' @export
bike_tire_pressures <- function(
  rider_weight_lbs = 100,
  bike_weight_lbs = 15,
  load_lbs = 2,
  front_tire_casing_compensation = 1,
  front_tire_size_mm = 28,
  rear_tire_casing_compensation = 1,
  rear_tire_size_mm = 28,
  front_distribution = 0.5
)
  {
  total_weight <- rider_weight_lbs + bike_weight_lbs + load_lbs
  front_weight <- total_weight * front_distribution
  rear_weight <- total_weight * (1 - front_distribution)
  front <- c(
    round(front_weight),
    front_tire_size_mm,
    round(
      droop_pressure_psi(front_weight, front_tire_size_mm) * front_tire_casing_compensation
    )
  )
  rear <- c(
    round(rear_weight),
    rear_tire_size_mm,
    round(
      droop_pressure_psi(rear_weight, rear_tire_size_mm) * rear_tire_casing_compensation
    )
  )
  pressures <- matrix(front, ncol = 3, byrow = TRUE)
  pressures <- rbind(pressures, rear)
  pressures <- as.data.frame(pressures)
  colnames(pressures) <- c("Weight", "tire_size_mm", "Pressure")
  rownames(pressures) <- c("Front", "Rear")
  pressures$tire_size_mm <- as.factor(pressures$tire_size_mm)
  return(pressures)
}

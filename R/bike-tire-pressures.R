#' Compute front and rear tire pressures based on data for bike and rider.
#'
#' The label for each point is generated and stored in the `annotation` column.
#'
#' For pressures between 105 and 120psi, a suggestion to increase tire width is stored in the `message`
#' column. For pressures over 120psi, a suggestion to check max tire and rim pressures is stored.
#'
#' @param rider_weight_lbs Weight of rider dressed with biking shoes and helmet.
#' @param bike_weight_lbs Weight of bike
#' @param load_lbs Weight of accessories carried on the bike such as water bottles, repair kit, pump, etc.
#' @param front_tire_casing_compensation Supple casings require about 15\% more pressure to maintain shape.
#' @param front_tire_size_mm Measured or side wall marking.
#' @param rear_tire_casing_compensation Supple casings require about 15\% more pressure to maintain shape.
#' @param rear_tire_size_mm Measured or side wall marking.
#' @param front_distribution Decimal representation of percentage of bike plus rider weight
#' on the front wheel. Defaults to 0.4 for dropped handlebar road bike
#' corresponding to 40/60 front/rear weight distribution.
#'
#' @return tibble used by ggplot to display tire pressures
#' @importFrom tibble tribble
#' @export
bike_tire_pressures <- function(
  rider_weight_lbs = 100,
  bike_weight_lbs = 15,
  load_lbs = 2,
  front_tire_casing_compensation = 1,
  front_tire_size_mm = 28,
  rear_tire_casing_compensation = 1,
  rear_tire_size_mm = 28,
  front_distribution = 0.4
)
  {
  total_weight <- rider_weight_lbs + bike_weight_lbs + load_lbs
  front_weight <- total_weight * front_distribution
  rear_weight <- total_weight * (1 - front_distribution)
  pressures <- tibble::tribble(
    ~position, ~position_short, ~Load, ~Tire_size, ~Pressure, ~distribution, ~annotation, ~message, ~ggplot_color,
    #--------/----------------/--------/-----------/----------/--------------/------------/-------/
    "Front",
      "F",
      round(front_weight),
      as.integer(front_tire_size_mm),
      round(droop_pressure_psi(front_weight, front_tire_size_mm) * front_tire_casing_compensation),
      as.integer(front_distribution * 100),
      "",
      "",
      "darkblue",

    "Rear",
      "R",
      round(rear_weight),
      as.integer(rear_tire_size_mm),
      round(droop_pressure_psi(rear_weight, rear_tire_size_mm) * rear_tire_casing_compensation),
      as.integer(((1 - front_distribution) * 100)),
      "",
      "",
      "black"
  )
  pressures$annotation <- dual_pressure_point(pressures$Tire_size, pressures$position, pressures$Pressure)
  for (i in 1:nrow(pressures)) {
    # add messages/warnings here
  }

  w <- tibble::tribble(
    ~Source, ~Weight,
    "Rider", rider_weight_lbs,
    "Bike", bike_weight_lbs,
    "Load", load_lbs
  )

  return(list(weights = w, wheels = pressures))
}

#' Check if pressure exceeds certain levels
#'
#' Display a message if the tire pressure might be getting into the range where
#' a tire or rim could be overinflated. Data published by DT Swiss listing the
#' maxiumum rim pressure by tire size is used.
#'
#' @param p Desired tire inflation pressure
#' @param tire_size tire size
#'
#' @return a list or NA
#' @include min_max_limits.R
#' @importFrom magrittr %>%
#' @export
check_pressure <- function(p, tire_size) {
  max_psi <- dplyr::filter(max_rim_psi, tire_width_mm <= tire_size) %>%
    dplyr::select(max_rim_psi) %>%
    min()
  if (p > max_psi) {
    return(
      list(
        "msg" = paste(
          "Warning: Check maximum tire and rim PSI ratings are not exceeded!"
        ),
        "color" = "red"
      )
    )
  } else {
    return(list())
  }
}


#' Compute front and rear tire pressures based on data for bike and rider.
#'
#' The label for each point is generated and stored in the `annotation` column.
#'
#' For pressures between 105 and 120psi, a suggestion to increase tire width is
#' stored in the `message` column. For pressures over 120psi, a suggestion to
#' check max tire and rim pressures is stored.
#'
#' @param rider_weight_lbs Weight of rider dressed in riding attire, biking shoes and helmet.
#' @param bike_weight_lbs Weight of bike
#' @param load_lbs Weight of accessories carried on the bike such as water
#'   bottles, repair kit, pump, etc.
#' @param front_tire_casing_compensation Supple casings require about 15\% more
#'   pressure to maintain shape.
#' @param front_tire_size_mm Measured or side wall marking.
#' @param rear_tire_casing_compensation Supple casings require about 15\% more
#'   pressure to maintain shape.
#' @param rear_tire_size_mm Measured or side wall marking.
#' @param front_distribution Decimal representation of percentage of bike plus
#'   rider weight on the front wheel. Defaults to 0.4 for dropped handlebar road
#'   bike corresponding to 40/60 front/rear weight distribution.
#'
#' @return tibble used by ggplot to display tire pressures
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
  # Param validation
  if (
    min(front_tire_casing_compensation, rear_tire_casing_compensation) < 1 |
    max(front_tire_casing_compensation, rear_tire_casing_compensation) > 1.20 |
    min(front_tire_size_mm, rear_tire_size_mm) < min(tire_sizes_mm()) |
    max(front_tire_size_mm, rear_tire_size_mm) > max(tire_sizes_mm()) |
    rider_weight_lbs > max_rider_weight |
    rider_weight_lbs < min_rider_weight |
    front_distribution < 0.25 |
    front_distribution > 0.80
  ) {
    stop("Unhelpful msg - one or more parameters are out of range")
  }

  if (load_lbs > max_load_weight) {
    message("Ah, check load_lbs - probably too heavy")
  }

  # Calculations
  total_weight <- rider_weight_lbs + bike_weight_lbs + load_lbs
  front_weight <- total_weight * front_distribution
  rear_weight <- total_weight * (1 - front_distribution)
  front_pressure <- round(
    droop_pressure_psi(front_weight, front_tire_size_mm) * front_tire_casing_compensation
    )
  rear_pressure <- round(
    droop_pressure_psi(rear_weight, rear_tire_size_mm) * rear_tire_casing_compensation
    )

  # Store results
  pressures <- tibble::tribble(
    ~position, ~position_short, ~Load, ~Tire_size, ~Pressure, ~distribution, ~annotation, ~ggplot_color,
    #--------/----------------/--------/-----------/----------/--------------/------------/-------/
    "Front",
      "F",
      round(front_weight),
      as.integer(front_tire_size_mm),
      front_pressure,
      as.integer(front_distribution * 100),
      "",
      "darkblue",

    "Rear",
      "R",
      round(rear_weight),
      as.integer(rear_tire_size_mm),
      rear_pressure,
      as.integer(((1 - front_distribution) * 100)),
      "",
      "black"
  )

  pressures$annotation <- dual_pressure_point(
    pressures$Tire_size, pressures$position, pressures$Pressure
    )

  m <- tibble::tribble(
    ~Position,
    ~Msg,
    ~color,
    ~x,
    ~y
  )

  p <- check_pressure(front_pressure, front_tire_size_mm)
  if (length(p) > 0) {
    m <- tibble::add_row(
      m,
      Position = "Front",
      Msg = paste("Front", p$msg),
      color = p$color,
      x = 65,
      y = 23
    )
  }

  p <- check_pressure(rear_pressure, rear_tire_size_mm)
  if (length(p) > 0) {
    m <- tibble::add_row(
      m,
      Position = "Rear",
      Msg = paste("Rear", p$msg),
      color = p$color,
      x = 65,
      y = 15
    )
  }

  w <- tibble::tribble(
    ~Source, ~Weight,
    "Rider", rider_weight_lbs,
    "Bike", bike_weight_lbs,
    "Load", load_lbs
  )

  return(list(weights = w, wheels = pressures, messages = m))
}

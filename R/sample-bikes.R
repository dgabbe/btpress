#' @export
steel_sport <- bike_tire_pressures(
  rider_weight_lbs = 170,
  bike_weight_lbs = 20,
  front_distribution = 0.4,
  front_tire_size_mm = 26,
  front_tire_casing_compensation = 1.15,
  rear_tire_size_mm = 28,
  rear_tire_casing_compensation = 1.15
  )

#' @export
steel_sport_plot <- plot_bike_inflation(bike = steel_sport, show_summary = TRUE)

#' @export
internal_hub_shopping <- bike_tire_pressures(
  rider_weight_lbs = 165,
  bike_weight_lbs = 35,
  load_lbs = 20,
  front_distribution = 0.5,
  front_tire_size_mm = 35,
  rear_tire_size_mm = 32,
  rear_tire_casing_compensation = 1.15
  )

#' @export
internal_hub_shopping_plot <- plot_bike_inflation(base_pressure_plot, internal_hub_shopping, show_summary = TRUE)

#' @export
internal_hub_fun <- bike_tire_pressures(
  rider_weight_lbs = 165,
  bike_weight_lbs = 35,
  load_lbs = 3,
  front_distribution = 0.45,
  front_tire_size_mm = 35,
  rear_tire_size_mm = 32,
  rear_tire_casing_compensation = 1.15
)

#' @export
internal_hub_fun_plot <- plot_bike_inflation(
  base_pressure_plot, internal_hub_fun, show_summary = TRUE
  )

#' @export
trek_lexa <- bike_tire_pressures(
  rider_weight_lbs = 145,
  bike_weight_lbs = 15,
  load_lbs = 1,
  front_distribution = 0.4,
  front_tire_size_mm = 28,
  rear_tire_size_mm = 26
)

#' @export
trek_lexa_plot <- plot_bike_inflation(base_pressure_plot, trek_lexa)

#' @export
all_roads <- bike_tire_pressures(
  rider_weight_lbs = 170,
  bike_weight_lbs = 20,
  front_distribution = 0.4,
  front_tire_size_mm = 54,
  front_tire_casing_compensation = 1.15,
  rear_tire_size_mm = 54,
  rear_tire_casing_compensation = 1.15
)

#' @export
all_roads_plot <- plot_bike_inflation(base_pressure_plot, all_roads, show_summary = TRUE)


# Nairo Quintana
#' @export
nairo <- bike_tire_pressures(
  rider_weight_lbs = 125,
  bike_weight_lbs = 15,
  load_lbs = 1,
  front_distribution = 0.4,
  front_tire_size_mm = 28,
  front_tire_casing_compensation = 1.1,
  rear_tire_size_mm = 28,
  rear_tire_casing_compensation = 1.1
  )

#' @export
nairo_plot <- plot_bike_inflation(base_pressure_plot, nairo)

# Chris Froome
#' @export
froome <- bike_tire_pressures(
  rider_weight_lbs = 150,
  bike_weight_lbs = 15,
  load_lbs = 1,
  front_distribution = 0.4,
  front_tire_size_mm = 28,
  front_tire_casing_compensation = 1.1,
  rear_tire_size_mm = 28,
  rear_tire_casing_compensation = 1.1
)

#' @export
froome_plot <- plot_bike_inflation(base_pressure_plot, froome)

#' @export
too_heavy <- bike_tire_pressures(
  rider_weight_lbs = 250,
  bike_weight_lbs = 25,
  load_lbs = 5,
  front_distribution = 0.4,
  front_tire_size_mm = 19,
  rear_tire_size_mm = 25
)

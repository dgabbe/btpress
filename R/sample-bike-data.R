mooney <- bike_tire_pressures(
  rider_weight_lbs = 170,
  bike_weight_lbs = 20,
  front_distribution = 0.4,
  front_tire_size_mm = 26,
  front_tire_casing_compensation = 1.15,
  rear_tire_size_mm = 28,
  rear_tire_casing_compensation = 1.15
  )

#' @export
mooney_plot <- display_bike_inflation(base_pressure_plot, mooney)

norco_shopping <- bike_tire_pressures(
  rider_weight_lbs = 165,
  bike_weight_lbs = 35,
  load_lbs = 20,
  front_distribution = 0.5,
  front_tire_size_mm = 35,
  rear_tire_size_mm = 32,
  rear_tire_casing_compensation = 1.15
  )

norco_shopping_plot <- display_bike_inflation(base_pressure_plot, norco_shopping)


norco_fun <- bike_tire_pressures(
  rider_weight_lbs = 165,
  bike_weight_lbs = 35,
  load_lbs = 3,
  front_distribution = 0.45,
  front_tire_size_mm = 32,
  front_tire_casing_compensation = 1.1,
  rear_tire_size_mm = 28
)

norco_fun_plot <- display_bike_inflation(base_pressure_plot, norco_fun)

lfr_trek_lexa <- bike_tire_pressures(
  rider_weight_lbs = 145,
  bike_weight_lbs = 15,
  load_lbs = 1,
  front_distribution = 0.4,
  front_tire_size_mm = 28,
  rear_tire_size_mm = 26
)

lfr_trek_lexa_plot <- display_bike_inflation(base_pressure_plot, lfr_trek_lexa)

# Nairo Quintana
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
nairo_plot <- display_bike_inflation(base_pressure_plot, nairo)

# Chris Froome
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
froome_plot <- display_bike_inflation(base_pressure_plot, froome)

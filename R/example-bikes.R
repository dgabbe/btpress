#' Create a few example bikes and inflation plots
#'
#' @return creates bike and plot objects in the Global environment
#' @export
#'
#' @examples
#' \donttest{
#' \dontrun{
#' create_example_bikes()
#' steel_sport
#' steel_sport_plot
#' }
#' }
create_example_bikes <- function() {
  bikes <- list(
    list(
      "steel_sport",
      function() {
        bike_tire_pressures(
          rider_weight_lbs = 170,
          bike_weight_lbs = 20,
          front_distribution = 0.4,
          front_tire_size_mm = 26,
          front_tire_casing_compensation = 1.15,
          rear_tire_size_mm = 28,
          rear_tire_casing_compensation = 1.15
        )
      }
    ),
    list(
      "internal_hub_shopping",
      bike_tire_pressures(
        rider_weight_lbs = 165,
        bike_weight_lbs = 35,
        load_lbs = 20,
        front_distribution = 0.5,
        front_tire_size_mm = 35,
        rear_tire_size_mm = 32,
        rear_tire_casing_compensation = 1.15
      )
    ),
    list(
      "internal_hub_fun",
      bike_tire_pressures(
        rider_weight_lbs = 165,
        bike_weight_lbs = 35,
        load_lbs = 3,
        front_distribution = 0.45,
        front_tire_size_mm = 35,
        rear_tire_size_mm = 32,
        rear_tire_casing_compensation = 1.15
      )
    ),
    list(
      "trek_lexa",
      bike_tire_pressures(
        rider_weight_lbs = 145,
        bike_weight_lbs = 15,
        load_lbs = 1,
        front_distribution = 0.4,
        front_tire_size_mm = 28,
        rear_tire_size_mm = 26
      )
    ),
    list(
      "all_roads",
      bike_tire_pressures(
        rider_weight_lbs = 170,
        bike_weight_lbs = 20,
        front_distribution = 0.4,
        front_tire_size_mm = 54,
        front_tire_casing_compensation = 1.15,
        rear_tire_size_mm = 54,
        rear_tire_casing_compensation = 1.15
      )
    ),
    list(
      "nairo",
      bike_tire_pressures(
        rider_weight_lbs = 125,
        bike_weight_lbs = 15,
        load_lbs = 1,
        front_distribution = 0.4,
        front_tire_size_mm = 28,
        front_tire_casing_compensation = 1.1,
        rear_tire_size_mm = 28,
        rear_tire_casing_compensation = 1.1
      )
    ),
    list(
      "froome",
      bike_tire_pressures(
        rider_weight_lbs = 150,
        bike_weight_lbs = 15,
        load_lbs = 1,
        front_distribution = 0.4,
        front_tire_size_mm = 28,
        front_tire_casing_compensation = 1.1,
        rear_tire_size_mm = 28,
        rear_tire_casing_compensation = 1.1
      )
    ),
    list(
      "too_heavy",
      bike_tire_pressures(
        rider_weight_lbs = 250,
        bike_weight_lbs = 25,
        load_lbs = 5,
        front_distribution = 0.4,
        front_tire_size_mm = 20,
        rear_tire_size_mm = 25
      )
    )
  )

  message("Creating the following example bikes in the Global")
  message("environment. Append '_plot' for plot object.")
  lapply(
    bikes,
    function(lst){
      message("  ", lst[1])
      assign(as.character(lst[1]), lst[2](), envir = .GlobalEnv)
      assign(
        paste(lst[1], "_plot", sep = ""),
        plot_bike_inflation(base_pressure_plot, lst[2], show_note = TRUE),
        envir = .GlobalEnv)
    }
  )
}



#' Plot and label front and rear wheel inflation data for comparing
#' 2 bike setups
#'
#' @param base_plot ggplot object of base tire pressure curves.
#' @param bike_a tibble to display for specific bike and rider.
#' @param bike_b tibble to display for specific bike and rider.
#'
#' @return ggplot object with the bikes superimposed over the base inflation plot.
#' @seealso plot_bike_inflation
#' @include generate_base_plot.R
#' @export
plot_2_bike_inflation <- function (
  base_plot = base_pressure_plot,
  bike_a,
  bike_b
  ) {
  if (missing(bike_a) || missing(bike_b)) {
    stop("One or both of bike_a and bike_b args are missing.")
  }
  label_font_size <- 4.0
  geom_point_size <- 3.5
  label_color_bike_a <- c("darkblue", "darkblue")
  label_color_bike_b <- c("black", "black")

  base_plot +
    plot_title(subtitle = "A/B Comparison") +
    ######### bike_a #########
    geom_point(
      data = bike_a$wheels,
      aes(Load, Pressure),
      shape = 8,
      size = geom_point_size,
      color = label_color_bike_a,
      inherit.aes = FALSE
    )  +
    annotate(
      "text",
      label = paste("A:", bike_a$wheels$annotation),
      size = label_font_size,
      # fontface = "bold",
      color = label_color_bike_a,
      x = bike_a$wheels$Load,
      y = bike_a$wheels$Pressure,
      vjust = -0.4
    ) +
    ######### bike_b #########
    geom_point(
      data = bike_b$wheels,
      aes(Load, Pressure),
      shape = 13,
      size = geom_point_size,
      color = label_color_bike_b,
      inherit.aes = FALSE
    )  +
    annotate(
      "text",
      label = paste("B:", bike_b$wheels$annotation),
      size = label_font_size,
      fontface = "italic",
      color = label_color_bike_b,
      x = bike_b$wheels$Load,
      y = bike_b$wheels$Pressure,
      # vjust = -0.4,
      vjust = 1,
      # hjust = 0.5
      hjust = 0
    )
}


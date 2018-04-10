#' Plot and label front and rear wheel inflation data for a bike setup
#'
#' @param base_plot ggplot object of base tire pressure curves.
#' @param bike tibble to display for specific bike and rider.
#' @param show_note boolean to show the note under the title.
#' @param note string to print under title
#'
#' @return ggplot object with the bike superimposed over the base inflation plot.
#'
#' @include generate_base_plot.R
#'
#' @export
plot_bike_inflation <- function (
  base_plot = base_pressure_plot,
  bike,
  show_note = FALSE,
  note = NULL
  ) {
  note <- if (isTRUE(show_note)) {
    if (is.null(note)) {
      paste(
        paste(bike$weights$Source, collapse = " + "), " = ",
        sum(bike$weights$Weight), "lbs | F/R %: ",
        paste(bike$wheels$distribution, collapse = "/"),
        sep = ""
      )
    }
  } else {
    paste(note)
  }

  heavy_rider_expand_limits(bike, base_plot) +
    plot_title(subtitle = note) +
    # Display first so data points can overwrite them
    geom_label(
      data = bike$messages,
      aes(label = Msg, x = x, y = y),
      fill = bike$messages$color,
      size = 4.5,
      hjust = "left",
      na.rm = TRUE,
      inherit.aes = FALSE
    ) +
    annotate(
      "text",
      label = bike$wheels$annotation,
      size = 4.0,
      fontface = "bold",
      color = bike$wheels$ggplot_color,
      x = bike$wheels$Load,
      y = bike$wheels$Pressure,
      vjust = -0.4
    ) +
    geom_point(
      data = bike$wheels,
      aes(Load, Pressure),
      shape = 8,
      size = 4,
      color = bike$wheels$ggplot_color,
      inherit.aes = FALSE
    )
}


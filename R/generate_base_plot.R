#' Generate the base plot of inflation curves for all tire sizes
#'
#' @param base_inflation the inflation data to use.
#'
#' @param plot_theme the ggplot theme to use.
#'
#' @return ggplot object
#'
#' @include plot_helpers.R
#' @include generate-inflation-curve-data.R
#' @include theme_dg_pale.R
#'
#' @import ggplot2
#' @importFrom directlabels geom_dl
#' @export
generate_base_pressure_plot <- function(
  base_inflation = generate_inflation_data(),
  plot_theme = theme_dg_pale()
) {
  tire_palette <- wesanderson::wes_palette(
    n = length(tire_sizes_mm()),
    name = "GrandBudapest2",
    type = "continuous"
  )

  ggplot(
    base_inflation,
    aes(
      wheel_load_lbs,
      tire_pressure_psi,
      group = tire_size_mm,
      color = tire_size_text
    )
  ) +
    plot_theme +
    theme(
      plot.caption = element_text(color = "#bbbbbb"),
      aspect.ratio = 0.66
    ) +
    plot_title() +
    labs(caption = "Original data from Bicycle Quarterly/Frank Berto and Jan Heine") +
    scale_x_continuous(
      name = "Wheel Load",
      breaks = seq(
        floor(min(base_inflation$wheel_load_lbs) / 10) * 10,
        ceiling(max(base_inflation$wheel_load_lbs) / 10) * 10, 10
      ),
      labels = dual_weight
    ) +
    scale_y_continuous(
      name = "Tire Pressure",
      breaks = seq(20, 160, 10),
      labels = dual_pressure
    ) +
    scale_color_manual(values = tire_palette) +
    coord_cartesian(ylim = c(20, 150)) +
    # geom_line(size = 0.75, alpha = 0.95) +
    geom_line(size = 0.85, alpha = 0.95) +
    expand_limits(x = 158, y = 190) +
    geom_dl(
      aes(label = tire_size_text),
      method = list("last.points", cex = 1.0, hjust = -0.05),
      color = "#333333"
    )
}


#' Base pressure chart
#'
#' This chart corresponds to the printed chart, updated for
#' current tire sizes. The \code{\link{plot_bike_inflation}} functions superimpose
#' the front and rear calculated pressures for a bike setup.
#'
#' @export
base_pressure_plot <- generate_base_pressure_plot()

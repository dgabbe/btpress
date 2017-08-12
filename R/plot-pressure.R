#' #' Better safety and comfort color
#' #' @keywords internal
#' recommended_pressure_color <- "#33cc33" # lime green

#' Convert PSI to Bar
#'
#'1 Psi = 0.0689475729 Bar
#'
#' @param psi
#'
#' @return bars
#' @export
psi_to_bar <- function(psi) { return(psi * 0.068947) }


#' Convert pounds to kilograms
#'
#' 1 pound = 0.45359 kilogram
#'
#' @param lb
#'
#' @return kilograms
#' @export
lb_to_kg <- function(lb) { return(lb *  0.45359) }


#' X axis label formatting function
#'
#' @param lbs
#'
#' @return Formatted string with pounds and kilograms.
#' @export
dual_weight <- function(lbs) { return(sprintf('%.0f lbs\n%.0f kg', lbs, lb_to_kg(lbs))) }

#' Y axis label formatting function.
#'
#' Used for labeling plot axis
#'
#' @param psi
#'
#' @return Formatted string with psi and bars.
#' @export
dual_pressure <- function(psi) { return(sprintf('%d psi\n%.1f bar', psi, psi_to_bar(psi))) }

#' Data point formatting function.
#'
#' @param tire_size String in the form "<integer>mm".
#' @param position Indicates which wheel. Value should be "Front" or "Rear".
#' @param psi Inflation pressure for the wheel.
#'
#' @return string similar to
#' \preformatted{
#'     28mm Front
#'  80 psi | 5.5 bar
#' }
#' @export
dual_pressure_point <- function(
  tire_size,
  position = c("Front", "Rear"),
  psi
  ) {
  return(sprintf('%dmm %s\n%d psi | %.1f bar', tire_size, position, psi, psi_to_bar(psi)))
}

#' @importFrom wesanderson wes_palette
tire_palette <- wesanderson::wes_palette(
  n = length(tire_sizes_mm),
  name = "GrandBudapest2",
  type = "continuous"
  )

#' Display a generic title or bike summary info.
#'
#' @param title Fill in...
#' @param subtitle Fill in...
#' @param summary Fill in...
#'
#' @return figure out
#' @importFrom ggplot2 ggtitle
#' @export
#'
#' @examples think about this one
plot_title <- function(
  title = "Optimized Bicycle Tire Pressure for 26, 650B, and 700C Sizes For Road & Gravel Riding",
  summary = NULL
  ) {
  ggtitle(
    title,
    subtitle = summary #, sep = if (is.null(summary))  {""} else {"\n"})
  )
}

#' @importFrom dgutils theme_dg
#' @importFrom directlabels geom_dl
#' @import ggplot2
#' @export
generate_base_pressure_plot <- function(data = inflation_data)
{
  ggplot(
    inflation_data,
    aes(
      x = wheel_load_lbs,
      y = tire_pressure_psi,
      group = tire_size_mm,
      color = tire_size_text
    )
  ) +
    #  theme_dg +
    theme_bw() + # temp until theme_dg fixed!
    theme(
      plot.subtitle = element_text(size = rel(1.1)),
      plot.caption = element_text(color = "#cccccc"),
      axis.title = element_text(face = "bold"),
      axis.text = element_text(size = rel(0.95)),
      aspect.ratio = 0.66,
      legend.position = "none" # Avoid show.legend = "FALSE" args
    ) +
    plot_title() +
    scale_x_continuous(
      name = "Wheel Load",
      breaks = seq(
        floor(min(inflation_data$wheel_load_lbs) / 10) * 10,
        ceiling(max(inflation_data$wheel_load_lbs) / 10) * 10, 10
      ),
      label = dual_weight
    ) +
    scale_y_continuous(
      name = "Tire Pressure",
      breaks = seq(20, 160, 10),
      label = dual_pressure
    ) +
    scale_color_manual(values = tire_palette) +
    coord_cartesian(ylim = c(20, 150)) +
    geom_line(size = 0.5, alpha = 0.95) +
    expand_limits(x = 158) +
    geom_dl(
      aes(label = tire_size_text),
      method = list("last.points", cex = 0.75, hjust = -0.05),
      color = "#333333"
    )
}

#' @export
base_pressure_plot <- generate_base_pressure_plot()

base_pressure_plot <- base_pressure_plot + labs(caption = "Credit to Jan Heine & Frank Berto for original work...")

#' Plot and label front and rear wheel inflation data for a bike.
#'
#' @param base_plot ggplot object of base tire pressure curves.
#' @param bike tibble to display for specific bike and rider.
#' @param show_summary Fill in....
#'
#' @return A complete plot for display
#' @export
plot_bike_inflation <- function (
  base_plot = base_pressure_plot,
  bike,
  show_summary = FALSE
  ) {
  summary <- if (isTRUE(show_summary)) {
    paste(
      paste(bike$weights$Source, collapse = " + "),
      " = ",
      sum(bike$weights$Weight),
      "lbs  F/R %: ",
      paste(bike$wheels$distribution, collapse = "/"),
      sep = ""
    )
  } else {
    NULL
  }
  b <- bike$wheels
  p <- base_plot +
    plot_title(summary = summary) +
    geom_point(
      data=b,
      aes(x = Load, y = Pressure, group = Tire_size),
      shape = 8,
      color = b$ggplot_color
    )  +
    annotate(
      "text",
      label = b$annotation,
      size = 3.5,
      fontface = "bold",
      color = b$ggplot_color,
      x = b$Load,
      y = b$Pressure,
      vjust = -0.4
    )

  return(p)
}


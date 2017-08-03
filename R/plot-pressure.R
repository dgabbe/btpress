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
  title = "Optimized Bicycle Tire Pressure for 26, 650B, and 700C Sizes",
  subtitle = "For road & gravel riding",
  summary = NULL
  ) {
  ggtitle(
    title,
    subtitle = paste(subtitle, summary, sep = if (is.null(summary))  {""} else {"\n"})
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
      color = tire_size_mm
    )
  ) +
    #  theme_dg +
    plot_title() +
    theme(aspect.ratio = 0.66) +
    theme(legend.position = "none") + # Avoid show.legend = "FALSE" args
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
    #  scale_color_brewer(name = "Tire Size (mm)", type="seq", palette = "Set3") +
    coord_cartesian(ylim = c(20, 150)) +
    geom_line(size = 0.40, alpha = 0.4) +
    expand_limits(x = 158) +
    geom_dl(
      aes(label = tire_size_text),
      method = list("last.points", cex = 0.75, hjust = -0.05),
      color = "Black"
    )
}

#' @export
base_pressure_plot <- generate_base_pressure_plot()

#' Plot and label front and rear wheel inflation data for a bike.
#'
#' @param base_plot ggplot object of base tire pressure curves.
#' @param bike tibble to display for specific bike and rider.
#' @param show.summary Fill in....
#'
#' @return A complete plot for display
#' @export
display_bike_inflation <- function (
  base_plot = base_pressure_plot,
  bike,
  show.summary = FALSE
  ) {
  return(
    base_plot +
      geom_point(
        data=bike,
        aes(x = Weight, y = Pressure, group = Tire_size),
        shape = 8,
        color = "Black"
      )  +
      annotate(
        "text",
        label = bike$annotation,
        x = bike$Weight,
        y = bike$Pressure,
        vjust = -0.4
      )
  )
}


#' Better safety and comfort color
safe_pressure_color <- "#33cc33" # lime green

#' Convert PSI to Bar
#'
#'1 Psi = 0.0689475729 Bar
#'
#' @param psi
#'
#' @return bars
#' @export
#'
psi_to_bar <- function(psi) { return(psi * 0.068947) }


#' Convert pounds to kilograms
#'
#' 1 pound = 0.45359 kilogram
#'
#' @param lb
#'
#' @return kilograms
#' @export
#'
lb_to_kg <- function(lb) { return(lb *  0.45359) }


#' X axis label formatting function
#'
#' @param lbs
#'
#' @return Formatted string with pounds and kilograms.
#' @export
#'
dual_weight <- function(lbs) { return(sprintf('%.0f lbs\n%.0f kg', lbs, lb_to_kg(lbs))) }

#' Y axis label formatting function.
#'
#' Used for labeling plot axis
#'
#' @param psi
#'
#' @return Formatted string with psi and bars.
#' @export
#'
dual_pressure <- function(psi) { return(sprintf('%d psi\n%.1f bar', psi, psi_to_bar(psi))) }

#' Data point formatting function.
#'
#' @param position Indicates which wheel. Value should be "Front" or "Rear".
#' @param psi Inflation pressure for the wheel.
#'
#' @return string similar to
#' \code{
#' Front
#' 80 psi
#' 5.5 bar
#' }
#' @export
#'
dual_pressure_point <- function(position = c("Front", "Rear"), psi) {
  return(sprintf('%s\n%d psi\n%.1f bar', position, psi, psi_to_bar(psi)))
}


base_pressure_plot <-
  ggplot(
    inflation_data,
    aes(x=wheel_load_lbs, y=tire_pressure_psi,
        group=tire_size_mm, color=tire_size_mm
    )
  ) +
  theme_dg +
  labs(title = "Optimized Bicycle Tire Pressure for 26, 650B, and 700C Sizes",
       x = "Wheel Load", y = "Tire Pressure") +
#                    theme(legend.position = c(0.08, 0.735), legend.justification = c(0, 1)) +
  theme(aspect.ratio = 0.66) +
  scale_color_brewer(name = "Tire Size (mm)", type="seq", palette = "Set3") +
  scale_x_continuous(
    breaks = seq(floor(min(inflation_data$wheel_load_lbs) / 10) * 10,
    ceiling(max(inflation_data$wheel_load_lbs) / 10) * 10, 10),
    label = dual_weight) +
  scale_y_continuous(breaks=seq(20, 160, 10), label = dual_pressure) +
  coord_cartesian(ylim = c(20, 150)) +
  annotate("rect", xmin = 66, xmax= 160, ymin = 20, ymax = 105, alpha = 0.1,
           fill = safe_pressure_color) +
  annotate("text",
           label = paste0("Better safety and comfort with pressure below 105psi"),
           x = 67, y = 99, hjust = 0, vjust = -0.9, color = safe_pressure_color) +
  geom_line(size = 0.75, show.legend = FALSE) +
  expand_limits(x = 158) +
  geom_dl(aes(label = label), method = list("last.qp", cex = 1, hjust = -0.05),
          color = "Black", show.legend = FALSE)

#' Plot and label front and rear wheel inflation data for a bike.
#'
#' @param base_plot ggplot object of base tire pressure curves.
#' @param bike data.frame to display for specific bike and rider.
#'
#' @return A complete plot for display
#' @export
#'
display_bike_inflation <- function (base_plot = base_pressure_plot, bike) {
  return(
    base_plot +
    geom_point(data=bike, aes(x=Weight, y = Pressure), color = "Black", show.legend = FALSE) +
    annotate("text", label = dual_pressure_point("Front", bike["Front","Pressure"]),
               x = bike["Front", "Weight"], y = bike["Front","Pressure"],
               vjust = -0.4) +
    annotate("text", label = dual_pressure_point("Rear", bike["Rear", "Pressure"]),
               x = bike["Rear", "Weight"], y = bike["Rear", "Pressure"],
               vjust = -0.4)
  )
}


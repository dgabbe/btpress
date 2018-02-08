#' Convert PSI to Bar
#'
#'1 Psi = 0.0689475729 Bar
#'
#' @param psi Pressure in pounds per square inch.
#'
#' @return bars
#' @export
psi_to_bar <- function(psi) { return(psi * 0.068947) }


#' Convert pounds to kilograms
#'
#' 1 pound = 0.45359 kilogram.
#'
#' @param lb weight in pounds.
#'
#' @return kilograms
#' @export
lb_to_kg <- function(lb) { return(lb *  0.45359) }


#' X axis label formatting function
#'
#' @param lbs weight in pounds.
#'
#' @return Formatted string with pounds and kilograms.
#' @export
dual_weight <- function(lbs) {
  return(sprintf('%.0f lbs\n%.0f kg', lbs, lb_to_kg(lbs)))
}


#' Y axis label formatting function
#'
#' @param psi Tire pressure.
#'
#' @return Formatted string with psi and bars.
#' @export
dual_pressure <- function(psi) {
  return(sprintf('%d psi\n%.1f bar', psi, psi_to_bar(psi)))
}


#' Data point formatting function
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
  return(
    sprintf(
      '%dmm %s\n%d psi | %.1f bar', tire_size, position, psi, psi_to_bar(psi))
  )
}


#' Display a generic title and optionally add bike summary info
#'
#' Wrapper for \code{\link[ggplot2]{ggtitle}} so you can change the
#' the title and subtitle for your application.
#'
#' @param title for the plot.
#' @param subtitle If provided, is used for the subtitle.
#'
#' @return labels
#' @import ggplot2
#' @export
plot_title <- function(
  # title = "Optimized Bicycle Tire Pressure for 26, 650B, and 700C Sizes for Road & Gravel Riding",
  title = "Optimized Bicycle Tire Pressure for Road & Gravel Riding",
  subtitle = NULL
  ) {
  ggtitle(
    title,
    subtitle
  )
}


#' Modifications to \code{theme_bw} to add a bit of color
#'
#' @param ... passed to theme_bw
#'
#' @return ggplot theme
#' @seealso \code{\link[ggplot2]{ggtheme}}
#' @import ggplot2
#' @export
theme_dg_pale <- function(...) {
  theme_bw(...) +
    theme(
      plot.title = element_text(size = rel(1.6)),
      plot.subtitle = element_text(size = rel(1.3)),
      axis.title = element_text(face = "bold"),
      axis.text = element_text(size = rel(1.1)),
      legend.position = "none" # Avoid show.legend = "FALSE" args
    )
}


#' Generate the base plot of inflation curves for all tire sizes
#'
#' @param base_inflation the inflation data to use.
#'
#' @param plot_theme the ggplot theme to use.
#'
#' @return ggplot object
#' @include generate-inflation-curve-data.R
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
#' current tire sizes. Front and rear calculated pressures
#' are superimposed over the chart.
#'
#' @export
base_pressure_plot <- generate_base_pressure_plot()


#' Plot and label front and rear wheel inflation data for a bike setup
#'
#' @param base_plot ggplot object of base tire pressure curves.
#' @param bike tibble to display for specific bike and rider.
#' @param bike2 tibble to display for specific bike and rider.
#' @param show_note boolean to show the note under the title.
#' @param note string to print under title
#'
#' @return ggplot object with the bike superimposed over the base inflation plot.
#' @export
plot_bike_inflation <- function (
  base_plot = base_pressure_plot,
  bike,
  bike2 = NULL,
  show_note = FALSE,
  note = NULL
  ) {
  note <- if (isTRUE(show_note) && is.null(bike2)) {
    paste(
      paste(bike$weights$Source, collapse = " + "), " = ",
      sum(bike$weights$Weight), "lbs | F/R %: ",
      paste(bike$wheels$distribution, collapse = "/"),
      sep = ""
    )
  } else if (! is.null(bike2)) {
    paste("A/B Comparison")
  } else { NULL }

  p <- base_plot +
    plot_title(subtitle = note) +
    geom_point(
      data = bike$wheels,
      aes(Load, Pressure),
      shape = 8,
      size = 4,
      color = bike$wheels$ggplot_color,
      inherit.aes = FALSE
    )  +
    annotate(
      "text",
      label = bike$wheels$annotation,
      size = 4.5,
      fontface = "bold",
      color = bike$wheels$ggplot_color,
      x = bike$wheels$Load,
      y = bike$wheels$Pressure,
      vjust = -0.4
    )

  if (is.null(bike2)) {
    p + geom_label(
      data = bike$messages,
      aes(label = Msg, x = x, y = y),
      fill = bike$messages$color,
      hjust = "left",
      na.rm = TRUE,
      inherit.aes = FALSE
    )
  } else {
    p +
      geom_point(
        data = bike2$wheels,
        aes(Load, Pressure),
        shape = 13,
        size = 4,
        color = bike2$wheels$ggplot_color,
        inherit.aes = FALSE
      )  +
      annotate(
        "text",
        label = bike2$wheels$annotation,
        size = 4.5,
        fontface = "bold.italic",
        color = bike2$wheels$ggplot_color,
        x = bike2$wheels$Load,
        y = bike2$wheels$Pressure,
        vjust = -0.4
      )
  }
  # return(p)
}


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

# expand left side of scale when front wheel load < 70lbs
# get code from desktop!!

#' rider_expand_limits
#'
#' Wheel loads at extremes need to expand the plot area to prevent
#' labels from being clipped.
#'
#' @param bike setup to be plotted
#'
#' @return ggplot object
#' @export
#'
rider_expand_limits <- function(bike) {
  new_limits <- list()
  max_psi <- max(bike$wheels$Pressure)
  max_load <- max(bike$wheels$Load)
  min_load <- min(bike$wheels$Load)

  if ( max_psi > max_tire_psi) {
    new_limits <- c(new_limits, expand_limits(y = max_psi + 10 ))
  }

  if (min_load < x_min_wheel_load) {
    new_limits <- c(new_limits, expand_limits(x = x_min_wheel_load - 5))
  }

  if (max_load > 152 && max_load <= x_max_wheel_load) {
    new_limits <- c(new_limits, expand_limits(x = x_max_wheel_load + 5))
  } else if (max_load > x_max_wheel_load) {
    new_limits <- c(new_limits, expand_limits(x = x_max_wheel_load + 5 + (max_load - x_max_wheel_load)))
  }
  return(new_limits)
}

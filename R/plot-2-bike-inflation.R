#' Plot and label front and rear wheel inflation data for comparing
#' 2 bike setups
#'
#' @param base_plot ggplot object of base tire pressure curves.
#' @param bike_a tibble to display for specific bike and rider.
#' @param bike_b tibble to display for specific bike and rider.
#' @param images vector of images to display for points.  Order of images is
#'   bike_a, bike_b.
#'
#' @return ggplot object with the bikes superimposed over the base inflation plot.
#' @seealso plot_bike_inflation
#' @include generate_base_plot.R
#' @importFrom ggimage geom_image
#' @export
plot_2_bike_inflation <- function (
  base_plot = base_pressure_plot,
  bike_a,
  bike_b,
  images = NULL
  ) {
  if (missing(bike_a) || missing(bike_b)) {
    stop("One or both of bike_a and bike_b args are missing.")
  }

  use_icon <- ifelse(!is.null(images), TRUE, FALSE)

  if (use_icon && length(images) != 2) {
    stop("images arg requires vector of 2 elements")
  }

  label_font_size <- 4.0
  geom_point_size <- 3.5
  label_color_bike_a <- c("darkblue", "darkblue")
  label_color_bike_b <- c("black", "black")

  # Temp code for proof of concept
  # images <- c("file:///Users/dgabbe/_git/R/btpressapp/www/images/NYCS-bull-trans-A-20px.png",
  #             "file:///Users/dgabbe/_git/R/btpressapp/www/images/NYCS-bull-trans-B-20px.png")

  bike_a$wheels <- tibble::add_column(bike_a$wheels, Image = c(images[1], images[1]))
  bike_b$wheels <- tibble::add_column(bike_b$wheels, Image = c(images[2], images[2]))

  base_plot +
    plot_title(subtitle = "A/B Comparison") +
    ######### bike_a #########
  {if (use_icon) {
    geom_image(
      data = bike_a$wheels,
      aes(Load, Pressure, image = Image),
      # by = "width",
      # color = "blue",
           size = 0.05,
      inherit.aes = FALSE
    )
  } else {
    geom_point(
      data = bike_a$wheels,
      aes(Load, Pressure),
      shape = 8,
      size = geom_point_size,
      color = label_color_bike_a,
      inherit.aes = FALSE
    )
  }
  } +
  {    if (use_icon) {
      annotate(
        "text",
        label = bike_a$wheels$annotation,
        size = label_font_size,
        # fontface = "bold",
        color = label_color_bike_a,
        x = bike_a$wheels$Load,
        y = bike_a$wheels$Pressure,
        vjust = -0.4
      )
  } else {
    annotate(
      "text",
      label = paste("A:", bike_a$wheels$annotation),
      size = label_font_size,
      # fontface = "bold",
      color = label_color_bike_a,
      x = bike_a$wheels$Load,
      y = bike_a$wheels$Pressure,
      vjust = -0.4
    )
  }
  } +
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


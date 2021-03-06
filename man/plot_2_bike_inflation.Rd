% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot-2-bike-inflation.R
\name{plot_2_bike_inflation}
\alias{plot_2_bike_inflation}
\title{Plot and label front and rear wheel inflation data for comparing
2 bike setups}
\usage{
plot_2_bike_inflation(base_plot = base_pressure_plot, bike_a, bike_b,
  images = NULL)
}
\arguments{
\item{base_plot}{ggplot object of base tire pressure curves.}

\item{bike_a}{tibble to display for specific bike and rider.}

\item{bike_b}{tibble to display for specific bike and rider.}

\item{images}{vector of images to display for points.  Order of images is
bike_a, bike_b.}
}
\value{
ggplot object with the bikes superimposed over the base inflation plot.
}
\description{
Plot and label front and rear wheel inflation data for comparing
2 bike setups
}
\seealso{
plot_bike_inflation
}

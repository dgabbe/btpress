#' btpress
#'
#' If you were told that you could bicycle faster and more comfortablely simply
#' by changing your bike tire pressure, would you try it? There are now 2
#' independent studies that support lower pressures are significantly better
#' than pumping up your tires until they are rock hard.
#' See the References section for articles.
#'
#' @section Pump Inaccuracies:
#'
#' Pump gauges considerably inaccurate. Parallex viewing makes precise reading
#' of needle impossible. Never mind the pressure sensing mechanism has a wide tolerance.
#'
#' @section Rim Widths:
#'
#' The original research was conducted when internal widths for road rims were around 19mm.
#' Today's rims are available in wider sizes, 23 - 25mm, increasing the volume up to 33\%.
#' This program does not use internal rim width in its calculations.
#'
#' @section Weight vs. Load:
#'
#' At the end of the day, these two are effectively the same.  That said,
#' \emph{Weight} is used for the individual components that go into the calculations.
#' \emph{Load} is used
#' to describe the forces the tires are subject to.
#'
#' @section Directions for Use:
#'
#' Extra light casings need an extra 10-15\% pressure to prevent the casing threads
#' from breaking.
#'
#' There are other subtlies which are not explicitly taken into account. The
#' biggest one is weight carried on the rider. For example, if your bike lock is
#' carried on you, it should be added to the rider weight, not the load field.
#' Same for a backpack.  Carrying weight on front and rear racks is not
#' considered by the program.
#'
#' Snow tires and thick sidewalled tires are supported by their sidewalls and do
#' not respond to pressure changes the way performace tires do.
#'
#' @section References:
#' Links to articles:
#'
#' \itemize{
#'   \item \href{https://janheine.wordpress.com/2010/10/18/science-and-bicycles-1-tires-and-pressure/}{Science and Bicycles 1: Tires and Pressure}
#'   \item \href{https://janheine.wordpress.com/2015/01/26/the-tire-pressure-revolution/}{The Tire Pressure Revolution}
#'   \item \href{https://janheine.wordpress.com/2015/02/17/tire-pressure-data-and-details/}{Tire Pressure: Data and Details}
#'   \item \href{https://silca.cc/blogs/journal/115178628-road-to-roubaix-the-complete-story}{Silca - Road to Roubaix - The Complete Story}
#'   \item \href{https://silca.cc/blogs/journal/118397252-tire-size-pressure-aero-comfort-rolling-resistance-and-more-part-1-how-we-got-to-now}{Tire Size, Pressure, Aero, Comfort, Rolling Resistance and More. Part 1: How we Got to Now}. There five parts in this series.
#'   \item \href{https://www.compasscycle.com/wp-content/uploads/2015/03/BQTireDrop.pdf}{Bicycle Quarterly article}
#'   \item \href{https://www.hedcycling.com/blog/road-tire-pressure-for-plus-and-black-wheels/}{Road Tire Pressure For Plus And BLACK Wheels}
#'   \item \href{http://trstriathlon.com/talking-tires-with-joshua-poertner/}{Tire Pressure – Stop Guessing And Read The Science}
#' }
#'
#' @section Acknowledgements:
#'
#' Source for data and pratical application to Jan Heine and Frank Berto
#' published in \href{https://www.compasscycle.com/wp-content/uploads/2015/03/BQTireDrop.pdf}{Bicycle Quarterly}.
#'
#' The emperical curve fitting formula from the
#' \href{http://www.biketinker.com/2010/bike-resources/optimal-tire-pressure-for-bicycles/}{BikeTinker}.
#'
#' @section Full Disclosure:
#'
#' I ride and recommend
#' \href{https://www.compasscycle.com/product-category/components/tires/}{Compass Bicycle tires}
#' and subscribe to \href{https://www.bikequarterly.com/}{\emph{Bicycle
#' Quarterly}}. I received no compensation for this program nor was I asked to
#' write it by anyone.
#'
#' @section Disclaimer:
#'
#' Biking riding is an inheritly risky activity. Remember the bike racer's
#' motto: \emph{Falling is a matter of 'when', not 'if'.} You are solely
#' responsible for not exceeding any limits including, but not exclusive of
#' maximum tire inflation pressure, rim inflation pressure, mininum tire
#' clearance, and compatibility of tubeless tire and rim combinations. Use of
#' this app is at your risk and you assume all liabilities.
#'
#' @docType package
#' @name btpress
NULL
# To-do List:

# Create new theme for Shiny apps & pass in as a parameter to generate-base-plot()!

# Write test cases for error checking in bike_tire_pressures

# tire pressures great than 150psi are not displayed on the chart - try expand_limit.

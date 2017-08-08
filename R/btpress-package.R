#' btpress
#'
#' If you were told that you could bicycle faster and more comfortablely simply
#' by changing your bike tire pressure, would you try it? There are now 2
#' independent studies that support lower pressures are significantly better
#' than pumping up your tires until they are rock hard.  See the References
#' section for links.
#'
#' @section Directions for Use:
#'
#' Extra light casings need an extra 10-15\% pressure to prevent the casing threads from breaking.
#'
#' @section How to Update Tire Sizes:
#'
#' Update \code{generate_inflation_curve_data.R} for new tire sizes and wheel loads and rebuild package.
#'
#' @section References:
#' Links to articles:
#'
#' \itemize{
#'   \item fill in
#'   \item fill in
#'   \item fill in
#'   \item fill in
#' }
#' Bicycle Quarterly blogs
#' Silca.cc - Josh's articles
#'
#' @section Acknowledgements:
#' Source for data and pratical application to Jan Heine and Frank Berto
#' published in \href{http://www.bikequarterly.com/images/BQTireDrop.pdf}{Bike
#' Quarterly}.
#'
#' The emperical curve fitting formula from the
#' \href{http://www.biketinker.com/2010/bike-resources/optimal-tire-pressure-for-bicycles/}{BikeTinker}.
#'
#' @section Full Disclosure:
#'
#' I ride and recommend Compass Bicycle
#' \href{https://www.compasscycle.com/product-category/components/tires/}{tires}
#' and subscribe to \href{https://www.bikequarterly.com/}{\emph{Bicycle
#' Quarterly}}. I received no compensation for this program nor was I asked to
#' write it by anyone.
#'
#' @section Disclaimer:
#' Biking riding is an inheritly risky activity. Remember the bike racer's motto: Falling is a matter of
#' 'when', not 'if'. You are solely responsible for not extending any load limits including, but not
#' exclusive of maximum tire inflation pressure, rim inflation pressure, mininum tire clearance, and
#' compatibility of tubeless tire and rim combinations.
#' Use of this app is at your risk and you assume all liabilities.
#'
#' @section Improvements:
#' \itemize{
#'   \item RColorBrewer has limititations on the number of colors for the different palette settings.
#'  Figure out how to test for that to prevent run-time error or different way of computing the color
#'  palette.
#'
#'  \item Figure out better sample/example.  May be graph tire pressure & bike data in 2 columns.
#' }
#'
#' @docType package
#' @name btpress
NULL
# To-do List:

# Review @return tags - needed or not for simple functions?

# rebuild dgutils to pick up scaling fix in ggplot2 2.0.0

# Write test cases for error checking in bike_tire_pressures

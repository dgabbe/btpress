#' btpress
#'
#' A program to calculate optimized bicycle tire pressure based on research that
#' found a small sag or droop in the profile of the tire lead to better
#' performance and comfort.
#'
#' Image that you could ride one gear faster or feel less fatigued at the end of
#' your ride and it cost you nothing. Tuning your bike tire pressue to you, your
#' bike, and your load may do just that. It all depends on wider bike tires with
#' flexible sidewalls.
#'
#' Riding one gear higher, depending on your gearing, is a 5 - 8\% increase.
#' There are now 2 independent studies that support lower pressures are
#' significantly better than pumping up your tires until they are rock hard. See
#' the References section for articles.
#'
#' @section Directions for Use:
#'
#'   The first step is evaluating whether your tires have flexible sidewalls
#'   which will respond readily to tire pressure changes. Tires marketed as
#'   racing tires, marketed as having a casing from a tubular tire, used by
#'   professional racers, or are a folding tire are good candidates. On the
#'   other hand, puncture resistant tires,
#'   \href{snow tires}{https://edsasslercoaching.com/product-reviews/nokian-a10-studded-winter-tires/},
#'   and thick touring tires are supported by their sidewalls and do not
#'   respond to pressure changes very well.
#'
#'   The simplest way to calculate your tire pressure is to use the
#'   \href{companion web app}{http://btp.frame38.com}, which uses this package.
#'
#'   To calculate your tire pressures execute this code sequence:
#'   ```{r eval=FALSE}
#'   my_bike <- bike_tire_pressures() # Supply your values for the parameters
#'   plot_bike_inflation(bike = my_bike)
#'   ```
#'   If a test ride indicates that the tire pressure is really too low, it's
#'   likely your pressure gauge is reading too high. Try increasing your
#'   pressure by 10psi.  Remember this is not an exact science nor setting so
#'   some experimentation may be needed.
#'
#'   Extra light casings need an extra 10-15\% pressure to prevent the casing
#'   threads from breaking.
#'
#'   Let's say your trials indicate a performance improvement and you'd like to
#'   \href{explore other tire options}{https://janheine.wordpress.com/2017/06/21/choosing-your-tires/},
#'    or it's simply time for new tires. A wider tire is a great option to
#'   \href{consider}{https://janheine.wordpress.com/2013/03/12/how-wide-a-tire-can-i-run/}.
#'   The following code compares 2 setups and builds upon the first example.
#'   ```{r eval=FALSE}
#'   new_tires <- bike_tire_pressures() # Supply new tires for the parameters
#'   plot_2_bike_inflation(bike_a = my_bike, bike_b = new_tires)
#'   ```
#' @section Choosing Between Bike and Load Weights:
#'
#'  Bikes are for transporting stuff around, but where your stuff is attached
#' will impact bike handling. Increasing load weight decreases some
#'  aspect of handling stability.
#'
#'
#'   There are 2 cases for the load which need to be handled manually. The first
#'   is weight carried on the rider. For example, if your bike lock is carried
#'   on you, it should be added to the rider weight parameter, not the load
#'   parameter. Same for a backpack.
#'
#'   The second is a load on both the front and rear racks. It's unwise to
#'   assume a front/rear weight distribution. My recommendation is to measure
#'   the distribution on a level surface.  A bathroom scale placed under one
#'   wheel and a spacer block the same height as the scale placed under the
#'   other wheel.  Load up the bike, hop on, and have a helper steady you and
#'   read the numbers. Flip the bike around and meaure the other wheel.  Divide
#'   the front weight by the rear weight and use that for the
#'   `front_distribution` parameter.
#'
#' @section Rim Widths:
#'
#'   The original research was conducted when internal widths for road rims were
#'   around 19mm. Today's rims are available in wider sizes, 23 - 25mm,
#'   increasing the volume up to 33\%. This program does not use internal rim
#'   width in its calculations.
#'
#' @section Pump Gauge Inaccuracies - Simple:
#'
#'   Built-in pump gauges are inaccurate. Between a wide tolerance range of the
#'   pressure sensing mechanism and imprecise reading of the gauge needle due to
#'   parallex, the indicated pressure should be considered an approximation.
#'
#'   A simple experiment can help determine how your pump is reading.  Inflate
#'   your tires to the calculated pressure plus another 15psi.  If a test ride
#'   seems harsher or your bike bounces around more, the pressure is too high.
#'   Repeat, but this time inflate to 15psi less than the calculated pressure.
#'   If your wheels bottom out or the handling is squishly, the pressure is too
#'   low.  Adjust in increments of 5psi and repeat until satisfied.
#'
#' @section Pump Gauge Inaccuracies - Advanced:
#'
#' @section Heavy Riders, Tandems, and Cargo Bikes:
#'
#' @section Weight vs. Load:
#'
#'   At the end of the day, these two are effectively the same.  That said,
#'   \emph{Weight} is used for the individual components that go into the
#'   calculations. \emph{Load} is used to describe the forces the tires are
#'   subject to.
#'
#' @section References:
#'
#'   \itemize{
#'     \item
#'   \href{Science and Bicycles 1: Tires and Pressure}{https://janheine.wordpress.com/2010/10/18/science-and-bicycles-1-tires-and-pressure/}
#'      \item
#'   \href{The Tire Pressure Revolution}{https://janheine.wordpress.com/2015/01/26/the-tire-pressure-revolution/}
#'      \item
#'   \href{Tire Pressure: Data and Details}{https://janheine.wordpress.com/2015/02/17/tire-pressure-data-and-details/}
#'      \item \href{Why Wider Tires Corner Better}{https://janheine.wordpress.com/2015/11/19/why-wider-tires-corner-better/}
#'      \item
#'   \href{Compass Bon Jon Pass 700C x 35 in Top 5 Fastest Tires in the World}{https://janheine.wordpress.com/2018/01/31/one-of-the-5-fastest-tire-in-the-world/}
#'      \item
#'   \href{Silca - Road to Roubaix - The Complete Story}{https://silca.cc/blogs/journal/115178628-road-to-roubaix-the-complete-story}
#'      \item Part one,
#'   \href{Tire Size, Pressure, Aero, Comfort, Rolling Resistance and More. Part 1: How We Got to Now}{https://silca.cc/blogs/journal/118397252-tire-size-pressure-aero-comfort-rolling-resistance-and-more-part-1-how-we-got-to-now}, of a five part series.
#'     \item The original
#'    \href{Bicycle Quarterly article}{https://www.compasscycle.com/wp-content/uploads/2015/03/BQTireDrop.pdf}
#'      \item
#'   \href{Road Tire Pressure For Plus And BLACK Wheels}{https://www.hedcycling.com/blog/road-tire-pressure-for-plus-and-black-wheels/}
#'      \item
#'   \href{Tire Pressure – Stop Guessing And Read The Science}{http://trstriathlon.com/talking-tires-with-joshua-poertner/}
#'   }
#'
#' @section Acknowledgements:
#'
#'   Source for data and pratical application to Jan Heine and Frank Berto
#'   published in
#'   \href{Bicycle
#'    Quarterly}{https://www.compasscycle.com/wp-content/uploads/2015/03/BQTireDrop.pdf}.
#'
#'   The emperical curve fitting formula from the
#'   \href{BikeTinker}{http://www.biketinker.com/2010/bike-resources/optimal-tire-pressure-for-bicycles/}.
#'
#' @section Disclaimer:
#'
#'   Biking riding is an inheritly risky activity. Remember the bike racer's
#'   motto: \emph{Falling is a matter of 'when', not 'if'.} You are solely
#'   responsible for not exceeding any limits including, but not exclusive of
#'   your abilities, maximum tire inflation pressure, rim inflation pressure,
#'   mininum tire clearance, and compatibility of tubeless tire and rim
#'   combinations. Use of this app is at your risk and you assume all
#'   liabilities.
#'
#' @section Full Disclosure:
#'
#'   I ride and recommend
#'   \href{Compass
#'    Bicycle tires}{https://www.compasscycle.com/product-category/components/tires/} and subscribe to
#'   \emph{\href{Bicycle Quarterly}{https://www.bikequarterly.com/}}. I received
#'   no compensation for this program.
#'
#' @docType package
#' @name btpress-package
NULL
# To-do List:

# Write test cases for error checking in bike_tire_pressures

# tire pressures great than 150psi are not displayed on the chart - try expand_limit.

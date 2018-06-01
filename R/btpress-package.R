#' btpress
#'
#' A program to calculate optimized bicycle tire pressure based on research that
#' found a small sag or droop in the profile of the tire, led to better
#' performance and comfort.
#'
#' Imagine that you could ride one gear faster or feel less fatigued at the end
#' of your ride and it cost you nothing. Tuning your bike tire pressure to your
#' own unique situation may do just that. There are now 2 independent studies
#' that support lower pressures are significantly better than pumping up your
#' tires until they are rock hard. It all depends on wider bike tires with
#' flexible sidewalls. Riding one gear higher, depending on your gearing,
#' is a 5 - 8\% increase.
#'
#' @section Directions for Use:
#'
#'   The first step is evaluating whether your tires have flexible sidewalls
#'   which will respond readily to tire pressure changes. Tires marketed as
#'   racing tires, marketed as having a casing from a tubular tire, used by
#'   professional racers, or are a folding tire are good candidates. On the
#'   other hand, puncture resistant tires,
#'   \href{https://edsasslercoaching.com/product-reviews/nokian-a10-studded-winter-tires/}{snow tires},
#'   and thick touring tires are supported by their sidewalls and do not
#'   respond to pressure changes very well.
#'
#'   The simplest way to calculate your tire pressure is to use the
#'   \href{http://btp.frame38.com}{companion web app}, which uses this package.
#'
#'   To calculate your tire pressures, execute this code sequence:
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
#'   Suppose your trials indicate a performance improvement and you'd like to
#'   \href{https://janheine.wordpress.com/2017/06/21/choosing-your-tires/}{explore other tire options},
#'    or it's simply time for new tires. A wider tire is a great option to
#'   \href{https://janheine.wordpress.com/2013/03/12/how-wide-a-tire-can-i-run/}{consider}.
#'   The following code compares 2 setups and builds upon the first example.
#'   ```{r eval=FALSE}
#'   new_tires <- bike_tire_pressures() # Supply new tires for the parameters
#'   plot_2_bike_inflation(bike_a = my_bike, bike_b = new_tires)
#'   ```
#' @section Choosing Between Bike and Load Weights:
#'
#'   Bikes are for transporting gear around, but where your gear is attached
#'   will impact bike handling. Increasing load weight decreases handling
#'   stability. While your bike weight remains constant, your cargo weight could
#'   vary from 0 to 20lbs and that will change tire pressure quite a bit.
#'
#'   Calculating how your load is distributed between both wheels depends on
#'   factors unique to each bike that it is best to measure them.  We can
#'   generalize about standard configurations and the following example will
#'   highlight the limitations.
#'
#'   Example coming soon!
#'
#'   If the rider is carrying a bike lock or backpack,
#'   their weight should be added to the rider weight, not the load weight.
#'
#'   It's unwise to assume a front/rear weight distribution when there are loads
#'   on both the front and rear racks.  My recommendation is to measure the
#'   distribution on a level surface.  Place a bathroom scale under one wheel
#'   and a spacer block, the same height as the scale, under the other
#'   wheel.  Load up the bike, hop on, and have a helper steady you and read the
#'   numbers. Flip the bike around and measure the other wheel.  Divide the front
#'   weight by the rear weight and use that for the `front_distribution`
#'   parameter.
#'
#' @section Rim Widths:
#'
#'   The original research was conducted when internal widths for road rims were
#'   around 19mm. Today's rims are available in wider sizes, 23 - 25mm,
#'   increasing the volume up to 33\%. For these rims, measure the tire width with a
#'   digital or analog caliper and use that value for the tire width parameters.
#'
#'
#' @section Pump Gauge Inaccuracies - Simple:
#'
#'   Built-in pump gauges are inaccurate. Between a wide tolerance range of the
#'   pressure-sensing mechanism and imprecise reading of the gauge needle due to
#'   parallex, the indicated pressure should be considered an approximation.
#'
#'   A simple experiment can help determine how your pump is reading.  Inflate
#'   your tires to the calculated pressure plus another 15psi.  If a test ride
#'   seems harsher or your bike bounces around more, the pressure is too high.
#'   Repeat, but this time inflate to 15psi less than the calculated pressure.
#'   If your wheels bottom out or the handling is squirmy, the pressure is too
#'   low.  Adjust in increments of 5psi and repeat until satisfied.
#'
#'   For road tubeless setups, exceeding 60psi seems to increase the likelihood
#'   of a tire blowoff as nicely summarized in this
#'   \href{https://janheine.wordpress.com/2017/05/29/the-trouble-with-road-tubeless/}{post}.
#'
#' @section Pump Gauge Inaccuracies - Advanced:
#'
#'   Under development...
#'
#' @section Tire Mounting Instructions:
#'
#' If using an inner tube, inflate it so it barely holds its shape and lightly
#' coat with talc (talcum power). Then sprinkle some talc on the inside of the tire
#' casing to coat the entire surface.  Flip the tire inside out if you find it's
#' easier to apply that way.  This proceedure is mandatory for latex and light
#'  weight butyl tubes.
#'
#'  Then follow Sven Cycles \href{https://www.svencycles.com/blog/compass-tyre-mounting-instructions/}{marvelous instructions}.
#'
#' @section Heavy Riders, Tandems, and Cargo Bikes:
#'
#'   Under development...
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
#'   \href{https://janheine.wordpress.com/2010/10/18/science-and-bicycles-1-tires-and-pressure/}{Science and Bicycles 1: Tires and Pressure}
#'      \item
#'   \href{https://janheine.wordpress.com/2015/01/26/the-tire-pressure-revolution/}{The Tire Pressure Revolution}
#'      \item
#'   \href{https://janheine.wordpress.com/2015/02/17/tire-pressure-data-and-details/}{Tire Pressure: Data and Details}
#'      \item \href{https://janheine.wordpress.com/2015/11/19/why-wider-tires-corner-better/}{Why Wider Tires Corner Better}
#'      \item
#'   \href{https://janheine.wordpress.com/2018/01/31/one-of-the-5-fastest-tire-in-the-world/}{Compass Bon Jon Pass 700C x 35 in Top 5 Fastest Tires in the World}
#'      \item
#'   \href{https://silca.cc/blogs/journal/115178628-road-to-roubaix-the-complete-story}{Silca - Road to Roubaix - The Complete Story}
#'      \item Part one,
#'   \href{https://silca.cc/blogs/journal/118397252-tire-size-pressure-aero-comfort-rolling-resistance-and-more-part-1-how-we-got-to-now}{Tire Size, Pressure, Aero, Comfort, Rolling Resistance and More. Part 1: How We Got to Now}, of a five part series.
#'     \item The original
#'    \href{https://www.compasscycle.com/wp-content/uploads/2015/03/BQTireDrop.pdf}{\emph{Bicycle Quarterly} article}
#'      \item
#'   \href{https://www.hedcycling.com/blog/road-tire-pressure-for-plus-and-black-wheels/}{Road Tire Pressure For Plus And BLACK Wheels}
#'      \item
#'   \href{http://trstriathlon.com/talking-tires-with-joshua-poertner/}{Tire Pressure – Stop Guessing And Read The Science}
#'   }
#'
#' @section Acknowledgments:
#'
#'   Source for data and pratical application to Jan Heine and Frank Berto
#'   published in
#'   \emph{\href{https://www.compasscycle.com/wp-content/uploads/2015/03/BQTireDrop.pdf}{Bicycle Quarterly}}.
#'
#'   The empirical curve fitting formula from the
#'   \href{http://www.biketinker.com/2010/bike-resources/optimal-tire-pressure-for-bicycles/}{BikeTinker}.
#'
#' @section Disclaimer:
#'
#'   Biking riding is an inherently risky activity. Remember the bike racer's
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
#'   \href{https://www.compasscycle.com/product-category/components/tires/}{Compass  Bicycle tires} and subscribe to
#'   \emph{\href{https://www.bikequarterly.com/}{Bicycle Quarterly}}. I received
#'   no compensation for this program.
#'
#' @docType package
#' @name btpress-package
NULL


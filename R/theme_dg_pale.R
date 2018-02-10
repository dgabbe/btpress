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

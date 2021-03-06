% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_lslog.R
\name{plot.lslog}
\alias{plot.lslog}
\title{Plot Logistic Load Shape}
\usage{
\method{plot}{lslog}(
  x,
  case = 1,
  col = c(1, 2),
  scatter = FALSE,
  legend = TRUE,
  leg_pos = "topright",
  ... = NULL
)
}
\arguments{
\item{x}{An object of class \code{lslog}, created by
\code{\link{lslog}} function.}

\item{case}{A numeric value from \{1, 2, 3\} to select
the type of plot. See "Details".}

\item{col}{Color of the plots. Can be numeric or
text or mixed as in \code{\link{col}}. For
\code{length(col) < 2}, a default second color is used.}

\item{scatter}{Logical. Scatter plot if \code{TRUE},
line plot if \code{FALSE}.}

\item{legend}{Logical indicating if legend to be displayed.}

\item{leg_pos}{A text value for position/location
of the legend. Default is \code{topright}.
See \code{\link{legend}} for full list
of keywords.}

\item{...}{\code{NULL}. Used for S3 generic/method consistency.}
}
\value{
\code{NULL}.
}
\description{
Plot method of \code{lslog} object
}
\details{
If \code{scatter = FALSE}
then per unit load duration curve for \code{case = 1},
per unit load for \code{case = 2}, actual load (in original
unit) for \code{case = 3}. If \code{scatter = TRUE}
then  per unit scatter plot for \code{case = 1 or 2},
actual load scatter plot for \code{case = 3}.
}
\examples{
loads <- ercot[ercot$Year == 2019, ]$COAST
loads <- ercot[ercot$Year == 2019, ]$COAST
log_loadshape <- lslog(loads, target_lf = 0.5,
                       inf_pos = 0.3, k = 0.8)
# --------------
plot(log_loadshape, col = c(2, 4))
plot(log_loadshape, case = 2, col = c(2, 4))
plot(log_loadshape, case = 3,
     col = c("salmon", "deepskyblue"),
     leg_pos = "topleft")




}

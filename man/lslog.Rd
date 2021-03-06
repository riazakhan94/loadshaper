% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/shaper_log.R
\name{lslog}
\alias{lslog}
\title{Logistic Method for Matching Peak and Load Factor}
\usage{
lslog(
  x,
  target_max = 10000,
  target_lf = 0.7,
  k = 1,
  inf_pos = 0.5,
  iter = 500,
  def_l = 1
)
}
\arguments{
\item{x}{A numeric array, representing reference load shape.
All values must be strictly positive containing no \code{NA}(s).
The length of \code{x}
must be > 167.}

\item{target_max}{Target peak value of resultant load shape, must
be > 0.}

\item{target_lf}{Target load factor of resultant load shape, must be
numeric in between 0 and 1 (exclusive).}

\item{k}{Steepness parameter, must be a  positive number.
See "Details".}

\item{inf_pos}{Inflection point parameter.
See "Details".}

\item{iter}{Number of iterations for solving certain parameter.
Must be  >= 30.
See "Details".}

\item{def_l}{Start parameter for solving \code{l}, must be
a positive numeric.}
}
\value{
A list of class \code{"lslog"}, having following elements:
\itemize{

\item{\code{df}: A data frame. See "Details".}

\item{\code{k}: Steepness parameter. See "Details".}

\item{\code{inf_pos}: Inflection point parameter.
See "Details".}


\item{\code{L}: Numerically solved optimized L parameter.
 See "Details".}


\item{\code{max_mult}: Maximum of the multipliers.}
\item{\code{min_mult}: Minimum of the multipliers.}
\item{\code{base_load_factor}: Load factor of the reference load
shape \code{x}.}

\item{\code{target_load_factor}: Target load factor.}
\item{\code{derived_load_factor}: Load factor of the derived load shape
(\code{object$df$y}).}
\item{\code{base_max}: Peak value of the base load shape, \code{x}}
\item{\code{target_max}: Target peak value of the new load shape.}
\item{\code{derived_max}: Peak value of the derived load shape
 (\code{object$df$y}) }

\item{\code{base_min}: Minimum value of the base load shape, \code{x}}
\item{\code{derived_min}: Minimum value of the derived load shape
 (\code{object$df$y}) }

\item{\code{dec_flag}: A logical flag  stating
whether the multipliers resulted in strictly decreasing values.
\code{TRUE} indicates the order was not preserved.
Only applicable for \code{target_max} > \code{base_max}.
See "Details".}
\item{\code{lf_flag}: A logical flag indicating if the
load factor of the derived shape differs from the target
by more than 1\%.
}
\item{\code{min_pu_flag}: A logical flag indicating existence of
negative values in the derived load shape. \code{TRUE} indicates
the existence of negative values.
Only applicable for \code{target_max} < \code{base_max}.
See "Details".}


}
}
\description{
Logistic Method for Matching Peak and Load Factor
}
\details{
The algorithm first evaluates the load factor of the
reference load shape \code{x}, which is
defined by the ratio of average to peak value. If the target load
factor is greater than reference level, then all base
values are multiplied by a number \code{ > 1}. If the target
load factor is less than reference level, then all base values are
multiplied by a number \code{ < 1}. The multipliers
increase or decrease with a sigmoid pattern.

The sigmoid function is a transformed version of
\deqn{
f(x)=\frac{L}{1 - exp(-k(x-x_0))}
}
Parameter \eqn{k} is shape parameter, shaping the
"sigmoidness" of the function. Larger value of \code{k}
indicates  more steepness in the function and lower value
results in changes in multipliers in more linear fashion.

Location parameter \eqn{x_0} controls the inflection point
of the function and derived from \code{inf_pos}.
\code{inf_pos = 0.5} indicates the inflection point of
the sigmoid multipliers is halfway.

The \eqn{L} parameter in the sigmoid is numerically solved.
The number of iterations is equal to the \code{iter} argument,
optimized based on the minimum difference between the derived
and target load factor.












The return object contains a data frame \code{df}, having the
following columns:
\itemize{

\item{\code{x_index}: An index given to the original load
shape \code{x}, starting from 1 to \code{length(x)}}.

\item{\code{x}: The original array \code{x}, unaltered.}

\item{\code{x_rank}: The rank of the data points of the
given array \code{x}, from 1 for the peak to
\code{length(x)} for the lowest value.}

\item{\code{x_ordered}: Sorted \code{x} (largest to smallest).}
\item{\code{x_pu}: Per unit \code{x}, derived by diving \code{x}
by \code{max(x)}}.

\item{\code{x_ordered_pu}: Per unit \code{x}, sorted from largest
to smallest.}


\item{\code{mult}: Derived multipliers, would be applied to
sorted per unit \code{x}.}


\item{\code{y_ordered_pu}: Product of per unit sorted \code{x}
and \code{mult}.}


\item{\code{y_ordered_pu2}: \code{y_ordered_pu}, sorted again,
in case \code{y_ordered_pu} does not become decreasing.}


\item{\code{y_pu}: Resultant load shape in per unit. This is
derived by re-ordering \code{y_ordered_pu2} with respect to their
original rank.}


\item{\code{y}: Resultant load shape. This is derived by
multiplying \code{y_pu} by \code{taget_max} / \code{base_max}
}



}
}
\examples{
loads <- ercot[ercot$Year == 2019, ]$COAST
plot(loads, type = "l")
logistic_loadshape <- lslog(loads, target_lf = 0.50, k = 0.5)
summary(logistic_loadshape)
#---------------------------------------------------
loads2 <- ercot[ercot$Year == 2020, ]$ERCOT
plot(loads2, type = "l")
logistic_loadshape2 <- lslog(loads2, target_lf = 0.6,
                            k = 0.5, inf_pos = 0.4)
summary(logistic_loadshape2)
#---------------------------------------------------
loads3 <- ercot[ercot$Year == 2020, ]$ERCOT
plot(loads3, type = "l")
logistic_loadshape3 <- lslog(loads3, target_lf = 0.9)
summary(logistic_loadshape3)






}
\seealso{
\code{\link{lslin}},
\code{\link{print.lslog}},
\code{\link{summary.lslog}},
\code{\link{plot.lslog}},
\code{\link{lscore}}
}

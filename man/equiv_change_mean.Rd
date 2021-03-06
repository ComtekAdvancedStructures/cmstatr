% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/equiv.R
\name{equiv_change_mean}
\alias{equiv_change_mean}
\title{Equivalency based on change in mean value}
\usage{
equiv_change_mean(
  df_qual = NULL,
  data_qual = NULL,
  n_qual = NULL,
  mean_qual = NULL,
  sd_qual = NULL,
  data_sample = NULL,
  n_sample = NULL,
  mean_sample = NULL,
  sd_sample = NULL,
  alpha,
  modcv = FALSE
)
}
\arguments{
\item{df_qual}{(optional) a data.frame containing the qualification data.
Defaults to NULL.}

\item{data_qual}{(optional) a vector of observations from the
"qualification" data to which equivalency is being tested. Or the column of
\code{df_qual} that contains this data. Defaults to NULL}

\item{n_qual}{the number of observations in the qualification data to which
the sample is being compared for equivalency}

\item{mean_qual}{the mean from the qualification data to which the sample
is being compared for equivalency}

\item{sd_qual}{the standard deviation from the qualification data to which
the sample is being compared for equivalency}

\item{data_sample}{a vector of observations from the sample being compared
for equivalency}

\item{n_sample}{the number of observations in the sample being compared for
equivalency}

\item{mean_sample}{the mean of the sample being compared for equivalency}

\item{sd_sample}{the standard deviation of the sample being compared for
equivalency}

\item{alpha}{the acceptable probability of a Type I error}

\item{modcv}{a logical value indicating whether the modified CV approach
should be used. Defaults to \code{FALSE}}
}
\value{
\itemize{
\item \code{call} the expression used to call this function
\item \code{alpha} the value of alpha passed to this function
\item \code{n_sample} the number of observations in the sample for which
equivalency is being checked. This is either the value \code{n_sample}
passed to this function or the length of the vector \code{data_sample}.
\item \code{mean_sample} the mean of the observations in the sample for
which equivalency is being checked. This is either the value
\code{mean_sample} passed to this function or the mean of the vector
\code{data-sample}.
\item \code{sd_sample} the standard deviation of the observations in the
sample for which equivalency is being checked. This is either the value
\code{mean_sample} passed to this function or the standard deviation of
the vector \code{data-sample}.
\item \code{n_qual} the number of observations in the qualification data
to which the sample is being compared for equivalency. This is either
the value \code{n_qual} passed to this function or the length of the
vector \code{data_qual}.
\item \code{mean_qual} the mean of the qualification data to which the
sample is being compared for equivalency. This is either the value
\code{mean_qual} passed to this function or the mean of the vector
\code{data_qual}.
\item \code{sd_qual} the standard deviation of the qualification data to
which the sample is being compared for equivalency. This is either the
value \code{mean_qual} passed to this function or the standard deviation
of the vector \code{data_qual}.
\item \code{modcv} logical value indicating whether the equivalency
calculations were performed using the modified CV approach
\item \code{sp} the value of the pooled standard deviation. If
\code{modecv = TRUE}, this pooled standard deviation includes the
modification to the qualification CV.
\item \code{t0} the test statistic
\item \code{t_req} the t-value for \eqn{\alpha / 2} and
\eqn{df = n1 + n2 -2}
\item \code{threshold} a vector with two elements corresponding to the
minimum and maximum values of the sample mean that would result in a
pass
\item \code{result} a character vector of either "PASS" or "FAIL"
indicating the result of the test for change in mean
}
}
\description{
Checks for change in the mean value between a qualification data set and
a sample. This is normally used to check for properties such as modulus.
This function is a wrapper for a two-sample t--test.
}
\details{
There are several optional arguments to this function. Either (but not both)
\code{data_sample} or all of \code{n_sample}, \code{mean_sample} and
\code{sd_sample} must be supplied. And, either (but not both)
\code{data_qual}
(and also \code{df_qual} if \code{data_qual} is a column name and not a
vector) or all of \code{n_qual}, \code{mean_qual} and \code{sd_qual} must
be supplied. If these requirements are violated, warning(s) or error(s) will
be issued.

This function uses a two-sample t-test to determine if there is a difference
in the mean value of the qualification data and the sample. A pooled
standard deviation is used in the t-test. The procedure is per CMH-17-1G.

If \code{modcv} is TRUE, the standard deviation used to calculate the
thresholds will be replaced with a standard deviation calculated
using the Modified Coefficient of Variation (CV) approach.
The Modified CV approach is a way of adding extra variance to the
qualification data in the case that the qualification data has less
variance than expected, which sometimes occurs when qualification testing
is performed in a short period of time.
Using the Modified CV approach, the standard deviation is calculated by
multiplying \code{CV_star * mean_qual} where \code{mean_qual} is either the
value supplied or the value calculated by \code{mean(data_qual)} and
\eqn{CV*} is determined using \code{\link[=calc_cv_star]{calc_cv_star()}}.

Note that the modified CV option should only be used if that data passes the
Anderson--Darling test.
}
\examples{
equiv_change_mean(alpha = 0.05, n_sample = 9, mean_sample = 9.02,
                  sd_sample = 0.15785, n_qual = 28, mean_qual = 9.24,
                  sd_qual = 0.162, modcv = TRUE)

## Call:
## equiv_change_mean(n_qual = 28, mean_qual = 9.24, sd_qual = 0.162,
##                   n_sample = 9, mean_sample = 9.02, sd_sample = 0.15785,
##                   alpha = 0.05,modcv = TRUE)
##
## For alpha = 0.05
## Modified CV used
##                   Qualification        Sample
##           Number        28               9
##             Mean       9.24             9.02
##               SD      0.162           0.15785
##           Result               PASS
##    Passing Range       8.856695 to 9.623305

}
\references{
“Composite Materials Handbook, Volume 1. Polymer Matrix Composites
Guideline for Characterization of Structural Materials,” SAE International,
CMH-17-1G, Mar. 2012.
}
\seealso{
\code{\link[=calc_cv_star]{calc_cv_star()}}

\code{\link[stats:t.test]{stats::t.test()}}
}

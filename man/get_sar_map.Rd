% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_sar_map.R
\name{get_sar_map}
\alias{get_sar_map}
\title{Download swept area ratio map data}
\usage{
get_sar_map(ecoregion, year = NULL, nyears = NULL, convert2sf = FALSE)
}
\arguments{
\item{ecoregion}{ICES ecoregion}

\item{year}{which year to select (see details)}

\item{nyears}{the number of years to take an average over}

\item{convert2sf}{logical, default FALSE, should an simple features object
be returned if the \code{sf} package is installed?}
}
\value{
a data.frame with a WKT column for the c-square polygons
}
\description{
Download a data.frame of surface and subsurface swept area
ratio by c-square for a given ICES ecoregion.
}
\details{
The spatial data.frame contains average annual surface-swept-area-ratio
and subsurface-swept-area-ratio averaged over 4 years by default.  If year
is not specified (NULL) then the present year - 1 is assumed.
}
\examples{
\dontrun{
# requires authorization
sar_map <- get_sar_map("Celtic Seas", 2021, convert2sf = TRUE)
plot(sar_map["surface_sar"], border = FALSE, logz = TRUE)
}

}

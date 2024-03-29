% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_wgfbit_data1.R
\name{get_wgfbit_data1}
\alias{get_wgfbit_data1}
\title{Download swept area ratio, landings and value map data}
\usage{
get_wgfbit_data1(
  ecoregion,
  year,
  fishing_category = NULL,
  benthis_metier = NULL,
  datacall = NULL,
  convert2sf = FALSE
)
}
\arguments{
\item{ecoregion}{ICES ecoregion}

\item{year}{which year to select}

\item{fishing_category}{optional gear category ("Otter", "Dredge")}

\item{benthis_metier}{optional benthis metier ("SDN_DMF")}

\item{datacall}{integer year giving which data call year to inquire about.
If NULL returns the a summary of the most recent approved data.}

\item{convert2sf}{logical, default FALSE, should an simple features object
be returned if the \code{sf} package is installed?}
}
\value{
a data.frame with a WKT column for the c-square polygons
}
\description{
Download a data.frame of surface and subsurface swept area
ratio by c-square for a given ICES ecoregion, year and gear code.
}
\details{
fishing_category and benthis_metier may not both be supplied, if neither
are supplied the total is calculated.
}
\examples{
\dontrun{
# requires authorization
data1 <- get_wgfbit_data1("Celtic Seas", 2021, benthis_metier = "OT_DMF", convert2sf = TRUE)
plot(data1["total_weight"], border = NA, logz = TRUE)
}

}

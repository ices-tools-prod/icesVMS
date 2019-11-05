
[![Build
Status](https://travis-ci.org/ices-tools-prod/icesVMS.svg?branch=devel)](https://travis-ci.org/ices-tools-prod/icesVMS)
[![CRAN
Status](http://r-pkg.org/badges/version/icesVMS)](https://cran.r-project.org/package=icesVMS)
[![CRAN
Monthly](http://cranlogs.r-pkg.org/badges/icesVMS)](https://cran.r-project.org/package=icesVMS)
[![CRAN
Total](http://cranlogs.r-pkg.org/badges/grand-total/icesVMS)](https://cran.r-project.org/package=icesVMS)

[<img align="right" alt="ICES Logo" width="17%" height="17%" src="http://ices.dk/_layouts/15/1033/images/icesimg/iceslogo.png">](http://ices.dk)

# icesVMS

icesVMS Functions to support the creation of ICES Fisheries Overviews,
….

icesVMS is implemented as an [R](https://www.r-project.org) package
<!-- and available on [CRAN](https://cran.r-project.org/package=icesVMS). -->
and available on GitHub

## Installation

icesVMS can be installed from GitHub using the `install_github` command
from the `remotes` package:

``` r
library(remotes)
install_github("ices-tools-prod/icesVMS")
```

## Usage

For a summary of the package:

``` r
library(icesVMS)
?icesVMS
```

## Examples

## Download c square information

All of the VMS data submitted to ICES is at the c square level (concise
spatial query and representation system, (Rees 2003))

## Download bottom contact model parameters (BENTHIS)

To calculate swept area ratio by c\_square

<div id="refs" class="references">

<div id="ref-reese03_csquares">

Rees, Tony. 2003. “"C-Squares," a New Spatial Indexing System and Its
Applicability to the Description of Oceanographic Datasets.”
*Oceanography* 16 (January): 11–19.
<https://doi.org/10.5670/oceanog.2003.52>.

</div>

</div>

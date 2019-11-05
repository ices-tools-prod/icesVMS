
[![Build
Status](https://travis-ci.org/ices-tools-prod/icesVMS.svg?branch=devel)](https://travis-ci.org/ices-tools-prod/icesVMS)
[![CRAN
Status](http://r-pkg.org/badges/version/icesVMS)](https://cran.r-project.org/package=icesVMS)
[![CRAN
Monthly](http://cranlogs.r-pkg.org/badges/icesVMS)](https://cran.r-project.org/package=icesVMS)
[![CRAN
Total](http://cranlogs.r-pkg.org/badges/grand-total/icesVMS)](https://cran.r-project.org/package=icesVMS)

[<img align="right" alt="ICES Logo" width="17%" height="17%" src="http://ices.dk/_layouts/15/1033/images/icesimg/iceslogo.png">](http://ices.dk)

``` r
library(knitr)
```

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
spatial query and representation system, (Rees 2003)), and to aid in the
exploration of display of data summaries extracted from the ICES
VMS/Logbook database there is a service to extract information related
to a C square. For example, the following code returns a table of all
the c squares in the Celtic Seas ecoregion (see
<https://ices.dk/community/advisory-process/Pages/ICES-ecosystems-and-advisory-areas.aspx>):

``` r
## celtic <- get_csquare(ecoregion = "Celtic Seas")
## sr_32D5 <- get_csquare(stat_rec="32D5")
get_csquare(c_square = "7501:114:383:4")
```

    ##   csquare_area
    ## 1     19.08342
    ##                                                                       wkt
    ## 1 POLYGON ((-14.4 51.85,-14.4 51.9,-14.35 51.9,-14.35 51.85,-14.4 51.85))
    ##   id       c_square stat_rec ices_area   ecoregion    lat     lon
    ## 1  3 7501:114:383:4     32D5       7k2 Celtic Seas 51.875 -14.375

These can be plotted by parsing the WKT (Well Known Text,
<https://en.wikipedia.org/wiki/Well-known_text_representation_of_geometry>)
field (here using the `sf` package) and then plotting using `ggplot2`,
for example:

``` r
ukwest <- get_csquare(ices_area = "6a")
ukwest <- sf::st_as_sf(ukwest, wkt = "wkt", crs = 4326)

ggplot2::ggplot() +
  ggplot2::geom_sf(data = ukwest, color = "lightblue", fill = "transparent")
```

![](README_files/figure-gfm/plot_csquares_6a-1.png)<!-- -->

## Download bottom contact model parameters (BENTHIS)

To calculate swept area ratio by c\_square, ICES uses methods developed
by the BENTHIS project and within the WGSFD in which gear codes are used
to imply the area swept by the gear for a given fishing speed. The
parameters are available via:

``` r
benthis <- get_benthis_parameters()
```

| id | benthisMet        | avKw     | avLoa    | avFspeed | subsurfaceProp | gearWidth | firstFactor | secondFactor | gearModel | gearCoefficient | contactModel             |
| -: | :---------------- | :------- | :------- | :------- | :------------- | --------: | ----------: | -----------: | :-------- | :-------------- | :----------------------- |
|  1 | OT\_SPF           | 883.8421 | 34.38526 | 2.9      | 2.8            | 0.1015789 |      0.9652 |      68.3890 | linear    | avg\_oal        | trawl\_contact           |
|  2 | SDN\_DMF          | 167.6765 | 18.91915 | NA       | 0              | 6.5366439 |   1948.8347 |       0.2363 | power     | avg\_kw         | danish\_seine\_contact   |
|  3 | OT\_DMF           | 441.6667 | 19.8     | 3.064286 | 7.8            | 0.1054698 |      9.6054 |       0.4337 | power     | avg\_kw         | trawl\_contact           |
|  4 | OT\_MIX\_DMF\_BEN | 691.0217 | 24.36896 | 2.911111 | 8.6            | 0.1563055 |      3.2141 |      77.9812 | linear    | avg\_oal        | trawl\_contact           |
|  5 | SSC\_DMF          | 481.795  | 23.1175  | NA       | 5              | 6.4542120 |   4461.2700 |       0.1176 | power     | avg\_oal        | scottish\_seine\_contact |
|  6 | OT\_MIX           | 400.6089 | 20.13774 | 2.788636 | 14.7           | 0.0613659 |     10.6608 |       0.2921 | power     | avg\_kw         | trawl\_contact           |
|  7 | OT\_MIX\_DMF\_PEL | 690.3574 | 23.745   | 3.410385 | 22             | 0.0762053 |      6.6371 |       0.7706 | power     | avg\_oal        | trawl\_contact           |
|  8 | OT\_MIX\_CRU\_DMF | 473.097  | 19.89515 | 2.629    | 22.9           | 0.1139591 |      3.9273 |      35.8254 | linear    | avg\_oal        | trawl\_contact           |
|  9 | OT\_MIX\_CRU      | 681      | 21.685   | 3.008889 | 29.2           | 0.1051172 |     37.5272 |       0.1490 | power     | avg\_kw         | trawl\_contact           |
| 10 | OT\_CRU           | 345.5205 | 18.67739 | 2.47963  | 32.1           | 0.0789228 |      5.1039 |       0.4690 | power     | avg\_kw         | trawl\_contact           |
| 11 | TBB\_CRU          | 210.625  | 20.765   | 2.975    | 52.2           | 0.0171507 |      1.4812 |       0.4578 | power     | avg\_kw         | trawl\_contact           |
| 12 | TBB\_DMF          | 822.1667 | 33.8866  | 5.230851 | 100            | 0.0202760 |      0.6601 |       0.5078 | power     | avg\_kw         | trawl\_contact           |
| 13 | TBB\_MOL          | 107.1773 | 10.14545 | 2.428571 | 100            | 0.0049306 |      0.9530 |       0.7094 | power     | avg\_oal        | trawl\_contact           |
| 14 | DRB\_MOL          | 382.4375 | 24.59848 | 2.5      | 100            | 0.0169653 |      0.3142 |       1.2454 | power     | avg\_oal        | trawl\_contact           |

These high level gear categories refered to as `BenthisMet` are
connected to lower level metiers via a lookup table maintianed by the
WGSFD and avaialbe via:

``` r
metiers <- get_metier_lookup()
```

| leMetLevel6             | benthisMetiers | metierLevel5 | metierLevel4 | fishingCategoryFo |
| :---------------------- | :------------- | :----------- | :----------- | :---------------- |
| FPO\_FWS\_110-156\_0\_0 | NA             | FPO\_FWS     | FPO          | Static            |
| FPO\_FWS\_31-49\_0\_0   | NA             | FPO\_FWS     | FPO          | Static            |
| FPO\_FWS\_\>0\_0\_0     | NA             | FPO\_FWS     | FPO          | Static            |
| FPO\_MCF\_0-0\_0\_0     | NA             | FPO\_MCF     | FPO          | Static            |
| FPO\_MOL\_0-0\_0\_0     | NA             | FPO\_MOL     | FPO          | Static            |
| FPO\_MOL\_0\_0\_0       | NA             | FPO\_MOL     | FPO          | Static            |
| FPO\_MOL\_\>0\_0\_0     | NA             | FPO\_MOL     | FPO          | Static            |
| FPO\_MOL\_\>=29\_0\_0   | NA             | FPO\_MOL     | FPO          | Static            |
| FPO\_NOC\_0\_0\_0       | NA             | FPO\_MOL     | FPO          | Static            |
| FPO\_SPF\_0-0\_0\_0     | NA             | FPO\_SPF     | FPO          | Static            |

# References

<div id="refs" class="references">

<div id="ref-reese03_csquares">

Rees, Tony. 2003. “C-Squares, a New Spatial Indexing System and Its
Applicability to the Description of Oceanographic Datasets.”
*Oceanography* 16 (1): 11–19. <https://doi.org/10.5670/oceanog.2003.52>.

</div>

</div>

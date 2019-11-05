
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

|   id | leMetLevel6                | fishingHours | benthisMetiers    | benthisMetiers2016Wrong       | metierLevel5      | metierLevel4   | jnccGrouping       | fishingCategory   | description           |
| ---: | :------------------------- | :----------- | :---------------- | :---------------------------- | :---------------- | :------------- | :----------------- | :---------------- | :-------------------- |
|    1 | FPO\_FWS\_110-156\_0\_0    | NA           | NA                | NA                            | FPO\_FWS          | FPO            | NA                 | Static            | Pot                   |
|    2 | FPO\_FWS\_31-49\_0\_0      | NA           | NA                | NA                            | FPO\_FWS          | FPO            | NA                 | Static            | Pot                   |
|    3 | FPO\_FWS\_\>0\_0\_0        | NA           | NA                | NA                            | FPO\_FWS          | FPO            | NA                 | Static            | Pot                   |
|    4 | FPO\_MCF\_0-0\_0\_0        | NA           | NA                | NA                            | FPO\_MCF          | FPO            | NA                 | Static            | Pot                   |
|    5 | FPO\_MOL\_0-0\_0\_0        | NA           | NA                | NA                            | FPO\_MOL          | FPO            | NA                 | Static            | Pot                   |
|    6 | FPO\_MOL\_0\_0\_0          | NA           | NA                | NA                            | FPO\_MOL          | FPO            | NA                 | Static            | Pot                   |
|    7 | FPO\_MOL\_\>0\_0\_0        | NA           | NA                | NA                            | FPO\_MOL          | FPO            | NA                 | Static            | Pot                   |
|    8 | FPO\_MOL\_\>=29\_0\_0      | NA           | NA                | NA                            | FPO\_MOL          | FPO            | NA                 | Static            | Pot                   |
|    9 | FPO\_NOC\_0\_0\_0          | NA           | NA                | NA                            | FPO\_MOL          | FPO            | NA                 | Static            | Pot                   |
|   10 | FPO\_SPF\_0-0\_0\_0        | NA           | NA                | NA                            | FPO\_SPF          | FPO            | NA                 | Static            | Pot                   |
|   11 | FPO\_SPF\_0\_0\_0          | NA           | NA                | NA                            | FPO\_SPF          | FPO            | NA                 | Static            | Pot                   |
|   12 | FPO\_SPF\_10-30\_0\_0      | NA           | NA                | NA                            | FPO\_SPF          | FPO            | NA                 | Static            | Pot                   |
|   13 | FPO\_SPF\_31-49\_0\_0      | NA           | NA                | NA                            | FPO\_SPF          | FPO            | NA                 | Static            | Pot                   |
|   14 | FPO\_SPF\_50-59\_0\_0      | NA           | NA                | NA                            | FPO\_SPF          | FPO            | NA                 | Static            | Pot                   |
|   15 | FPO\_SPF\_\>0\_0\_0        | NA           | NA                | NA                            | FPO\_SPF          | FPO            | NA                 | Static            | Pot                   |
|   16 | FPO\_SPF\_\>=220\_0\_0     | NA           | NA                | NA                            | FPO\_SPF          | FPO            | NA                 | Static            | Pot                   |
|   17 | FYK\_CAT\_0\_0\_0          | NA           | NA                | NA                            | FYK\_CAT          | FYK            | NA                 | Static            | Fyke nets             |
|   18 | FYK\_CAT\_\>0\_0\_0        | NA           | NA                | NA                            | FYK\_CAT          | FYK            | NA                 | Static            | Fyke nets             |
|   19 | FYK\_CRU\_0\_0\_0          | NA           | NA                | NA                            | FYK\_CRU          | FYK            | NA                 | Static            | Fyke nets             |
|   20 | FYK\_CRU\_\>0\_0\_0        | NA           | NA                | NA                            | FYK\_CRU          | FYK            | NA                 | Static            | Fyke nets             |
|   21 | FYK\_DEF\_0\_0\_0          | NA           | NA                | NA                            | FYK\_DEF          | FYK            | NA                 | Static            | Fyke nets             |
|   22 | FYK\_FWS\_\>0\_0\_0        | NA           | NA                | NA                            | FYK\_FWS          | FYK            | NA                 | Static            | Fyke nets             |
|   23 | FYK\_SPF\_0\_0\_0          | NA           | NA                | NA                            | FYK\_SPF          | FYK            | NA                 | Static            | Fyke nets             |
|   24 | FYK\_SPF\_\>0\_0\_0        | NA           | NA                | NA                            | FYK\_SPF          | FYK            | NA                 | Static            | Fyke nets             |
|   25 | GEN\_DEF\_1249             | NA           | NA                | NA                            | GEN\_DEF          | GEN            | NA                 | Static            | Gillnet               |
|   26 | GEN\_DEF\_1749             | NA           | NA                | NA                            | GEN\_DEF          | GEN            | NA                 | Static            | Gillnet               |
|   27 | GEN\_DEF\_2499             | NA           | NA                | NA                            | GEN\_DEF          | GEN            | NA                 | Static            | Gillnet               |
|   28 | GEN\_DEF\_349              | NA           | NA                | NA                            | GEN\_DEF          | GEN            | NA                 | Static            | Gillnet               |
|   29 | GEN\_DEF\_624              | NA           | NA                | NA                            | GEN\_DEF          | GEN            | NA                 | Static            | Gillnet               |
|   30 | GEN\_DEF\_874              | NA           | NA                | NA                            | GEN\_DEF          | GEN            | NA                 | Static            | Gillnet               |
|   31 | GEN\_SPF\_349              | NA           | NA                | NA                            | GEN\_SPF          | GEN            | NA                 | Static            | Gillnet               |
|   32 | GEN\_UNK\_349              | NA           | NA                | NA                            | GEN\_UNK          | GEN            | NA                 | Static            | Gillnet               |
|   33 | GNC\_DEF\_0                | NA           | NA                | NA                            | GNC\_DEF          | GNC            | NA                 | Static            | Gillnet               |
|   34 | GNC\_DEF\_0\_0\_0          | NA           | NA                | NA                            | GNC\_DEF          | GNC            | NA                 | Static            | Gillnet               |
|   35 | GNC\_DEF\_110-156\_0\_0    | NA           | NA                | NA                            | GNC\_DEF          | GNC            | NA                 | Static            | Gillnet               |
|   36 | GNC\_DEF\_157-219\_0\_0    | NA           | NA                | NA                            | GNC\_DEF          | GNC            | NA                 | Static            | Gillnet               |
|   37 | GNC\_DEF\_349              | NA           | NA                | NA                            | GNC\_DEF          | GNC            | NA                 | Static            | Gillnet               |
|   38 | GNC\_SPF\_0\_0\_0          | NA           | NA                | NA                            | GNC\_SPF          | GNC            | NA                 | Static            | Gillnet               |
|   39 | GND\_ANA\_0\_0\_0          | NA           | NA                | NA                            | GND\_ANA          | GND            | NA                 | Static            | Drift\_gillnets       |
|   40 | GND\_ANA\_\>=157\_0\_0     | NA           | NA                | NA                            | GND\_ANA          | GND            | NA                 | Static            | Drift\_gillnets       |
|   41 | GND\_CAT\_0\_0\_0          | NA           | NA                | NA                            | GND\_CAT          | GND            | NA                 | Static            | Drift\_gillnets       |
|   42 | GND\_CAT\_0\_40\_0         | NA           | NA                | NA                            | GND\_CAT          | GND            | NA                 | Static            | Drift\_gillnets       |
|   43 | GND\_CAT\_100\_119\_0      | NA           | NA                | NA                            | GND\_CAT          | GND            | NA                 | Static            | Drift\_gillnets       |
|   44 | GND\_CAT\_50\_59\_0        | NA           | NA                | NA                            | GND\_CAT          | GND            | NA                 | Static            | Drift\_gillnets       |
|   45 | GND\_CAT\_50\_70\_0        | NA           | NA                | NA                            | GND\_CAT          | GND            | NA                 | Static            | Drift\_gillnets       |
|   46 | GND\_CAT\_60\_79\_0        | NA           | NA                | NA                            | GND\_CAT          | GND            | NA                 | Static            | Drift\_gillnets       |
|   47 | GND\_CAT\_80\_99\_0        | NA           | NA                | NA                            | GND\_CAT          | GND            | NA                 | Static            | Drift\_gillnets       |
|   48 | GND\_CAT\_\>=100\_0        | NA           | NA                | NA                            | GND\_CAT          | GND            | NA                 | Static            | Drift\_gillnets       |
|   49 | GND\_DEF\_0\_0\_0          | NA           | NA                | NA                            | GND\_DEF          | GND            | NA                 | Static            | Drift\_gillnets       |
|   50 | GND\_DEF\_0\_40\_0         | NA           | NA                | NA                            | GND\_DEF          | GND            | NA                 | Static            | Drift\_gillnets       |
|   51 | GND\_DEF\_100\_119\_0      | NA           | NA                | NA                            | GND\_DEF          | GND            | NA                 | Static            | Drift\_gillnets       |
|   52 | GND\_DEF\_10\_30\_0        | NA           | NA                | NA                            | GND\_DEF          | GND            | NA                 | Static            | Drift\_gillnets       |
|   53 | GND\_DEF\_120\_219\_0      | NA           | NA                | NA                            | GND\_DEF          | GND            | NA                 | Static            | Drift\_gillnets       |
|   54 | GND\_DEF\_40\_49\_0        | NA           | NA                | NA                            | GND\_DEF          | GND            | NA                 | Static            | Drift\_gillnets       |
|   55 | GND\_DEF\_50\_59\_0        | NA           | NA                | NA                            | GND\_DEF          | GND            | NA                 | Static            | Drift\_gillnets       |
|   56 | GND\_DEF\_50\_70\_0        | NA           | NA                | NA                            | GND\_DEF          | GND            | NA                 | Static            | Drift\_gillnets       |
|   57 | GND\_DEF\_60\_79\_0        | NA           | NA                | NA                            | GND\_DEF          | GND            | NA                 | Static            | Drift\_gillnets       |
|   58 | GND\_DEF\_80\_99\_0        | NA           | NA                | NA                            | GND\_DEF          | GND            | NA                 | Static            | Drift\_gillnets       |
|   59 | GND\_DEF\_90\_99\_0        | NA           | NA                | NA                            | GND\_DEF          | GND            | NA                 | Static            | Drift\_gillnets       |
|   60 | GND\_DEF\_\>=100\_0        | NA           | NA                | NA                            | GND\_DEF          | GND            | NA                 | Static            | Drift\_gillnets       |
|   61 | GND\_DEF\_\>=220\_0        | NA           | NA                | NA                            | GND\_DEF          | GND            | NA                 | Static            | Drift\_gillnets       |
|   62 | GND\_DEF\_NA\_0\_0         | NA           | NA                | NA                            | GND\_DEF          | GND            | NA                 | Static            | Drift\_gillnets       |
|   63 | GND\_FWS\_0\_0\_0          | NA           | NA                | NA                            | GND\_FWS          | GND            | NA                 | Static            | Drift\_gillnets       |
|   64 | GND\_LPF\_0\_0\_0          | NA           | NA                | NA                            | GND\_LPF          | GND            | NA                 | Static            | Drift\_gillnets       |
|   65 | GNS\_DEF\_0-0\_0\_0        | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
|   66 | GNS\_DEF\_0\_0\_0          | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
|   67 | GNS\_DEF\_0\_40\_0         | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
|   68 | GNS\_DEF\_10-30\_0\_0      | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
|   69 | GNS\_DEF\_100-109\_0\_0    | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
|   70 | GNS\_DEF\_100-119\_0\_0    | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
|   71 | GNS\_DEF\_100\_119\_0      | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
|   72 | GNS\_DEF\_10\_30\_0        | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
|   73 | GNS\_DEF\_110-156          | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
|   74 | GNS\_DEF\_110-156\_0\_0    | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
|   75 | GNS\_DEF\_110-156\_0\_0\_  | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
|   76 | GNS\_DEF\_110-156\_0\_0\_0 | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
|   77 | GNS\_DEF\_110\_156\_0\_0   | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
|   78 | GNS\_DEF\_120-219          | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
|   79 | GNS\_DEF\_120-219\_0\_0    | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
|   80 | GNS\_DEF\_120\_219\_0      | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
|   81 | GNS\_DEF\_1249             | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
|   82 | GNS\_DEF\_149              | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
|   83 | GNS\_DEF\_157-219\_0\_0    | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
|   84 | GNS\_DEF\_31-49\_0\_0      | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
|   85 | GNS\_DEF\_349              | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
|   86 | GNS\_DEF\_40\_49\_0        | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
|   87 | GNS\_DEF\_50-59\_0\_0      | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
|   88 | GNS\_DEF\_50-70\_0\_0      | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
|   89 | GNS\_DEF\_50\_59\_0        | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
|   90 | GNS\_DEF\_50\_70\_0        | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
|   91 | GNS\_DEF\_60-69\_0\_0      | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
|   92 | GNS\_DEF\_60-79\_0\_0      | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
|   93 | GNS\_DEF\_60\_79\_0        | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
|   94 | GNS\_DEF\_624              | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
|   95 | GNS\_DEF\_70-79\_0\_0      | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
|   96 | GNS\_DEF\_71-89\_0\_0      | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
|   97 | GNS\_DEF\_80-89\_0\_0      | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
|   98 | GNS\_DEF\_80-99\_0\_0      | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
|   99 | GNS\_DEF\_80\_99\_0        | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
|  100 | GNS\_DEF\_874              | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
|  101 | GNS\_DEF\_90-109\_0\_0     | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
|  102 | GNS\_DEF\_90-99            | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
|  103 | GNS\_DEF\_90-99\_0\_0      | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
|  104 | GNS\_DEF\_90\_99\_0        | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
|  105 | GNS\_DEF\_\<10\_0\_0       | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
|  106 | GNS\_DEF\_\>=100\_0        | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
|  107 | GNS\_DEF\_\>=100\_0\_0     | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
|  108 | GNS\_DEF\_\>=157\_0\_0     | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
|  109 | GNS\_DEF\_\>=220           | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
|  110 | GNS\_DEF\_\>=220\_0        | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
|  111 | GNS\_DEF\_\>=220\_0\_0     | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
|  112 | GNS\_DEF\_UND\_0\_0        | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
|  113 | GNS\_DEF\_UNK              | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
|  114 | GNS\_DEF\_misc\_0\_0       | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
|  115 | GNS\_DWS\_0                | NA           | NA                | NA                            | GNS\_DWS          | GNS            | NA                 | Static            | Gillnet               |
|  116 | GNS\_DWS\_0\_0\_0          | NA           | NA                | NA                            | GNS\_DWS          | GNS            | NA                 | Static            | Gillnet               |
|  117 | GNS\_DWS\_100-119\_0\_0    | NA           | NA                | NA                            | GNS\_DWS          | GNS            | NA                 | Static            | Gillnet               |
|  118 | GNS\_DWS\_120-219\_0\_0    | NA           | NA                | NA                            | GNS\_DWS          | GNS            | NA                 | Static            | Gillnet               |
|  119 | GNS\_DWS\_\>=220\_0\_0     | NA           | NA                | NA                            | GNS\_DWS          | GNS            | NA                 | Static            | Gillnet               |
|  120 | GNS\_FIF\_0\_0\_0          | NA           | NA                | NA                            | GNS\_FIF          | GNS            | NA                 | Static            | Gillnet               |
|  121 | GNS\_FWS\_0\_0\_0          | NA           | NA                | NA                            | GNS\_FWS          | GNS            | NA                 | Static            | Gillnet               |
|  122 | GNS\_FWS\_10-30\_0\_0      | NA           | NA                | NA                            | GNS\_FWS          | GNS            | NA                 | Static            | Gillnet               |
|  123 | GNS\_FWS\_100-109\_0\_0    | NA           | NA                | NA                            | GNS\_FWS          | GNS            | NA                 | Static            | Gillnet               |
|  124 | GNS\_FWS\_110-156\_0\_0    | NA           | NA                | NA                            | GNS\_FWS          | GNS            | NA                 | Static            | Gillnet               |
|  125 | GNS\_FWS\_157-219\_0\_0    | NA           | NA                | NA                            | GNS\_FWS          | GNS            | NA                 | Static            | Gillnet               |
|  126 | GNS\_FWS\_31-49\_0\_0      | NA           | NA                | NA                            | GNS\_FWS          | GNS            | NA                 | Static            | Gillnet               |
|  127 | GNS\_FWS\_50-59\_0\_0      | NA           | NA                | NA                            | GNS\_FWS          | GNS            | NA                 | Static            | Gillnet               |
|  128 | GNS\_FWS\_60-69\_0\_0      | NA           | NA                | NA                            | GNS\_FWS          | GNS            | NA                 | Static            | Gillnet               |
|  129 | GN\_DEF\_349               | NA           | NA                | NA                            | GN\_DEF           | GN             | NA                 | Static            | Gillnet               |
|  130 | GN\_DEF\_624               | NA           | NA                | NA                            | GN\_DEF           | GN             | NA                 | Static            | Gillnet               |
|  131 | GN\_DWS\_0                 | NA           | NA                | NA                            | GN\_DWS           | GN             | NA                 | Static            | Gillnet               |
|  132 | GN\_DWS\_349               | NA           | NA                | NA                            | GN\_DWS           | GN             | NA                 | Static            | Gillnet               |
|  133 | GN\_UNK\_0                 | NA           | NA                | NA                            | GN\_UNK           | GN             | NA                 | Static            | Gillnet               |
|  134 | GTN\_DEF\_0\_0\_0          | NA           | NA                | NA                            | GTN\_DEF          | GTN            | NA                 | Static            | Gillnet               |
|  135 | GTN\_DEF\_0\_40\_0         | NA           | NA                | NA                            | GTN\_DEF          | GTN            | NA                 | Static            | Gillnet               |
|  136 | GTN\_DEF\_10\_30\_0        | NA           | NA                | NA                            | GTN\_DEF          | GTN            | NA                 | Static            | Gillnet               |
|  137 | GTN\_DEF\_120\_219\_0      | NA           | NA                | NA                            | GTN\_DEF          | GTN            | NA                 | Static            | Gillnet               |
|  138 | GTN\_DEF\_50\_59\_0        | NA           | NA                | NA                            | GTN\_DEF          | GTN            | NA                 | Static            | Gillnet               |
|  139 | GTN\_DEF\_50\_70\_0        | NA           | NA                | NA                            | GTN\_DEF          | GTN            | NA                 | Static            | Gillnet               |
|  140 | GTN\_DEF\_60\_79\_0        | NA           | NA                | NA                            | GTN\_DEF          | GTN            | NA                 | Static            | Gillnet               |
|  141 | GTN\_DEF\_80\_99\_0        | NA           | NA                | NA                            | GTN\_DEF          | GTN            | NA                 | Static            | Gillnet               |
|  142 | GTN\_DEF\_90\_99\_0        | NA           | NA                | NA                            | GTN\_DEF          | GTN            | NA                 | Static            | Gillnet               |
|  143 | GTN\_DEF\_\>=100\_0        | NA           | NA                | NA                            | GTN\_DEF          | GTN            | NA                 | Static            | Gillnet               |
|  144 | GTN\_DEF\_\>=220\_0        | NA           | NA                | NA                            | GTN\_DEF          | GTN            | NA                 | Static            | Gillnet               |
|  145 | GTN\_LPF\_0\_0\_0          | NA           | NA                | NA                            | GTN\_LPF          | GTN            | NA                 | Static            | Gillnet               |
|  146 | GTN\_LPF\_\>=100\_0        | NA           | NA                | NA                            | GTN\_LPF          | GTN            | NA                 | Static            | Gillnet               |
|  147 | GTN\_UND\_90-99\_0\_0      | NA           | NA                | NA                            | GTN\_UND          | GTN            | NA                 | Static            | Gillnet               |
|  148 | GTR\_ANA\_0\_0\_0          | NA           | NA                | NA                            | GTR\_ANA          | GTR            | NA                 | Static            | Trammel               |
|  149 | GTR\_ANA\_\>=157\_0\_0     | NA           | NA                | NA                            | GTR\_ANA          | GTR            | NA                 | Static            | Trammel               |
|  150 | GTR\_CAT\_NA\_0\_0         | NA           | NA                | NA                            | GTR\_CAT          | GTR            | NA                 | Static            | Trammel               |
|  151 | GTR\_CEP\_0\_0\_0          | NA           | NA                | NA                            | GTR\_CEP          | GTR            | NA                 | Static            | Trammel               |
|  152 | GTR\_CEP\_0\_40\_0         | NA           | NA                | NA                            | GTR\_CEP          | GTR            | NA                 | Static            | Trammel               |
|  153 | GTR\_CEP\_100\_119\_0      | NA           | NA                | NA                            | GTR\_CEP          | GTR            | NA                 | Static            | Trammel               |
|  154 | GTR\_CEP\_10\_30\_0        | NA           | NA                | NA                            | GTR\_CEP          | GTR            | NA                 | Static            | Trammel               |
|  155 | GTR\_CEP\_120\_219\_0      | NA           | NA                | NA                            | GTR\_CEP          | GTR            | NA                 | Static            | Trammel               |
|  156 | GTR\_CEP\_40\_49\_0        | NA           | NA                | NA                            | GTR\_CEP          | GTR            | NA                 | Static            | Trammel               |
|  157 | GTR\_CEP\_50\_59\_0        | NA           | NA                | NA                            | GTR\_CEP          | GTR            | NA                 | Static            | Trammel               |
|  158 | GTR\_CEP\_50\_70\_0        | NA           | NA                | NA                            | GTR\_CEP          | GTR            | NA                 | Static            | Trammel               |
|  159 | GTR\_CEP\_60\_79\_0        | NA           | NA                | NA                            | GTR\_CEP          | GTR            | NA                 | Static            | Trammel               |
|  160 | GTR\_CEP\_80\_99\_0        | NA           | NA                | NA                            | GTR\_CEP          | GTR            | NA                 | Static            | Trammel               |
|  161 | GTR\_CEP\_90\_99\_0        | NA           | NA                | NA                            | GTR\_CEP          | GTR            | NA                 | Static            | Trammel               |
|  162 | GTR\_CEP\_\>=100\_0        | NA           | NA                | NA                            | GTR\_CEP          | GTR            | NA                 | Static            | Trammel               |
|  163 | GTR\_CEP\_\>=220\_0        | NA           | NA                | NA                            | GTR\_CEP          | GTR            | NA                 | Static            | Trammel               |
|  164 | GTR\_CRU\_0-0\_0\_0        | NA           | NA                | NA                            | GTR\_CRU          | GTR            | NA                 | Static            | Trammel               |
|  165 | GTR\_CRU\_0\_0\_0          | NA           | NA                | NA                            | GTR\_CRU          | GTR            | NA                 | Static            | Trammel               |
|  166 | GTR\_CRU\_0\_40\_0         | NA           | NA                | NA                            | GTR\_CRU          | GTR            | NA                 | Static            | Trammel               |
|  167 | GTR\_CRU\_10-30\_0\_0      | NA           | NA                | NA                            | GTR\_CRU          | GTR            | NA                 | Static            | Trammel               |
|  168 | GTR\_CRU\_100-119\_0\_0    | NA           | NA                | NA                            | GTR\_CRU          | GTR            | NA                 | Static            | Trammel               |
|  169 | GTR\_CRU\_100\_119\_0      | NA           | NA                | NA                            | GTR\_CRU          | GTR            | NA                 | Static            | Trammel               |
|  170 | GTR\_CRU\_10\_30\_0        | NA           | NA                | NA                            | GTR\_CRU          | GTR            | NA                 | Static            | Trammel               |
|  171 | GTR\_CRU\_120-219\_0\_0    | NA           | NA                | NA                            | GTR\_CRU          | GTR            | NA                 | Static            | Trammel               |
|  172 | GTR\_CRU\_120\_219\_0      | NA           | NA                | NA                            | GTR\_CRU          | GTR            | NA                 | Static            | Trammel               |
|  173 | GTR\_CRU\_40\_49\_0        | NA           | NA                | NA                            | GTR\_CRU          | GTR            | NA                 | Static            | Trammel               |
|  174 | GTR\_CRU\_50\_59\_0        | NA           | NA                | NA                            | GTR\_CRU          | GTR            | NA                 | Static            | Trammel               |
|  175 | GTR\_CRU\_50\_70\_0        | NA           | NA                | NA                            | GTR\_CRU          | GTR            | NA                 | Static            | Trammel               |
|  176 | GTR\_CRU\_60\_79\_0        | NA           | NA                | NA                            | GTR\_CRU          | GTR            | NA                 | Static            | Trammel               |
|  177 | GTR\_CRU\_80\_99\_0        | NA           | NA                | NA                            | GTR\_CRU          | GTR            | NA                 | Static            | Trammel               |
|  178 | GTR\_CRU\_90\_99\_0        | NA           | NA                | NA                            | GTR\_CRU          | GTR            | NA                 | Static            | Trammel               |
|  179 | GTR\_CRU\_\>=100\_0        | NA           | NA                | NA                            | GTR\_CRU          | GTR            | NA                 | Static            | Trammel               |
|  180 | GTR\_CRU\_\>=220\_0        | NA           | NA                | NA                            | GTR\_CRU          | GTR            | NA                 | Static            | Trammel               |
|  181 | GTR\_CRU\_\>=220\_0\_0     | NA           | NA                | NA                            | GTR\_CRU          | GTR            | NA                 | Static            | Trammel               |
|  182 | GTR\_DEF\_0                | NA           | NA                | NA                            | GTR\_DEF          | GTR            | NA                 | Static            | Trammel               |
|  183 | GTR\_DEF\_0-0\_0\_0        | NA           | NA                | NA                            | GTR\_DEF          | GTR            | NA                 | Static            | Trammel               |
|  184 | GTR\_DEF\_0\_0\_0          | NA           | NA                | NA                            | GTR\_DEF          | GTR            | NA                 | Static            | Trammel               |
|  185 | GTR\_DEF\_0\_40\_0         | NA           | NA                | NA                            | GTR\_DEF          | GTR            | NA                 | Static            | Trammel               |
|  186 | GTR\_DEF\_10-30\_0\_0      | NA           | NA                | NA                            | GTR\_DEF          | GTR            | NA                 | Static            | Trammel               |
|  187 | GTR\_DEF\_100-119\_0\_0    | NA           | NA                | NA                            | GTR\_DEF          | GTR            | NA                 | Static            | Trammel               |
|  188 | GTR\_DEF\_100\_119\_0      | NA           | NA                | NA                            | GTR\_DEF          | GTR            | NA                 | Static            | Trammel               |
|  189 | GTR\_DEF\_10\_30\_0        | NA           | NA                | NA                            | GTR\_DEF          | GTR            | NA                 | Static            | Trammel               |
|  190 | GTR\_DEF\_110-156\_0\_0    | NA           | NA                | NA                            | GTR\_DEF          | GTR            | NA                 | Static            | Trammel               |
|  191 | GTR\_DEF\_120-219\_0\_0    | NA           | NA                | NA                            | GTR\_DEF          | GTR            | NA                 | Static            | Trammel               |
|  192 | GTR\_DEF\_120\_219\_0      | NA           | NA                | NA                            | GTR\_DEF          | GTR            | NA                 | Static            | Trammel               |
|  193 | GTR\_DEF\_40\_49\_0        | NA           | NA                | NA                            | GTR\_DEF          | GTR            | NA                 | Static            | Trammel               |
|  194 | LLS\_ANA\_10-30\_0\_0      | NA           | NA                | NA                            | LLS\_ANA          | LLS            | NA                 | Static            | Longlines             |
|  195 | LLS\_CAT\_0\_0\_0          | NA           | NA                | NA                            | LLS\_CAT          | LLS            | NA                 | Static            | Longlines             |
|  196 | LLS\_CAT\_10-30\_0\_0      | NA           | NA                | NA                            | LLS\_CAT          | LLS            | NA                 | Static            | Longlines             |
|  197 | LLS\_CRU\_0                | NA           | NA                | NA                            | LLS\_CRU          | LLS            | NA                 | Static            | Longlines             |
|  198 | LLS\_CRU\_0-0\_0\_0        | NA           | NA                | NA                            | LLS\_CRU          | LLS            | NA                 | Static            | Longlines             |
|  199 | LLS\_CRU\_349              | NA           | NA                | NA                            | LLS\_CRU          | LLS            | NA                 | Static            | Longlines             |
|  200 | LLS\_DEF\_-\_0\_0          | NA           | NA                | NA                            | LLD\_DEF          | LLD            | NA                 | Static            | Longlines             |
|  201 | LLS\_DEF\_0                | NA           | NA                | NA                            | LLD\_DEF          | LLD            | NA                 | Static            | Longlines             |
|  202 | LLS\_DEF\_0\_0\_0          | NA           | NA                | NA                            | LLS\_DEF          | LLS            | NA                 | Static            | Longlines             |
|  203 | LLS\_DEF\_10-30\_0\_0      | NA           | NA                | NA                            | LLS\_DEF          | LLS            | NA                 | Static            | Longlines             |
|  204 | LLS\_DEF\_110-156\_0\_0    | NA           | NA                | NA                            | LLS\_DEF          | LLS            | NA                 | Static            | Longlines             |
|  205 | LLS\_DEF\_1249             | NA           | NA                | NA                            | LLS\_DEF          | LLS            | NA                 | Static            | Longlines             |
|  206 | LLS\_DEF\_157-219\_0\_0    | NA           | NA                | NA                            | LLS\_DEF          | LLS            | NA                 | Static            | Longlines             |
|  207 | LLS\_DEF\_1749             | NA           | NA                | NA                            | LLS\_DEF          | LLS            | NA                 | Static            | Longlines             |
|  208 | LLS\_DEF\_2499             | NA           | NA                | NA                            | LLS\_DEF          | LLS            | NA                 | Static            | Longlines             |
|  209 | LLS\_DEF\_349              | NA           | NA                | NA                            | LLS\_DEF          | LLS            | NA                 | Static            | Longlines             |
|  210 | LLS\_DEF\_3999             | NA           | NA                | NA                            | LLS\_DEF          | LLS            | NA                 | Static            | Longlines             |
|  211 | LLS\_DEF\_50-59\_0\_0      | NA           | NA                | NA                            | LLS\_DEF          | LLS            | NA                 | Static            | Longlines             |
|  212 | LLS\_DEF\_624              | NA           | NA                | NA                            | LLS\_DEF          | LLS            | NA                 | Static            | Longlines             |
|  213 | LLS\_DEF\_874              | NA           | NA                | NA                            | LLS\_DEF          | LLS            | NA                 | Static            | Longlines             |
|  214 | LLS\_DEF\_\>=220\_0\_0     | NA           | NA                | NA                            | LLS\_DEF          | LLS            | NA                 | Static            | Longlines             |
|  215 | LLS\_DEF\_UND\_0\_0        | NA           | NA                | NA                            | LLS\_DEF          | LLS            | NA                 | Static            | Longlines             |
|  216 | LLS\_DWS\_0                | NA           | NA                | NA                            | LLS\_DWS          | LLS            | NA                 | Static            | Longlines             |
|  217 | LLS\_DWS\_0\_0\_0          | NA           | NA                | NA                            | LLS\_DWS          | LLS            | NA                 | Static            | Longlines             |
|  218 | LLS\_DWS\_1249             | NA           | NA                | NA                            | LLS\_DWS          | LLS            | NA                 | Static            | Longlines             |
|  219 | LLS\_DWS\_2499             | NA           | NA                | NA                            | LLS\_DWS          | LLS            | NA                 | Static            | Longlines             |
|  220 | LLS\_DWS\_3999             | NA           | NA                | NA                            | LLS\_DWS          | LLS            | NA                 | Static            | Longlines             |
|  221 | LLS\_FIF\_-\_0\_0          | NA           | NA                | NA                            | LLS\_FIF          | LLS            | NA                 | Static            | Longlines             |
|  222 | LLS\_FIF\_0\_0\_0          | NA           | NA                | NA                            | LLS\_FIF          | LLS            | NA                 | Static            | Longlines             |
|  223 | LLS\_FWS\_0\_0\_0          | NA           | NA                | NA                            | LLS\_FWS          | LLS            | NA                 | Static            | Longlines             |
|  224 | LLS\_FWS\_10-30\_0\_0      | NA           | NA                | NA                            | LLS\_FWS          | LLS            | NA                 | Static            | Longlines             |
|  225 | LLS\_FWS\_110-156\_0\_0    | NA           | NA                | NA                            | LLS\_FWS          | LLS            | NA                 | Static            | Longlines             |
|  226 | LLS\_FWS\_157-219\_0\_0    | NA           | NA                | NA                            | LLS\_FWS          | LLS            | NA                 | Static            | Longlines             |
|  227 | LLS\_NOC\_0\_0\_0          | NA           | NA                | NA                            | LLS\_NOC          | LLS            | NA                 | Static            | Longlines             |
|  228 | LLS\_SPF\_0                | NA           | NA                | NA                            | LLS\_SPF          | LLS            | NA                 | Static            | Longlines             |
|  229 | LLS\_SPF\_0-0\_0\_0        | NA           | NA                | NA                            | LLS\_SPF          | LLS            | NA                 | Static            | Longlines             |
|  230 | LLS\_SPF\_0\_0\_0          | NA           | NA                | NA                            | LLS\_SPF          | LLS            | NA                 | Static            | Longlines             |
|  231 | LLS\_SPF\_10-30\_0\_0      | NA           | NA                | NA                            | LLS\_SPF          | LLS            | NA                 | Static            | Longlines             |
|  232 | LLS\_SPF\_349              | NA           | NA                | NA                            | LLS\_SPF          | LLS            | NA                 | Static            | Longlines             |
|  233 | LLS\_SPF\_3999             | NA           | NA                | NA                            | LLS\_SPF          | LLS            | NA                 | Static            | Longlines             |
|  234 | LLS\_SPF\_624              | NA           | NA                | NA                            | LLS\_SPF          | LLS            | NA                 | Static            | Longlines             |
|  235 | LLS\_SPF\_874              | NA           | NA                | NA                            | LLS\_SPF          | LLS            | NA                 | Static            | Longlines             |
|  236 | LLS\_UNK\_0                | NA           | NA                | NA                            | LLS\_UNK          | LLS            | NA                 | Static            | Longlines             |
|  237 | LLS\_UNK\_1249             | NA           | NA                | NA                            | LLS\_UNK          | LLS            | NA                 | Static            | Longlines             |
|  238 | LLS\_UNK\_349              | NA           | NA                | NA                            | LLS\_UNK          | LLS            | NA                 | Static            | Longlines             |
|  239 | LL\_CRU\_0                 | NA           | NA                | NA                            | LL\_CRU           | LL             | NA                 | Static            | Longlines             |
|  240 | LL\_CRU\_624               | NA           | NA                | NA                            | LL\_CRU           | LL             | NA                 | Static            | Longlines             |
|  241 | LL\_DEF\_0                 | NA           | NA                | NA                            | LL\_DEF           | LL             | NA                 | Static            | Longlines             |
|  242 | LL\_DEF\_1249              | NA           | NA                | NA                            | LL\_DEF           | LL             | NA                 | Static            | Longlines             |
|  243 | LL\_DEF\_149               | NA           | NA                | NA                            | LL\_DEF           | LL             | NA                 | Static            | Longlines             |
|  244 | LL\_DEF\_1749              | NA           | NA                | NA                            | LL\_DEF           | LL             | NA                 | Static            | Longlines             |
|  245 | LL\_DEF\_2499              | NA           | NA                | NA                            | LL\_DEF           | LL             | NA                 | Static            | Longlines             |
|  246 | LL\_DEF\_349               | NA           | NA                | NA                            | LL\_DEF           | LL             | NA                 | Static            | Longlines             |
|  247 | LL\_DEF\_624               | NA           | NA                | NA                            | LL\_DEF           | LL             | NA                 | Static            | Longlines             |
|  248 | LL\_DEF\_874               | NA           | NA                | NA                            | LL\_DEF           | LL             | NA                 | Static            | Longlines             |
|  249 | LL\_DWS\_0                 | NA           | NA                | NA                            | LL\_DWS           | LL             | NA                 | Static            | Longlines             |
|  250 | LL\_DWS\_1749              | NA           | NA                | NA                            | LL\_DWS           | LL             | NA                 | Static            | Longlines             |
|  251 | LL\_SPF\_0                 | NA           | NA                | NA                            | LL\_SPF           | LL             | NA                 | Static            | Longlines             |
|  252 | LL\_SPF\_1249              | NA           | NA                | NA                            | LL\_SPF           | LL             | NA                 | Static            | Longlines             |
|  253 | LL\_SPF\_349               | NA           | NA                | NA                            | LL\_SPF           | LL             | NA                 | Static            | Longlines             |
|  254 | LL\_SPF\_624               | NA           | NA                | NA                            | LL\_SPF           | LL             | NA                 | Static            | Longlines             |
|  255 | LL\_UNK\_0                 | NA           | NA                | NA                            | LL\_UNK           | LL             | NA                 | Static            | Longlines             |
|  256 | LL\_UNK\_349               | NA           | NA                | NA                            | LL\_UNK           | LL             | NA                 | Static            | Longlines             |
|  257 | LN\_CRU\_0\_0\_0           | NA           | NA                | NA                            | LN\_CRU           | LN             | NA                 | Static            | Lift nets             |
|  258 | LN\_DEF\_0\_0\_0           | NA           | NA                | NA                            | LN\_CRU           | LN             | NA                 | Static            | Lift nets             |
|  259 | LTL\_DEF\_0                | NA           | NA                | NA                            | LN\_CRU           | LTL            | NA                 | Static            | Lines                 |
|  260 | LTL\_DEF\_0\_0\_0          | NA           | NA                | NA                            | LN\_CRU           | LTL            | NA                 | Static            | Lines                 |
|  261 | OTB\_CRU\_100-119\_0\_0    | NA           | OT\_CRU           | OT\_CRU                       | OTB\_CRU          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  262 | OTB\_CRU\_100\_119\_0      | NA           | OT\_CRU           | OT\_CRU                       | OTB\_CRU          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  263 | OTB\_CRU\_1249             | NA           | OT\_CRU           | OT\_CRU                       | OTB\_CRU          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  264 | OTB\_CRU\_16-31            | NA           | OT\_CRU           | OT\_CRU                       | OTB\_CRU          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  265 | OTB\_CRU\_16-31\_0\_0      | NA           | OT\_CRU           | OT\_CRU                       | OTB\_CRU          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  266 | OTB\_CRU\_16\_31\_0        | NA           | OT\_CRU           | OT\_CRU                       | OTB\_CRU          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  267 | OTB\_CRU\_2499             | NA           | OT\_CRU           | OT\_CRU                       | OTB\_CRU          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  268 | OTB\_CRU\_32-54\_0\_0      | NA           | OT\_CRU           | NA                            | OTB\_CRU          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  269 | OTB\_CRU\_32-69\_0\_0      | NA           | OT\_CRU           | OT\_CRU                       | OTB\_CRU          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  270 | OTB\_CRU\_32-69\_2\_22     | NA           | OT\_CRU           | OT\_CRU                       | OTB\_CRU          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  271 | OTB\_CRU\_32\_54\_0        | NA           | OT\_CRU           | OT\_CRU                       | OTB\_CRU          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  272 | OTB\_CRU\_32\_69\_0        | NA           | OT\_CRU           | OT\_CRU                       | OTB\_CRU          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  273 | OTB\_CRU\_349              | NA           | OT\_CRU           | OT\_CRU                       | OTB\_CRU          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  274 | OTB\_CRU\_3999             | NA           | OT\_CRU           | OT\_CRU                       | OTB\_CRU          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  275 | OTB\_CRU\_5000             | NA           | OT\_CRU           | OT\_CRU                       | OTB\_CRU          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  276 | OTB\_CRU\_55-59\_0\_0      | NA           | OT\_CRU           | NA                            | OTB\_CRU          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  277 | OTB\_CRU\_55\_69\_0        | NA           | OT\_CRU           | OT\_CRU                       | OTB\_CRU          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  278 | OTB\_CRU\_624              | NA           | OT\_CRU           | OT\_CRU                       | OTB\_CRU          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  279 | OTB\_CRU\_70-89\_0\_0      | NA           | OT\_CRU           | OT\_CRU                       | OTB\_CRU          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  280 | OTB\_CRU\_70-89\_2\_35     | NA           | OT\_CRU           | OT\_CRU                       | OTB\_CRU          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  281 | OTB\_CRU\_70-99\_0\_0      | NA           | OT\_CRU           | OT\_CRU                       | OTB\_CRU          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  282 | OTB\_CRU\_70\_99\_0        | NA           | OT\_CRU           | OT\_CRU                       | OTB\_CRU          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  283 | OTB\_CRU\_874              | NA           | OT\_CRU           | OT\_CRU                       | OTB\_CRU          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  284 | OTB\_CRU\_90-119\_0\_0     | NA           | OT\_CRU           | OT\_CRU                       | OTB\_CRU          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  285 | OTB\_CRU\_90-119\_1\_120   | NA           | OT\_CRU           | OT\_CRU                       | OTB\_CRU          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  286 | OTB\_CRU\_90-119\_1\_140   | NA           | OT\_CRU           | OT\_CRU                       | OTB\_CRU          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  287 | OTB\_CRU\_90-119\_1\_300   | NA           | OT\_CRU           | OT\_CRU                       | OTB\_CRU          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  288 | OTB\_CRU\_\<16\_0\_0       | NA           | OT\_CRU           | OT\_CRU                       | OTB\_CRU          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  289 | OTB\_CRU\_\>0\_0\_0        | NA           | OT\_CRU           | OT\_CRU                       | OTB\_CRU          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  290 | OTB\_CRU\_\>=120\_0        | NA           | OT\_CRU           | OT\_CRU                       | OTB\_CRU          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  291 | OTB\_CRU\_\>=120\_0\_0     | NA           | OT\_CRU           | OT\_CRU                       | OTB\_CRU          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  292 | OTB\_CRU\_\>=120\_1\_120   | NA           | OT\_CRU           | OT\_CRU                       | OTB\_CRU          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  293 | OTB\_CRU\_\>=55\_0\_0      | NA           | OT\_CRU           | OT\_CRU                       | OTB\_CRU          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  294 | OTB\_CRU\_\>=65\_0         | NA           | OT\_CRU           | OT\_CRU                       | OTB\_CRU          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  295 | OTB\_CRU\_\>=70\_0         | NA           | OT\_CRU           | OT\_CRU                       | OTB\_CRU          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  296 | OTB\_CRU\_\>=70\_0\_0      | NA           | OT\_CRU           | OT\_CRU                       | OTB\_CRU          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  297 | OTB\_CRU\_UNK              | NA           | OT\_CRU           | OT\_CRU                       | OTB\_CRU          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  298 | OTB\_DEF\_0                | NA           | OT\_DMF           | NA                            | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  299 | OTB\_DEF\_0\_0\_0          | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  300 | OTB\_DEF\_0\_16\_0         | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  301 | OTB\_DEF\_100-119          | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  302 | OTB\_DEF\_100-119\_0\_0    | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  303 | OTB\_DEF\_100\_119\_0      | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  304 | OTB\_DEF\_1249             | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  305 | OTB\_DEF\_130-279\_0\_0    | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  306 | OTB\_DEF\_130\_0\_0        | NA           | OT\_DMF           | NA                            | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  307 | OTB\_DEF\_16-31\_0\_0      | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  308 | OTB\_DEF\_16\_31\_0        | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  309 | OTB\_DEF\_1749             | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  310 | OTB\_DWS\_100\_119\_0      | NA           | OT\_MIX\_DMF\_BEN | OT\_MIX\_DMF\_BEN             | OTB\_DWS          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  311 | OTB\_DWS\_1249             | NA           | OT\_MIX\_DMF\_BEN | OT\_MIX\_DMF\_BEN             | OTB\_DWS          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  312 | OTB\_DWS\_16\_31\_0        | NA           | OT\_MIX\_DMF\_BEN | OT\_MIX\_DMF\_BEN             | OTB\_DWS          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  313 | OTB\_DWS\_1749             | NA           | OT\_MIX\_DMF\_BEN | OT\_MIX\_DMF\_BEN             | OTB\_DWS          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  314 | OTB\_DWS\_2499             | NA           | OT\_MIX\_DMF\_BEN | OT\_MIX\_DMF\_BEN             | OTB\_DWS          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  315 | OTB\_DWS\_32-69\_0\_0      | NA           | OT\_MIX\_DMF\_BEN | OT\_MIX\_DMF\_BEN             | OTB\_DWS          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  316 | OTB\_DWS\_32\_69\_0        | NA           | OT\_MIX\_DMF\_BEN | OT\_MIX\_DMF\_BEN             | OTB\_DWS          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  317 | OTB\_DWS\_3999             | NA           | OT\_MIX\_DMF\_BEN | OT\_MIX\_DMF\_BEN             | OTB\_DWS          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  318 | OTB\_DWS\_5000             | NA           | OT\_MIX\_DMF\_BEN | OT\_MIX\_DMF\_BEN             | OTB\_DWS          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  319 | OTB\_DWS\_70-99\_0\_0      | NA           | OT\_MIX\_DMF\_BEN | OT\_MIX\_DMF\_BEN             | OTB\_DWS          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  320 | OTB\_DWS\_70\_99\_0        | NA           | OT\_MIX\_DMF\_BEN | OT\_MIX\_DMF\_BEN             | OTB\_DWS          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  321 | OTB\_DWS\_874              | NA           | OT\_MIX\_DMF\_BEN | OT\_MIX\_DMF\_BEN             | OTB\_DWS          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  322 | OTB\_DWS\_\>=120\_0        | NA           | OT\_MIX\_DMF\_BEN | OT\_MIX\_DMF\_BEN             | OTB\_DWS          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  323 | OTB\_DWS\_\>=120\_0\_0     | NA           | OT\_MIX\_DMF\_BEN | OT\_MIX\_DMF\_BEN             | OTB\_DWS          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  324 | OTB\_DWS\_\>=70\_0         | NA           | OT\_MIX\_DMF\_BEN | OT\_MIX\_DMF\_BEN             | OTB\_DWS          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  325 | OTB\_DWS\_UNK              | NA           | OT\_MIX\_DMF\_BEN | OT\_MIX\_DMF\_BEN             | OTB\_DWS          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  326 | OTB\_FIF\_90-119\_0\_0     | NA           | OT\_DMF           | OT\_DMF                       | OTB\_FWS          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  327 | OTB\_FIF\_90-119\_1\_120   | NA           | OT\_DMF           | OT\_DMF                       | OTB\_FWS          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  328 | OTB\_FWS\_16-31\_0\_0      | NA           | OT\_DMF           | OT\_DMF                       | OTB\_FWS          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  329 | OTB\_FWS\_32-54\_0\_0      | NA           | OT\_DMF           | OT\_DMF                       | OTB\_FWS          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  330 | OTB\_FWS\_55-69\_0\_0      | NA           | OT\_DMF           | OT\_DMF                       | OTB\_FWS          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  331 | OTB\_FWS\_624              | NA           | OT\_DMF           | OT\_DMF                       | OTB\_FWS          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  332 | OTB\_FWS\_70-79\_0\_0      | NA           | OT\_DMF           | OT\_DMF                       | OTB\_FWS          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  333 | OTB\_FWS\_90-99\_0\_0      | NA           | OT\_DMF           | OT\_DMF                       | OTB\_FWS          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  334 | OTB\_FWS\_\>0\_0\_0        | NA           | OT\_DMF           | OT\_DMF                       | OTB\_FWS          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  335 | OTB\_FWS\_\>=105\_0\_0     | NA           | OT\_DMF           | OT\_DMF                       | OTB\_FWS          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  336 | OTB\_LPF\_100-119\_0\_0    | NA           | OT\_MIX\_DMF\_PEL | NA                            | OTB\_LPF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  337 | OTB\_LPF\_70-99\_0\_0      | NA           | OT\_MIX\_DMF\_PEL | NA                            | OTB\_LPF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  338 | OTB\_LPF\_\>=120\_0\_0     | NA           | OT\_MIX\_DMF\_PEL | NA                            | OTB\_LPF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  339 | OTB\_MCD\_100-119\_0\_0    | NA           | OT\_MIX\_CRU\_DMF | OT\_MIX\_CRU                  | OTB\_MCD          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  340 | OTB\_MCD\_16-31\_0\_0      | NA           | OT\_MIX\_CRU\_DMF | OT\_MIX\_CRU                  | OTB\_MCD          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  341 | OTB\_MCD\_70-99            | NA           | OT\_MIX\_CRU\_DMF | OT\_MIX\_CRU                  | OTB\_MCD          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  342 | OTB\_MCD\_70-99\_0\_0      | NA           | OT\_MIX\_CRU\_DMF | OT\_MIX\_CRU                  | OTB\_MCD          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  343 | OTB\_MCD\_90-119\_0\_0     | NA           | OT\_MIX\_CRU\_DMF | OT\_MIX\_CRU                  | OTB\_MCD          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  344 | OTB\_MCD\_90-119\_1\_110   | NA           | OT\_MIX\_CRU\_DMF | OT\_MIX\_CRU                  | OTB\_MCD          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  345 | OTB\_MCD\_90-119\_1\_120   | NA           | OT\_MIX\_CRU\_DMF | OT\_MIX\_CRU                  | OTB\_MCD          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  346 | OTB\_MCD\_90-119\_1\_140   | NA           | OT\_MIX\_CRU\_DMF | OT\_MIX\_CRU                  | OTB\_MCD          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  347 | OTB\_MCD\_90-119\_1\_300   | NA           | OT\_MIX\_CRU\_DMF | OT\_MIX\_CRU                  | OTB\_MCD          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  348 | OTB\_MCD\_\>0\_0\_0        | NA           | OT\_MIX\_CRU\_DMF | OT\_MIX\_CRU                  | OTB\_MCD          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  349 | OTB\_MCD\_\>=120\_0\_0     | NA           | OT\_MIX\_CRU\_DMF | OT\_MIX\_CRU                  | OTB\_MCD          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  350 | OTB\_MCD\_UND\_0\_0        | NA           | OT\_MIX\_CRU\_DMF | OT\_MIX\_CRU                  | OTB\_MCD          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  351 | OTB\_MCF\_100-119\_0\_0    | NA           | OT\_MIX\_DMF\_PEL | OT\_MIX\_DMF\_PEL             | OTB\_MCF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  352 | OTB\_MCF\_32-69\_0\_0      | NA           | OT\_MIX\_DMF\_PEL | OT\_MIX\_DMF\_PEL             | OTB\_MCF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  353 | OTB\_SPF\_70\_99\_0        | NA           | OT\_SPF           | OT\_SPF                       | OTB\_SPF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  354 | OTB\_SPF\_874              | NA           | OT\_SPF           | OT\_SPF                       | OTB\_SPF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  355 | OTB\_SPF\_90-119\_0\_0     | NA           | OT\_SPF           | OT\_SPF                       | OTB\_SPF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  356 | OTB\_SPF\_\<16\_0\_0       | NA           | OT\_SPF           | OT\_SPF                       | OTB\_SPF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  357 | OTB\_SPF\_\>=105\_0\_0     | NA           | OT\_SPF           | OT\_SPF                       | OTB\_SPF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  358 | OTB\_SPF\_\>=120\_0        | NA           | OT\_SPF           | OT\_SPF                       | OTB\_SPF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  359 | OTB\_SPF\_\>=120\_0\_0     | NA           | OT\_SPF           | OT\_SPF                       | OTB\_SPF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  360 | OTB\_SPF\_\>=70\_0         | NA           | OT\_SPF           | OT\_SPF                       | OTB\_SPF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  361 | OTB\_SPF\_UNK              | NA           | OT\_SPF           | OT\_SPF                       | OTB\_SPF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  362 | OTB\_SPF\_misc\_0\_0       | NA           | OT\_SPF           | OT\_SPF                       | OTB\_SPF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  363 | OTB\_UNK\_0                | NA           | OT\_MIX           | NA                            | OTB\_UNK          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  364 | OTB\_UNK\_1249             | NA           | OT\_MIX           | NA                            | OTB\_UNK          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  365 | OTB\_UNK\_1749             | NA           | OT\_MIX           | NA                            | OTB\_UNK          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  366 | OTB\_UNK\_2499             | NA           | OT\_MIX           | NA                            | OTB\_UNK          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  367 | OTB\_UNK\_349              | NA           | OT\_MIX           | NA                            | OTB\_UNK          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  368 | OTB\_UNK\_3999             | NA           | OT\_MIX           | NA                            | OTB\_UNK          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  369 | OTB\_UNK\_5000             | NA           | OT\_MIX           | NA                            | OTB\_UNK          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  370 | OTB\_UNK\_624              | NA           | OT\_MIX           | NA                            | OTB\_UNK          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  371 | OTB\_UNK\_874              | NA           | OT\_MIX           | NA                            | OTB\_UNK          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  372 | OTB\_UNK\_UNK              | NA           | OT\_MIX           | NA                            | OTB\_UNK          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  373 | OTB\_unk\_0\_0             | NA           | OT\_MIX           | NA                            | OTB\_unk          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  374 | OTG\_UND\_UND\_0\_0        | NA           | NA                | NA                            | OTG\_UND          | OTG            | NA                 | Other             | Other                 |
|  375 | OTH\_EEL\_0\_0\_0          | NA           | NA                | NA                            | OTH\_EEL          | OTH            | NA                 | Other             | Other                 |
|  376 | OTH\_NA\_0\_0\_0           | NA           | NA                | NA                            | OTH\_EEL          | OTH            | NA                 | Other             | Other                 |
|  377 | OTM\_ANA\_UNK              | NA           | NA                | NA                            | OTM\_ANA          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  378 | OTM\_CAT\_0\_0\_0          | NA           | NA                | NA                            | OTM\_CAT          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  379 | OTM\_CEP\_0\_0\_0          | NA           | NA                | NA                            | OTM\_CEP          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  380 | OTM\_CRU\_0                | NA           | NA                | NA                            | OTM\_CRU          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  381 | OTM\_CRU\_1249             | NA           | NA                | NA                            | OTM\_CRU          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  382 | OTM\_CRU\_16-31\_0\_0      | NA           | NA                | NA                            | OTM\_CRU          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  383 | OTM\_CRU\_32-69\_0\_0      | NA           | NA                | NA                            | OTM\_CRU          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  384 | OTM\_CRU\_70-99\_0\_0      | NA           | NA                | NA                            | OTM\_CRU          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  385 | OTM\_DEF\_0                | NA           | NA                | NA                            | OTM\_DEF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  386 | OTM\_DEF\_0\_0\_0          | NA           | NA                | NA                            | OTM\_DEF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  387 | OTM\_DEF\_100-119\_0\_0    | NA           | NA                | NA                            | OTM\_DEF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  388 | OTM\_DEF\_100-129\_0\_0    | NA           | NA                | NA                            | OTM\_DEF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  389 | OTM\_DEF\_100\_119\_0      | NA           | NA                | NA                            | OTM\_DEF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  390 | OTM\_DEF\_1249             | NA           | NA                | NA                            | OTM\_DEF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  391 | OTM\_DEF\_16-31\_0\_0      | NA           | NA                | NA                            | OTM\_DEF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  392 | OTM\_DEF\_16\_31\_0        | NA           | NA                | NA                            | OTM\_DEF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  393 | OTM\_DEF\_2499             | NA           | NA                | NA                            | OTM\_DEF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  394 | OTM\_DEF\_32-69\_0\_0      | NA           | NA                | NA                            | OTM\_DEF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  395 | OTM\_DEF\_32\_54\_0        | NA           | NA                | NA                            | OTM\_DEF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  396 | OTM\_DEF\_32\_69\_0        | NA           | NA                | NA                            | OTM\_DEF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  397 | OTM\_DEF\_3999             | NA           | NA                | NA                            | OTM\_DEF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  398 | OTM\_DEF\_5000             | NA           | NA                | NA                            | OTM\_DEF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  399 | OTM\_DEF\_55\_69\_0        | NA           | NA                | NA                            | OTM\_DEF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  400 | OTM\_DEF\_70-99\_0\_0      | NA           | NA                | NA                            | OTM\_DEF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  401 | OTM\_DEF\_70\_99\_0        | NA           | NA                | NA                            | OTM\_DEF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  402 | OTM\_DEF\_90-104\_0\_0     | NA           | NA                | NA                            | OTM\_DEF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  403 | OTM\_DEF\_90-119\_0\_0     | NA           | NA                | NA                            | OTM\_DEF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  404 | OTM\_DEF\_90-99\_0\_0      | NA           | NA                | NA                            | OTM\_DEF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  405 | OTM\_DEF\_\<16\_0\_0       | NA           | NA                | NA                            | OTM\_DEF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  406 | OTM\_DEF\_\>=105\_0\_110   | NA           | NA                | NA                            | OTM\_DEF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  407 | OTM\_DEF\_\>=105\_1\_110   | NA           | NA                | NA                            | OTM\_DEF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  408 | OTM\_SPF\_UND\_0\_0        | NA           | NA                | NA                            | OTM\_SPF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  409 | OTM\_SPF\_UNK              | NA           | NA                | NA                            | OTM\_SPF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  410 | OTM\_UNK\_2499             | NA           | NA                | NA                            | OTM\_UNK          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  411 | OTM\_UNK\_UNK              | NA           | NA                | NA                            | OTM\_UNK          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  412 | OTS\_CRU\_349              | NA           | OT\_CRU           | OT\_MIX\_CRU                  | OTS\_CRU          | OTS            | Otter\_Trawl       | Otter             | Twin\_Otter\_Trawl    |
|  413 | OTS\_CRU\_624              | NA           | OT\_CRU           | OT\_MIX\_CRU                  | OTS\_CRU          | OTS            | Otter\_Trawl       | Otter             | Twin\_Otter\_Trawl    |
|  414 | OTS\_DEF\_3999             | NA           | OT\_DMF           | OT\_DMF                       | OTS\_DEF          | OTS            | Otter\_Trawl       | Otter             | Twin\_Otter\_Trawl    |
|  415 | OTT\_CEP\_0\_0\_0          | NA           | OT\_MIX           | NA                            | OTT\_CEP          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
|  416 | OTT\_CEP\_100\_119\_0      | NA           | OT\_MIX           | NA                            | OTT\_CEP          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
|  417 | OTT\_CEP\_16\_31\_0        | NA           | OT\_MIX           | NA                            | OTT\_CEP          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
|  418 | OTT\_CEP\_32\_54\_0        | NA           | OT\_MIX           | NA                            | OTT\_CEP          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
|  419 | OTT\_CEP\_32\_69\_0        | NA           | OT\_MIX           | NA                            | OTT\_CEP          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
|  420 | OTT\_CEP\_55\_69\_0        | NA           | OT\_MIX           | NA                            | OTT\_CEP          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
|  421 | OTT\_CEP\_70\_99\_0        | NA           | OT\_MIX           | NA                            | OTT\_CEP          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
|  422 | OTT\_CEP\_\>=120\_0        | NA           | OT\_MIX           | NA                            | OTT\_CEP          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
|  423 | OTT\_CEP\_\>=70\_0         | NA           | OT\_MIX           | NA                            | OTT\_CEP          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
|  424 | OTT\_CHECK\_100-119\_0\_   | NA           | NA                | NA                            | OTT\_CHE          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
|  425 | OTT\_CHECK\_70-99\_0\_0    | NA           | NA                | NA                            | OTT\_CHE          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
|  426 | OTT\_CHECK\_\>=120\_0\_0   | NA           | NA                | NA                            | OTT\_CHE          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
|  427 | OTT\_CRU\_0                | NA           | OT\_CRU           | NA                            | OTT\_CRU          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
|  428 | OTT\_CRU\_0\_0\_0          | NA           | OT\_CRU           | OT\_CRU                       | OTT\_CRU          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
|  429 | OTT\_CRU\_0\_16\_0         | NA           | OT\_CRU           | OT\_CRU                       | OTT\_CRU          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
|  430 | OTT\_CRU\_100-119\_0\_0    | NA           | OT\_CRU           | OT\_CRU                       | OTT\_CRU          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
|  431 | OTT\_CRU\_100\_119\_0      | NA           | OT\_CRU           | OT\_CRU                       | OTT\_CRU          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
|  432 | OTT\_CRU\_16-31\_0\_0      | NA           | OT\_CRU           | OT\_CRU                       | OTT\_CRU          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
|  433 | OTT\_CRU\_16\_31\_0        | NA           | OT\_CRU           | OT\_CRU                       | OTT\_CRU          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
|  434 | OTT\_CRU\_32-69\_0\_0      | NA           | OT\_CRU           | OT\_CRU                       | OTT\_CRU          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
|  435 | OTT\_CRU\_32-69\_2\_22     | NA           | OT\_CRU           | OT\_CRU                       | OTT\_CRU          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
|  436 | OTT\_CRU\_32\_54\_0        | NA           | OT\_CRU           | OT\_CRU                       | OTT\_CRU          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
|  437 | OTT\_CRU\_32\_69\_0        | NA           | OT\_CRU           | OT\_CRU                       | OTT\_CRU          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
|  438 | OTT\_CRU\_55\_69\_0        | NA           | OT\_CRU           | OT\_CRU                       | OTT\_CRU          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
|  439 | OTT\_CRU\_624              | NA           | OT\_CRU           | OT\_CRU                       | OTT\_CRU          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
|  440 | OTT\_CRU\_70-89\_2\_35     | NA           | OT\_CRU           | OT\_CRU                       | OTT\_CRU          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
|  441 | OTT\_CRU\_70-99\_0\_0      | NA           | OT\_CRU           | OT\_CRU                       | OTT\_CRU          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
|  442 | OTT\_CRU\_70\_99\_0        | NA           | OT\_CRU           | OT\_CRU                       | OTT\_CRU          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
|  443 | OTT\_CRU\_90-119\_0\_0     | NA           | OT\_CRU           | OT\_CRU                       | OTT\_CRU          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
|  444 | OTT\_CRU\_90-119\_1\_120   | NA           | OT\_CRU           | OT\_CRU                       | OTT\_CRU          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
|  445 | OTT\_CRU\_90-119\_1\_140   | NA           | OT\_CRU           | OT\_CRU                       | OTT\_CRU          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
|  446 | OTT\_CRU\_90-119\_1\_300   | NA           | OT\_CRU           | OT\_CRU                       | OTT\_CRU          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
|  447 | OTT\_CRU\_\<16\_0\_0       | NA           | OT\_CRU           | OT\_CRU                       | OTT\_CRU          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
|  448 | OTT\_CRU\_\>0\_0\_0        | NA           | OT\_CRU           | OT\_CRU                       | OTT\_CRU          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
|  449 | OTT\_CRU\_\>=120\_0        | NA           | OT\_CRU           | OT\_CRU                       | OTT\_CRU          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
|  450 | OTT\_CRU\_\>=120\_0\_0     | NA           | OT\_CRU           | OT\_CRU                       | OTT\_CRU          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
|  451 | OTT\_CRU\_\>=120\_1\_120   | NA           | OT\_CRU           | OT\_CRU                       | OTT\_CRU          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
|  452 | OTT\_CRU\_\>=65\_0         | NA           | OT\_CRU           | OT\_CRU                       | OTT\_CRU          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
|  453 | OTT\_MCD\_UND\_0\_0        | NA           | OT\_MIX\_CRU\_DMF | NA                            | OTT\_MCD          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
|  454 | OTT\_MOL\_100-119\_0\_0    | NA           | OT\_MIX           | OT\_MIX                       | OTT\_MOL          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
|  455 | OTT\_MOL\_32-69\_0\_0      | NA           | OT\_MIX           | OT\_MIX                       | OTT\_MOL          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
|  456 | OTT\_MOL\_70-99\_0\_0      | NA           | OT\_MIX           | OT\_MIX                       | OTT\_MOL          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
|  457 | OTT\_MOL\_\<16\_0\_0       | NA           | OT\_MIX           | OT\_MIX                       | OTT\_MOL          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
|  458 | OTT\_MOL\_\>=120\_0\_0     | NA           | OT\_MIX           | OT\_MIX                       | OTT\_MOL          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
|  459 | OTT\_MOL\_\>=70\_0         | NA           | OT\_MIX           | OT\_MIX                       | OTT\_MOL          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
|  460 | OTT\_NOC\_100-119\_0\_0    | NA           | OT\_MIX           | NA                            | OTT\_NOC          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
|  461 | OTT\_NOC\_70-99\_0\_0      | NA           | OT\_MIX           | NA                            | OTT\_NOC          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
|  462 | OTT\_NOC\_\>=120\_0\_0     | NA           | OT\_MIX           | NA                            | OTT\_NOC          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
|  463 | OTT\_unk\_0\_0             | NA           | OT\_MIX           | NA                            | OTT\_unk          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
|  464 | OT\_CRU\_349               | NA           | OT\_CRU           | OT\_CRU                       | OT\_CRU           | OT             | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  465 | OT\_DEF\_0                 | NA           | OT\_DMF           | NA                            | OT\_DEF           | OT             | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  466 | OT\_DEF\_1249              | NA           | OT\_DMF           | OT\_DMF                       | OT\_DEF           | OT             | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  467 | OT\_DWS\_0                 | NA           | OT\_MIX\_DMF\_BEN | NA                            | OT\_DWS           | OT             | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  468 | OT\_DWS\_3999              | NA           | OT\_MIX\_DMF\_BEN | NA                            | OT\_DWS           | OT             | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  469 | OT\_SPF\_0                 | NA           | OT\_SPF           | NA                            | OT\_SPF           | OT             | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  470 | OT\_SPF\_5000              | NA           | OT\_SPF           | OT\_SPF                       | OT\_SPF           | OT             | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  471 | PS1\_DEF\_0                | NA           | NA                | NA                            | PS1\_DEF          | PS1            | NA                 | Seine             | Purse\_seine          |
|  472 | PS1\_DEF\_1249             | NA           | NA                | NA                            | PS1\_DEF          | PS1            | NA                 | Seine             | Purse\_seine          |
|  473 | PS1\_DEF\_1749             | NA           | NA                | NA                            | PS1\_DEF          | PS1            | NA                 | Seine             | Purse\_seine          |
|  474 | PS1\_DEF\_2499             | NA           | NA                | NA                            | PS1\_DEF          | PS1            | NA                 | Seine             | Purse\_seine          |
|  475 | PS1\_DEF\_349              | NA           | NA                | NA                            | PS1\_DEF          | PS1            | NA                 | Seine             | Purse\_seine          |
|  476 | PS1\_DEF\_3999             | NA           | NA                | NA                            | PS1\_DEF          | PS1            | NA                 | Seine             | Purse\_seine          |
|  477 | PS1\_DEF\_624              | NA           | NA                | NA                            | PS1\_DEF          | PS1            | NA                 | Seine             | Purse\_seine          |
|  478 | PS1\_DEF\_874              | NA           | NA                | NA                            | PS1\_DEF          | PS1            | NA                 | Seine             | Purse\_seine          |
|  479 | PS1\_LPF\_0                | NA           | NA                | NA                            | PS1\_LPF          | PS1            | NA                 | Seine             | Purse\_seine          |
|  480 | PS1\_SPF\_0                | NA           | NA                | NA                            | PS1\_SPF          | PS1            | NA                 | Seine             | Purse\_seine          |
|  481 | PS1\_SPF\_1249             | NA           | NA                | NA                            | PS1\_SPF          | PS1            | NA                 | Seine             | Purse\_seine          |
|  482 | PS1\_SPF\_149              | NA           | NA                | NA                            | PS1\_SPF          | PS1            | NA                 | Seine             | Purse\_seine          |
|  483 | PS1\_SPF\_1749             | NA           | NA                | NA                            | PS1\_SPF          | PS1            | NA                 | Seine             | Purse\_seine          |
|  484 | PS1\_SPF\_2499             | NA           | NA                | NA                            | PS1\_SPF          | PS1            | NA                 | Seine             | Purse\_seine          |
|  485 | PS1\_SPF\_349              | NA           | NA                | NA                            | PS1\_SPF          | PS1            | NA                 | Seine             | Purse\_seine          |
|  486 | PS1\_SPF\_3999             | NA           | NA                | NA                            | PS1\_SPF          | PS1            | NA                 | Seine             | Purse\_seine          |
|  487 | PS1\_SPF\_5000             | NA           | NA                | NA                            | PS1\_SPF          | PS1            | NA                 | Seine             | Purse\_seine          |
|  488 | PS1\_SPF\_624              | NA           | NA                | NA                            | PS1\_SPF          | PS1            | NA                 | Seine             | Purse\_seine          |
|  489 | PS1\_SPF\_874              | NA           | NA                | NA                            | PS1\_SPF          | PS1            | NA                 | Seine             | Purse\_seine          |
|  490 | PS1\_UNK\_0                | NA           | NA                | NA                            | PS1\_UNK          | PS1            | NA                 | Seine             | Purse\_seine          |
|  491 | PS2\_DEF\_0                | NA           | NA                | NA                            | PS2\_DEF          | PS2            | NA                 | Seine             | Purse\_seine          |
|  492 | PS2\_DEF\_1249             | NA           | NA                | NA                            | PS2\_DEF          | PS2            | NA                 | Seine             | Purse\_seine          |
|  493 | PS2\_DEF\_1749             | NA           | NA                | NA                            | PS2\_DEF          | PS2            | NA                 | Seine             | Purse\_seine          |
|  494 | PS2\_DEF\_2499             | NA           | NA                | NA                            | PS2\_DEF          | PS2            | NA                 | Seine             | Purse\_seine          |
|  495 | PS2\_DEF\_3999             | NA           | NA                | NA                            | PS2\_DEF          | PS2            | NA                 | Seine             | Purse\_seine          |
|  496 | PS2\_DEF\_5000             | NA           | NA                | NA                            | PS2\_DEF          | PS2            | NA                 | Seine             | Purse\_seine          |
|  497 | PS2\_DEF\_624              | NA           | NA                | NA                            | PS2\_DEF          | PS2            | NA                 | Seine             | Purse\_seine          |
|  498 | PS2\_DEF\_874              | NA           | NA                | NA                            | PS2\_DEF          | PS2            | NA                 | Seine             | Purse\_seine          |
|  499 | PS2\_DWS\_0                | NA           | NA                | NA                            | PS2\_DWS          | PS2            | NA                 | Seine             | Purse\_seine          |
|  500 | PS2\_DWS\_1749             | NA           | NA                | NA                            | PS2\_DWS          | PS2            | NA                 | Seine             | Purse\_seine          |
|  501 | PS2\_DWS\_2499             | NA           | NA                | NA                            | PS2\_DWS          | PS2            | NA                 | Seine             | Purse\_seine          |
|  502 | PS2\_DWS\_3999             | NA           | NA                | NA                            | PS2\_DWS          | PS2            | NA                 | Seine             | Purse\_seine          |
|  503 | PS2\_DWS\_5000             | NA           | NA                | NA                            | PS2\_DWS          | PS2            | NA                 | Seine             | Purse\_seine          |
|  504 | PS2\_LPF\_0                | NA           | NA                | NA                            | PS2\_LPF          | PS2            | NA                 | Seine             | Purse\_seine          |
|  505 | PS2\_SPF\_0                | NA           | NA                | NA                            | PS2\_SPF          | PS2            | NA                 | Seine             | Purse\_seine          |
|  506 | PS2\_SPF\_1249             | NA           | NA                | NA                            | PS2\_SPF          | PS2            | NA                 | Seine             | Purse\_seine          |
|  507 | PS2\_SPF\_149              | NA           | NA                | NA                            | PS2\_SPF          | PS2            | NA                 | Seine             | Purse\_seine          |
|  508 | PS2\_SPF\_1749             | NA           | NA                | NA                            | PS2\_SPF          | PS2            | NA                 | Seine             | Purse\_seine          |
|  509 | PS2\_SPF\_2499             | NA           | NA                | NA                            | PS2\_SPF          | PS2            | NA                 | Seine             | Purse\_seine          |
|  510 | PS2\_SPF\_349              | NA           | NA                | NA                            | PS2\_SPF          | PS2            | NA                 | Seine             | Purse\_seine          |
|  511 | PS2\_SPF\_3999             | NA           | NA                | NA                            | PS2\_SPF          | PS2            | NA                 | Seine             | Purse\_seine          |
|  512 | PTB\_DEF\_0\_0\_0          | NA           | OT\_DMF           | OT\_DMF                       | PTB\_DEF          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
|  513 | PTB\_DEF\_0\_16\_0         | NA           | OT\_DMF           | OT\_DMF                       | PTB\_DEF          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
|  514 | PTB\_DEF\_100-119\_0\_0    | NA           | OT\_DMF           | OT\_DMF                       | PTB\_DEF          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
|  515 | PTB\_DEF\_100\_119\_0      | NA           | OT\_DMF           | OT\_DMF                       | PTB\_DEF          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
|  516 | PTB\_DEF\_16-31\_0\_0      | NA           | OT\_DMF           | OT\_DMF                       | PTB\_DEF          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
|  517 | PTB\_DEF\_16\_31\_0        | NA           | OT\_DMF           | OT\_DMF                       | PTB\_DEF          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
|  518 | PTB\_DEF\_32-69\_0\_0      | NA           | OT\_DMF           | OT\_DMF                       | PTB\_DEF          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
|  519 | PTB\_DEF\_32\_54\_0        | NA           | OT\_DMF           | OT\_DMF                       | PTB\_DEF          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
|  520 | PTB\_DEF\_32\_69\_0        | NA           | OT\_DMF           | OT\_DMF                       | PTB\_DEF          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
|  521 | PTB\_DEF\_70-99\_0\_0      | NA           | OT\_DMF           | OT\_DMF                       | PTB\_DEF          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
|  522 | PTB\_DEF\_70\_99\_0        | NA           | OT\_DMF           | OT\_DMF                       | PTB\_DEF          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
|  523 | PTB\_DEF\_874              | NA           | OT\_DMF           | OT\_DMF                       | PTB\_DEF          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
|  524 | PTB\_DEF\_90-104\_0\_0     | NA           | OT\_DMF           | OT\_DMF                       | PTB\_DEF          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
|  525 | PTB\_DEF\_\<16\_0\_0       | NA           | OT\_DMF           | OT\_DMF                       | PTB\_DEF          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
|  526 | PTB\_DEF\_\>=105\_1\_110   | NA           | OT\_DMF           | OT\_DMF                       | PTB\_DEF          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
|  527 | PTB\_DEF\_\>=105\_1\_120   | NA           | OT\_DMF           | OT\_DMF                       | PTB\_DEF          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
|  528 | PTB\_DEF\_\>=120\_0        | NA           | OT\_DMF           | NA                            | PTB\_DEF          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
|  529 | PTB\_DEF\_\>=120\_0\_0     | NA           | OT\_DMF           | OT\_DMF                       | PTB\_DEF          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
|  530 | PTB\_DEF\_\>=70\_0         | NA           | OT\_DMF           | OT\_DMF                       | PTB\_DEF          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
|  531 | PTB\_DEF\_NA\_0\_0         | NA           | OT\_DMF           | OT\_DMF                       | PTB\_DEF          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
|  532 | PTB\_FWS\_\>0\_0\_0        | NA           | OT\_DMF           | OT\_DMF                       | PTB\_FWS          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
|  533 | PTB\_FWS\_NA\_0\_0         | NA           | OT\_DMF           | OT\_DMF                       | PTB\_FWS          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
|  534 | PTB\_LPF\_100-119\_0\_0    | NA           | OT\_MIX\_DMF\_PEL | NA                            | PTB\_LPF          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
|  535 | PTB\_MCD\_100-119\_0\_0    | NA           | OT\_MIX\_CRU\_DMF | OT\_MIX\_CRU                  | PTB\_MCD          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
|  536 | PTB\_MCD\_70-99\_0\_0      | NA           | OT\_MIX\_CRU\_DMF | OT\_MIX\_CRU                  | PTB\_MCD          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
|  537 | PTB\_MCD\_90-119\_0\_0     | NA           | OT\_MIX\_CRU\_DMF | OT\_MIX\_CRU                  | PTB\_MCD          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
|  538 | PTB\_MCD\_\>=120\_0\_0     | NA           | OT\_MIX\_CRU\_DMF | OT\_MIX\_CRU                  | PTB\_MCD          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
|  539 | PTB\_MOL\_70-99\_0\_0      | NA           | OT\_MIX           | OT\_MIX                       | PTB\_MOL          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
|  540 | PTB\_MOL\_874              | NA           | OT\_MIX           | OT\_MIX                       | PTB\_MOL          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
|  541 | PTB\_NOC\_\>=120\_0\_0     | NA           | OT\_MIX           | NA                            | PTB\_NOC          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
|  542 | PTB\_SPF\_0                | NA           | OT\_SPF           | NA                            | PTB\_SPF          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
|  543 | PTB\_SPF\_100-119\_0\_0    | NA           | OT\_SPF           | OT\_SPF                       | PTB\_SPF          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
|  544 | PTB\_SPF\_16-104\_0\_0     | NA           | OT\_SPF           | OT\_SPF                       | PTB\_SPF          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
|  545 | PTB\_SPF\_16-31\_0\_0      | NA           | OT\_SPF           | OT\_SPF                       | PTB\_SPF          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
|  546 | PTB\_SPF\_32-104\_0\_0     | NA           | OT\_SPF           | OT\_SPF                       | PTB\_SPF          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
|  547 | PTB\_SPF\_32-54\_0\_0      | NA           | OT\_SPF           | OT\_SPF                       | PTB\_SPF          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
|  548 | PTB\_SPF\_32-69\_0\_0      | NA           | OT\_SPF           | OT\_SPF                       | PTB\_SPF          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
|  549 | PTB\_SPF\_32-89\_0\_0      | NA           | OT\_SPF           | OT\_SPF                       | PTB\_SPF          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
|  550 | PTB\_SPF\_70-99\_0\_0      | NA           | OT\_SPF           | OT\_SPF                       | PTB\_SPF          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
|  551 | PTB\_SPF\_\>=105\_1\_110   | NA           | OT\_SPF           | OT\_SPF                       | PTB\_SPF          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
|  552 | PTB\_SPF\_\>=105\_1\_120   | NA           | OT\_SPF           | OT\_SPF                       | PTB\_SPF          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
|  553 | PTB\_SPF\_\>=120\_0\_0     | NA           | OT\_SPF           | OT\_SPF                       | PTB\_SPF          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
|  554 | PTB\_SPF\_NA\_0\_0         | NA           | OT\_SPF           | OT\_SPF                       | PTB\_SPF          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
|  555 | PTB\_UNK\_0                | NA           | OT\_MIX           | NA                            | PTB\_UNK          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
|  556 | PTB\_unk\_0\_0             | NA           | OT\_MIX           | NA                            | PTB\_unk          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
|  557 | PTM\_CEP\_100\_119\_0      | NA           | NA                | NA                            | PTM\_CEP          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
|  558 | PTM\_LPF\_\>=120\_0        | NA           | NA                | NA                            | PTM\_LPF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
|  559 | PTM\_LPF\_\>=120\_0\_0     | NA           | NA                | NA                            | PTM\_LPF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
|  560 | PTM\_LPF\_\>=70\_0         | NA           | NA                | NA                            | PTM\_LPF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
|  561 | PTM\_LPF\_\>=70\_0\_0      | NA           | NA                | NA                            | PTM\_LPF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
|  562 | PTM\_NOC\_32-69\_0\_0      | NA           | NA                | NA                            | PTM\_NOC          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
|  563 | PTM\_SPF\_0                | NA           | NA                | NA                            | PTM\_SPF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
|  564 | PTM\_SPF\_0\_0\_0          | NA           | NA                | NA                            | PTM\_SPF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
|  565 | PTM\_SPF\_0\_16\_0         | NA           | NA                | NA                            | PTM\_SPF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
|  566 | PTM\_SPF\_100-119\_0\_0    | NA           | NA                | NA                            | PTM\_SPF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
|  567 | PTM\_SPF\_100\_119\_0      | NA           | NA                | NA                            | PTM\_SPF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
|  568 | PTM\_SPF\_1249             | NA           | NA                | NA                            | PTM\_SPF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
|  569 | PTM\_SPF\_16-104\_0\_0     | NA           | NA                | NA                            | PTM\_SPF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
|  570 | PTM\_SPF\_16-31\_0\_0      | NA           | NA                | NA                            | PTM\_SPF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
|  571 | PTM\_SPF\_16\_31\_0        | NA           | NA                | NA                            | PTM\_SPF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
|  572 | PTM\_SPF\_1749             | NA           | NA                | NA                            | PTM\_SPF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
|  573 | PTM\_SPF\_2499             | NA           | NA                | NA                            | PTM\_SPF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
|  574 | PTM\_SPF\_32-104\_0\_0     | NA           | NA                | NA                            | PTM\_SPF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
|  575 | PTM\_SPF\_32-54\_0\_0      | NA           | NA                | NA                            | PTM\_SPF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
|  576 | PTM\_SPF\_32-69\_0\_0      | NA           | NA                | NA                            | PTM\_SPF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
|  577 | PTM\_SPF\_32-89\_0\_0      | NA           | NA                | NA                            | PTM\_SPF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
|  578 | PTM\_SPF\_32\_54\_0        | NA           | NA                | NA                            | PTM\_SPF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
|  579 | PTM\_SPF\_32\_69\_0        | NA           | NA                | NA                            | PTM\_SPF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
|  580 | PTM\_SPF\_349              | NA           | NA                | NA                            | PTM\_SPF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
|  581 | PTM\_SPF\_3999             | NA           | NA                | NA                            | PTM\_SPF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
|  582 | PTM\_SPF\_5000             | NA           | NA                | NA                            | PTM\_SPF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
|  583 | PTM\_SPF\_55\_69\_0        | NA           | NA                | NA                            | PTM\_SPF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
|  584 | PTM\_SPF\_70-99\_0\_0      | NA           | NA                | NA                            | PTM\_SPF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
|  585 | PTM\_SPF\_70\_99\_0        | NA           | NA                | NA                            | PTM\_SPF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
|  586 | PTM\_SPF\_874              | NA           | NA                | NA                            | PTM\_SPF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
|  587 | PTM\_SPF\_\<16\_0\_0       | NA           | NA                | NA                            | PTM\_SPF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
|  588 | PTM\_SPF\_\>=105\_1\_110   | NA           | NA                | NA                            | PTM\_SPF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
|  589 | PTM\_SPF\_\>=105\_1\_120   | NA           | NA                | NA                            | PTM\_SPF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
|  590 | PTM\_SPF\_\>=120\_0        | NA           | NA                | NA                            | PTM\_SPF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
|  591 | PTM\_SPF\_\>=120\_0\_0     | NA           | NA                | NA                            | PTM\_SPF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
|  592 | PTM\_SPF\_\>=70\_0         | NA           | NA                | NA                            | PTM\_SPF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
|  593 | PTM\_SPF\_UNK              | NA           | NA                | NA                            | PTM\_SPF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
|  594 | PTM\_SPF\_misc\_0\_0       | NA           | NA                | NA                            | PTM\_SPF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
|  595 | PTM\_UNK\_0                | NA           | NA                | NA                            | PTM\_UNK          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
|  596 | PTM\_UNK\_1749             | NA           | NA                | NA                            | PTM\_UNK          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
|  597 | PTM\_UNK\_3999             | NA           | NA                | NA                            | PTM\_UNK          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
|  598 | PTM\_UNK\_UNK              | NA           | NA                | NA                            | PTM\_UNK          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
|  599 | PT\_DEF\_874               | NA           | OT\_DMF           | OT\_DMF                       | PT\_DEF           | PT             | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
|  600 | PT\_SPF\_1249              | NA           | OT\_SPF           | OT\_SPF                       | PT\_SPF           | PT             | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
|  601 | PT\_SPF\_2499              | NA           | OT\_SPF           | OT\_SPF                       | PT\_SPF           | PT             | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
|  602 | QUA\_MCD\_100-119\_0\_0    | NA           | NA                | NA                            | QUA\_MCD          | QUA            | NA                 | NA                | NA                    |
|  603 | QUA\_MCD\_70-99\_0\_0      | NA           | NA                | NA                            | QUA\_MCD          | QUA            | NA                 | NA                | NA                    |
|  604 | QUA\_UND\_70-99\_0\_0      | NA           | NA                | NA                            | QUA\_UND          | QUA            | NA                 | NA                | NA                    |
|  605 | SB\_DEF\_0\_0\_0           | NA           | NA                | NA                            | SB\_DEF           | SB             | NA                 | Seine             | Beach seines          |
|  606 | SB\_DEF\_\<16\_0\_0        | NA           | NA                | NA                            | SB\_DEF           | SB             | NA                 | Seine             | Beach seines          |
|  607 | SB\_FIF\_0\_0\_0           | NA           | NA                | NA                            | SB\_FIF           | SB             | NA                 | Seine             | Beach seines          |
|  608 | SB\_FIF\_\<16\_0\_0        | NA           | NA                | NA                            | SB\_FIF           | SB             | NA                 | Seine             | Beach seines          |
|  609 | SB\_FIF\_\>0\_0\_0         | NA           | NA                | NA                            | SB\_FIF           | SB             | NA                 | Seine             | Beach seines          |
|  610 | SB\_FIF\_NA\_0\_0          | NA           | NA                | NA                            | SB\_FIF           | SB             | NA                 | Seine             | Beach seines          |
|  611 | SB\_SPF\_0\_0\_0           | NA           | NA                | NA                            | SB\_SPF           | SB             | NA                 | Seine             | Beach seines          |
|  612 | SDN\_CEP\_0\_0\_0          | NA           | SDN\_DMF          | SDN\_DMF                      | SDN\_CEP          | SDN            | NA                 | Seine             | Danish\_seine         |
|  613 | SSC\_DEF\_70-99            | NA           | SSC\_DMF          | SSC\_DMF                      | SSC\_DEF          | SSC            | NA                 | Seine             | Scottish\_Seine       |
|  614 | SSC\_DEF\_70-99\_0\_0      | NA           | SSC\_DMF          | SSC\_DMF                      | SSC\_DEF          | SSC            | NA                 | Seine             | Scottish\_Seine       |
|  615 | SSC\_DEF\_874              | NA           | SSC\_DMF          | SSC\_DMF                      | SSC\_DEF          | SSC            | NA                 | Seine             | Scottish\_Seine       |
|  616 | SSC\_DEF\_90-119\_0\_0     | NA           | SSC\_DMF          | SSC\_DMF                      | SSC\_DEF          | SSC            | NA                 | Seine             | Scottish\_Seine       |
|  617 | SSC\_DEF\_\<16\_0\_0       | NA           | SSC\_DMF          | NA                            | SSC\_DEF          | SSC            | NA                 | Seine             | Scottish\_Seine       |
|  618 | SSC\_DEF\_\>=105\_1\_110   | NA           | SSC\_DMF          | SSC\_DMF                      | SSC\_DEF          | SSC            | NA                 | Seine             | Scottish\_Seine       |
|  619 | SSC\_DEF\_\>=105\_1\_120   | NA           | SSC\_DMF          | SSC\_DMF                      | SSC\_DEF          | SSC            | NA                 | Seine             | Scottish\_Seine       |
|  620 | SSC\_DEF\_\>=120           | NA           | SSC\_DMF          | SSC\_DMF                      | SSC\_DEF          | SSC            | NA                 | Seine             | Scottish\_Seine       |
|  621 | SSC\_DEF\_\>=120\_0\_0     | NA           | SSC\_DMF          | SSC\_DMF                      | SSC\_DEF          | SSC            | NA                 | Seine             | Scottish\_Seine       |
|  622 | SSC\_DEF\_\>=16\_0\_0      | NA           | SSC\_DMF          | NA                            | SSC\_DEF          | SSC            | NA                 | Seine             | Scottish\_Seine       |
|  623 | SSC\_DEF\_\>=70\_0\_0      | NA           | SSC\_DMF          | SSC\_DMF                      | SSC\_DEF          | SSC            | NA                 | Seine             | Scottish\_Seine       |
|  624 | SSC\_DEF\_UND\_0\_0        | NA           | SSC\_DMF          | SSC\_DMF                      | SSC\_DEF          | SSC            | NA                 | Seine             | Scottish\_Seine       |
|  625 | SSC\_DWS\_1249             | NA           | SSC\_DMF          | NA                            | SSC\_DWS          | SSC            | NA                 | Seine             | Scottish\_Seine       |
|  626 | SSC\_MCF\_100-119\_0\_0    | NA           | SSC\_DMF          | SSC\_DMF                      | SSC\_MCF          | SSC            | NA                 | Seine             | Scottish\_Seine       |
|  627 | SSC\_NOC\_\>=120\_0\_0     | NA           | SSC\_DMF          | NA                            | SSC\_NOC          | SSC            | NA                 | Seine             | Scottish\_Seine       |
|  628 | SSC\_SPF\_0                | NA           | SSC\_DMF          | NA                            | SSC\_SPF          | SSC            | NA                 | Seine             | Scottish\_Seine       |
|  629 | SSC\_SPF\_1249             | NA           | SSC\_DMF          | NA                            | SSC\_SPF          | SSC            | NA                 | Seine             | Scottish\_Seine       |
|  630 | SSC\_SPF\_1749             | NA           | SSC\_DMF          | NA                            | SSC\_SPF          | SSC            | NA                 | Seine             | Scottish\_Seine       |
|  631 | SSC\_SPF\_2499             | NA           | SSC\_DMF          | NA                            | SSC\_SPF          | SSC            | NA                 | Seine             | Scottish\_Seine       |
|  632 | SSC\_SPF\_624              | NA           | SSC\_DMF          | NA                            | SSC\_SPF          | SSC            | NA                 | Seine             | Scottish\_Seine       |
|  633 | SSC\_SPF\_874              | NA           | SSC\_DMF          | NA                            | SSC\_SPF          | SSC            | NA                 | Seine             | Scottish\_Seine       |
|  634 | SSC\_UNK\_0                | NA           | SSC\_DMF          | NA                            | SSC\_UNK          | SSC            | NA                 | Seine             | Scottish\_Seine       |
|  635 | SSC\_UNK\_1249             | NA           | SSC\_DMF          | NA                            | SSC\_UNK          | SSC            | NA                 | Seine             | Scottish\_Seine       |
|  636 | SSC\_UNK\_1749             | NA           | SSC\_DMF          | NA                            | SSC\_UNK          | SSC            | NA                 | Seine             | Scottish\_Seine       |
|  637 | SSC\_UNK\_349              | NA           | SSC\_DMF          | NA                            | SSC\_UNK          | SSC            | NA                 | Seine             | Scottish\_Seine       |
|  638 | SSC\_UNK\_624              | NA           | SSC\_DMF          | NA                            | SSC\_UNK          | SSC            | NA                 | Seine             | Scottish\_Seine       |
|  639 | SSC\_UNK\_874              | NA           | SSC\_DMF          | NA                            | SSC\_UNK          | SSC            | NA                 | Seine             | Scottish\_Seine       |
|  640 | SUM\_UND\_100-119\_0\_0    | NA           | NA                | NA                            | SUM\_UND          | SUM            | NA                 | NA                | NA                    |
|  641 | SUM\_UND\_\>=120\_0\_0     | NA           | NA                | NA                            | SUM\_UND          | SUM            | NA                 | NA                | NA                    |
|  642 | SV\_DEF\_0                 | NA           | SDN\_DMF          | NA                            | SV\_DEF           | SV             | Seine              | Seine             | Seine                 |
|  643 | SV\_DEF\_1249              | NA           | SDN\_DMF          | SDN\_DMF                      | SV\_DEF           | SV             | Seine              | Seine             | Seine                 |
|  644 | SV\_DEF\_1749              | NA           | SDN\_DMF          | SDN\_DMF                      | SV\_DEF           | SV             | Seine              | Seine             | Seine                 |
|  645 | SV\_DEF\_2499              | NA           | SDN\_DMF          | SDN\_DMF                      | SV\_DEF           | SV             | Seine              | Seine             | Seine                 |
|  646 | SV\_DEF\_349               | NA           | SDN\_DMF          | SDN\_DMF                      | SV\_DEF           | SV             | Seine              | Seine             | Seine                 |
|  647 | SV\_DEF\_624               | NA           | SDN\_DMF          | SDN\_DMF                      | SV\_DEF           | SV             | Seine              | Seine             | Seine                 |
|  648 | SV\_DEF\_874               | NA           | SDN\_DMF          | SDN\_DMF                      | SV\_DEF           | SV             | Seine              | Seine             | Seine                 |
|  649 | SV\_FIF\_0\_0\_0           | NA           | SDN\_DMF          | NA                            | SV\_FIF           | SV             | Seine              | Seine             | Seine                 |
|  650 | SV\_SPF\_0                 | NA           | SDN\_DMF          | NA                            | SV\_SPF           | SV             | Seine              | Seine             | Seine                 |
|  651 | SV\_SPF\_0\_0\_0           | NA           | SDN\_DMF          | NA                            | SV\_SPF           | SV             | Seine              | Seine             | Seine                 |
|  652 | SV\_SPF\_624               | NA           | SDN\_DMF          | NA                            | SV\_SPF           | SV             | Seine              | Seine             | Seine                 |
|  653 | SX\_DEF\_0                 | NA           | SDN\_DMF          | NA                            | SX\_DEF           | SX             | NA                 | Seine             | Seine                 |
|  654 | SX\_DEF\_2499              | NA           | SDN\_DMF          | SDN\_DMF                      | SX\_DEF           | SX             | NA                 | Seine             | Seine                 |
|  655 | SX\_DEF\_624               | NA           | SDN\_DMF          | SDN\_DMF                      | SX\_DEF           | SX             | NA                 | Seine             | Seine                 |
|  656 | SX\_SPF\_0                 | NA           | SDN\_DMF          | NA                            | SX\_SPF           | SX             | NA                 | Seine             | Seine                 |
|  657 | SX\_SPF\_624               | NA           | SDN\_DMF          | NA                            | SX\_SPF           | SX             | NA                 | Seine             | Seine                 |
|  658 | TBB\_CEP\_0\_0\_0          | NA           | TBB\_DMF          | TBB\_DMF                      | TBB\_CEP          | TBB            | Beam\_Trawl        | Beam              | Beam\_Trawl           |
|  659 | TBB\_CRU\_0\_0\_0          | NA           | TBB\_CRU          | TBB\_CRU                      | TBB\_CRU          | TBB            | Beam\_Trawl        | Beam              | Beam\_Trawl           |
|  660 | TBB\_CRU\_100-119\_0\_0    | NA           | TBB\_CRU          | TBB\_CRU                      | TBB\_CRU          | TBB            | Beam\_Trawl        | Beam              | Beam\_Trawl           |
|  661 | TBB\_CRU\_100\_119\_0      | NA           | TBB\_CRU          | TBB\_CRU                      | TBB\_CRU          | TBB            | Beam\_Trawl        | Beam              | Beam\_Trawl           |
|  662 | TBB\_CRU\_16-31            | NA           | TBB\_CRU          | TBB\_CRU                      | TBB\_CRU          | TBB            | Beam\_Trawl        | Beam              | Beam\_Trawl           |
|  663 | TBB\_CRU\_16-31\_0\_0      | NA           | TBB\_CRU          | TBB\_CRU                      | TBB\_CRU          | TBB            | Beam\_Trawl        | Beam              | Beam\_Trawl           |
|  664 | TBB\_CRU\_16\_31\_0        | NA           | TBB\_CRU          | TBB\_CRU                      | TBB\_CRU          | TBB            | Beam\_Trawl        | Beam              | Beam\_Trawl           |
|  665 | TBB\_CRU\_32-69\_0\_0      | NA           | TBB\_CRU          | TBB\_CRU                      | TBB\_CRU          | TBB            | Beam\_Trawl        | Beam              | Beam\_Trawl           |
|  666 | TBB\_CRU\_70-99\_0\_0      | NA           | TBB\_CRU          | TBB\_CRU                      | TBB\_CRU          | TBB            | Beam\_Trawl        | Beam              | Beam\_Trawl           |
|  667 | TBB\_CRU\_70\_99\_0        | NA           | TBB\_CRU          | TBB\_CRU                      | TBB\_CRU          | TBB            | Beam\_Trawl        | Beam              | Beam\_Trawl           |
|  668 | TBB\_CRU\_\<16\_0\_0       | NA           | TBB\_CRU          | TBB\_CRU                      | TBB\_CRU          | TBB            | Beam\_Trawl        | Beam              | Beam\_Trawl           |
|  669 | TBB\_CRU\_\>=120\_0\_0     | NA           | TBB\_CRU          | TBB\_CRU                      | TBB\_CRU          | TBB            | Beam\_Trawl        | Beam              | Beam\_Trawl           |
|  670 | TBS\_DEF\_16-31\_0\_0      | NA           | OT\_CRU           | OT\_DMF                       | TBS\_DEF          | TBS            | Otter\_Trawl       | Otter             | Shrimp\_Trawl         |
|  671 | TBS\_DEF\_349              | NA           | OT\_CRU           | OT\_DMF                       | TBS\_DEF          | TBS            | Otter\_Trawl       | Otter             | Shrimp\_Trawl         |
|  672 | TBS\_DEF\_624              | NA           | OT\_CRU           | OT\_DMF                       | TBS\_DEF          | TBS            | Otter\_Trawl       | Otter             | Shrimp\_Trawl         |
|  673 | TBS\_DEF\_874              | NA           | OT\_CRU           | OT\_DMF                       | TBS\_DEF          | TBS            | Otter\_Trawl       | Otter             | Shrimp\_Trawl         |
|  674 | TBS\_SPF\_0                | NA           | OT\_CRU           | NA                            | TBS\_SPF          | TBS            | Otter\_Trawl       | Otter             | Shrimp\_Trawl         |
|  675 | TBS\_SPF\_1249             | NA           | OT\_CRU           | OT\_SPF                       | TBS\_SPF          | TBS            | Otter\_Trawl       | Otter             | Shrimp\_Trawl         |
|  676 | TBS\_SPF\_349              | NA           | OT\_CRU           | OT\_SPF                       | TBS\_SPF          | TBS            | Otter\_Trawl       | Otter             | Shrimp\_Trawl         |
|  677 | TBS\_SPF\_5000             | NA           | OT\_CRU           | OT\_SPF                       | TBS\_SPF          | TBS            | Otter\_Trawl       | Otter             | Shrimp\_Trawl         |
|  678 | TBS\_UNK\_0                | NA           | OT\_CRU           | NA                            | TBS\_UNK          | TBS            | Otter\_Trawl       | Otter             | Shrimp\_Trawl         |
|  679 | TBS\_UNK\_349              | NA           | OT\_CRU           | NA                            | TBS\_UNK          | TBS            | Otter\_Trawl       | Otter             | Shrimp\_Trawl         |
|  680 | TBS\_UNK\_874              | NA           | OT\_CRU           | NA                            | TBS\_UNK          | TBS            | Otter\_Trawl       | Otter             | Shrimp\_Trawl         |
|  681 | TB\_CRU\_0                 | NA           | OT\_CRU           | NA                            | TB\_CRU           | TB             | Otter\_Trawl       | Otter             | Bottom\_Trawl         |
|  682 | TB\_CRU\_624               | NA           | OT\_CRU           | OT\_CRU                       | TB\_CRU           | TB             | Otter\_Trawl       | Otter             | Bottom\_Trawl         |
|  683 | TB\_DEF\_0                 | NA           | OT\_DMF           | NA                            | TB\_DEF           | TB             | Otter\_Trawl       | Otter             | Bottom\_Trawl         |
|  684 | TB\_DEF\_3999              | NA           | OT\_DMF           | OT\_DMF                       | TB\_DEF           | TB             | Otter\_Trawl       | Otter             | Bottom\_Trawl         |
|  685 | TB\_DEF\_624               | NA           | OT\_DMF           | OT\_DMF                       | TB\_DEF           | TB             | Otter\_Trawl       | Otter             | Bottom\_Trawl         |
|  686 | TB\_SPF\_0                 | NA           | OT\_SPF           | NA                            | TB\_SPF           | TB             | Otter\_Trawl       | Otter             | Bottom\_Trawl         |
|  687 | TB\_SPF\_3999              | NA           | OT\_SPF           | OT\_SPF                       | TB\_SPF           | TB             | Otter\_Trawl       | Otter             | Bottom\_Trawl         |
|  688 | TB\_SPF\_5000              | NA           | OT\_SPF           | OT\_SPF                       | TB\_SPF           | TB             | Otter\_Trawl       | Otter             | Bottom\_Trawl         |
|  689 | TMS\_CRU\_0                | NA           | OT\_CRU           | NA                            | TMS\_CRU          | TMS            | NA                 | Otter             | Midwater\_Beam        |
|  690 | TMS\_CRU\_2499             | NA           | OT\_CRU           | NA                            | TMS\_CRU          | TMS            | NA                 | Otter             | Midwater\_Beam        |
|  691 | TMS\_CRU\_349              | NA           | OT\_CRU           | NA                            | TMS\_CRU          | TMS            | NA                 | Otter             | Midwater\_Beam        |
|  692 | TMS\_CRU\_624              | NA           | OT\_CRU           | NA                            | TMS\_CRU          | TMS            | NA                 | Otter             | Midwater\_Beam        |
|  693 | TMS\_CRU\_874              | NA           | OT\_CRU           | NA                            | TMS\_CRU          | TMS            | NA                 | Otter             | Midwater\_Beam        |
|  694 | TMS\_DEF\_0                | NA           | OT\_CRU           | NA                            | TMS\_DEF          | TMS            | NA                 | Otter             | Midwater\_Beam        |
|  695 | TMS\_DEF\_874              | NA           | OT\_CRU           | NA                            | TMS\_DEF          | TMS            | NA                 | Otter             | Midwater\_Beam        |
|  696 | TM\_DEF\_0                 | NA           | NA                | NA                            | TM\_DEF           | TM             | NA                 | Midwater          | Midwater\_Beam        |
|  697 | TM\_DEF\_349               | NA           | NA                | NA                            | TM\_DEF           | TM             | NA                 | Midwater          | Midwater\_Beam        |
|  698 | TM\_SPF\_0                 | NA           | NA                | NA                            | TM\_SPF           | TM             | NA                 | Midwater          | Midwater\_Beam        |
|  699 | TM\_SPF\_349               | NA           | NA                | NA                            | TM\_SPF           | TM             | NA                 | Midwater          | Midwater\_Beam        |
|  700 | TM\_SPF\_3999              | NA           | NA                | NA                            | TM\_SPF           | TM             | NA                 | Midwater          | Midwater\_Beam        |
|  701 | TM\_SPF\_5000              | NA           | NA                | NA                            | TM\_SPF           | TM             | NA                 | Midwater          | Midwater\_Beam        |
|  702 | TX\_CRU\_349               | NA           | NA                | NA                            | TX\_CRU           | TX             | NA                 | Other             | Other                 |
|  703 | UNKNOWN                    | NA           | NA                | NA                            | NA                | NA             | NA                 | NA                | NA                    |
|  704 | XXXXXXXXXXXXXXXXXXXX       | NA           | NA                | NA                            | NA                | NA             | NA                 | NA                | NA                    |
|  705 | XXXXXXXXXXXXXXXXXXXXXXX    | NA           | NA                | NA                            | NA                | NA             | NA                 | NA                | NA                    |
|  706 | XXX\_vvv\_vvv\_vvv\_vvv    | NA           | NA                | NA                            | NA                | NA             | NA                 | NA                | NA                    |
|  708 | TBB\_CRU\_\>=70\_0         | NA           | TBB\_CRU          | TBB\_CRU                      | TBB\_CRU          | TBB            | Beam\_Trawl        | Beam              | Beam\_Trawl           |
|  709 | TBB\_DEF\_0                | NA           | TBB\_DMF          | TBB\_DMF                      | TBB\_DEF          | TBB            | Beam\_Trawl        | Beam              | Beam\_Trawl           |
|  710 | TBB\_DEF\_0\_0\_0          | NA           | TBB\_DMF          | TBB\_DMF                      | TBB\_DEF          | TBB            | Beam\_Trawl        | Beam              | Beam\_Trawl           |
|  711 | TBB\_DEF\_0\_16\_0         | NA           | TBB\_DMF          | TBB\_DMF                      | TBB\_DEF          | TBB            | Beam\_Trawl        | Beam              | Beam\_Trawl           |
|  712 | TBB\_DEF\_100-119          | NA           | TBB\_DMF          | TBB\_DMF                      | TBB\_DEF          | TBB            | Beam\_Trawl        | Beam              | Beam\_Trawl           |
|  713 | TBB\_DEF\_100-119\_0\_0    | NA           | TBB\_DMF          | TBB\_DMF                      | TBB\_DEF          | TBB            | Beam\_Trawl        | Beam              | Beam\_Trawl           |
|  714 | TBB\_DEF\_100\_119\_0      | NA           | TBB\_DMF          | TBB\_DMF                      | TBB\_DEF          | TBB            | Beam\_Trawl        | Beam              | Beam\_Trawl           |
|  715 | TBB\_DEF\_16-31\_0\_0      | NA           | TBB\_DMF          | TBB\_DMF                      | TBB\_DEF          | TBB            | Beam\_Trawl        | Beam              | Beam\_Trawl           |
|  716 | TBB\_DEF\_16\_31\_0        | NA           | TBB\_DMF          | TBB\_DMF                      | TBB\_DEF          | TBB            | Beam\_Trawl        | Beam              | Beam\_Trawl           |
|  717 | TBB\_DEF\_32-69\_0\_0      | NA           | TBB\_DMF          | TBB\_DMF                      | TBB\_DEF          | TBB            | Beam\_Trawl        | Beam              | Beam\_Trawl           |
|  718 | TBB\_DEF\_32\_69\_0        | NA           | TBB\_DMF          | TBB\_DMF                      | TBB\_DEF          | TBB            | Beam\_Trawl        | Beam              | Beam\_Trawl           |
|  719 | TBB\_DEF\_70-89\_0\_0      | NA           | TBB\_DMF          | TBB\_DMF                      | TBB\_DEF          | TBB            | Beam\_Trawl        | Beam              | Beam\_Trawl           |
|  720 | TBB\_DEF\_70-99            | NA           | TBB\_DMF          | TBB\_DMF                      | TBB\_DEF          | TBB            | Beam\_Trawl        | Beam              | Beam\_Trawl           |
|  721 | TBB\_DEF\_70-99\_0\_0      | NA           | TBB\_DMF          | TBB\_DMF                      | TBB\_DEF          | TBB            | Beam\_Trawl        | Beam              | Beam\_Trawl           |
|  722 | TBB\_DEF\_70\_99\_0        | NA           | TBB\_DMF          | TBB\_DMF                      | TBB\_DEF          | TBB            | Beam\_Trawl        | Beam              | Beam\_Trawl           |
|  723 | TBB\_DEF\_90-119\_0\_0     | NA           | TBB\_DMF          | TBB\_DMF                      | TBB\_DEF          | TBB            | Beam\_Trawl        | Beam              | Beam\_Trawl           |
|  724 | TBB\_DEF\_\<16\_0\_0       | NA           | TBB\_DMF          | TBB\_DMF                      | TBB\_DEF          | TBB            | Beam\_Trawl        | Beam              | Beam\_Trawl           |
|  725 | TBB\_DEF\_\>=120           | NA           | TBB\_DMF          | TBB\_DMF                      | TBB\_DEF          | TBB            | Beam\_Trawl        | Beam              | Beam\_Trawl           |
|  726 | TBB\_DEF\_\>=120\_0        | NA           | TBB\_DMF          | TBB\_DMF                      | TBB\_DEF          | TBB            | Beam\_Trawl        | Beam              | Beam\_Trawl           |
|  727 | TBB\_DEF\_\>=120\_0\_0     | NA           | TBB\_DMF          | TBB\_DMF                      | TBB\_DEF          | TBB            | Beam\_Trawl        | Beam              | Beam\_Trawl           |
|  728 | TBB\_DEF\_\>=70\_0         | NA           | TBB\_DMF          | TBB\_DMF                      | TBB\_DEF          | TBB            | Beam\_Trawl        | Beam              | Beam\_Trawl           |
|  729 | TBB\_DEF\_UND\_0\_0        | NA           | TBB\_DMF          | TBB\_DMF                      | TBB\_DEF          | TBB            | Beam\_Trawl        | Beam              | Beam\_Trawl           |
|  730 | TBB\_DWS\_70-99\_0\_0      | NA           | TBB\_DMF          | NA                            | TBB\_DWS          | TBB            | Beam\_Trawl        | Beam              | Beam\_Trawl           |
|  731 | TBB\_MCD\_16-31\_0\_0      | NA           | TBB\_CRU          | TBB\_CRU                      | TBB\_MCD          | TBB            | Beam\_Trawl        | Beam              | Beam\_Trawl           |
|  732 | TBB\_MCD\_70-99\_0\_0      | NA           | TBB\_DMF          | TBB\_CRU                      | TBB\_MCD          | TBB            | Beam\_Trawl        | Beam              | Beam\_Trawl           |
|  733 | TBB\_MCD\_\>=120\_0\_0     | NA           | TBB\_DMF          | TBB\_CRU                      | TBB\_MCD          | TBB            | Beam\_Trawl        | Beam              | Beam\_Trawl           |
|  734 | TBB\_MOL\_0\_0\_0          | NA           | TBB\_MOL          | TBB\_MOL                      | TBB\_MOL          | TBB            | Beam\_Trawl        | Beam              | Beam\_Trawl           |
|  735 | TBB\_MOL\_100-119\_0\_0    | NA           | TBB\_MOL          | TBB\_MOL                      | TBB\_MOL          | TBB            | Beam\_Trawl        | Beam              | Beam\_Trawl           |
|  736 | TBB\_MOL\_16\_31\_0        | NA           | TBB\_MOL          | TBB\_MOL                      | TBB\_MOL          | TBB            | Beam\_Trawl        | Beam              | Beam\_Trawl           |
|  737 | TBB\_MOL\_70-99\_0\_0      | NA           | TBB\_MOL          | TBB\_MOL                      | TBB\_MOL          | TBB            | Beam\_Trawl        | Beam              | Beam\_Trawl           |
|  738 | TBB\_MOL\_70\_99\_0        | NA           | TBB\_MOL          | TBB\_MOL                      | TBB\_MOL          | TBB            | Beam\_Trawl        | Beam              | Beam\_Trawl           |
|  739 | TBB\_SPF\_70-99\_0\_0      | NA           | TBB\_DMF          | NA                            | TBB\_SPF          | TNN            | Beam\_Trawl        | Beam              | Beam\_Trawl           |
|  740 | TBN\_CRU\_0                | NA           | OT\_CRU           | NA                            | TBN\_CRU          | TBN            | Nephrops\_Trawl    | Otter             | Nephrops\_Trawl       |
|  741 | TBN\_CRU\_349              | NA           | OT\_CRU           | OT\_CRU                       | TBN\_CRU          | TBN            | Nephrops\_Trawl    | Otter             | Nephrops\_Trawl       |
|  742 | TBN\_CRU\_624              | NA           | OT\_CRU           | OT\_CRU                       | TBN\_CRU          | TBN            | Nephrops\_Trawl    | Otter             | Nephrops\_Trawl       |
|  743 | TBN\_DEF\_0                | NA           | OT\_CRU           | NA                            | TBN\_DEF          | TBN            | Nephrops\_Trawl    | Otter             | Nephrops\_Trawl       |
|  744 | TBN\_DEF\_349              | NA           | OT\_CRU           | OT\_DMF                       | TBN\_DEF          | TBN            | Nephrops\_Trawl    | Otter             | Nephrops\_Trawl       |
|  745 | TBN\_DEF\_624              | NA           | OT\_CRU           | OT\_DMF                       | TBN\_DEF          | TBN            | Nephrops\_Trawl    | Otter             | Nephrops\_Trawl       |
|  746 | TBN\_UNK\_0                | NA           | OT\_CRU           | NA                            | TBN\_UNK          | TBN            | Nephrops\_Trawl    | Otter             | Nephrops\_Trawl       |
|  747 | TBN\_UNK\_624              | NA           | OT\_CRU           | NA                            | TBN\_UNK          | TBN            | Nephrops\_Trawl    | Otter             | Nephrops\_Trawl       |
|  748 | TBS\_CRU\_0                | NA           | OT\_CRU           | NA                            | TBS\_CRU          | TBS            | Otter\_Trawl       | Otter             | Shrimp\_Trawl         |
|  749 | TBS\_CRU\_1249             | NA           | OT\_CRU           | OT\_CRU                       | TBS\_CRU          | TBS            | Otter\_Trawl       | Otter             | Shrimp\_Trawl         |
|  750 | TBS\_CRU\_16-31\_0\_0      | NA           | OT\_CRU           | NA                            | TBS\_CRU          | TBS            | Otter\_Trawl       | Otter             | Shrimp\_Trawl         |
|  751 | TBS\_CRU\_349              | NA           | OT\_CRU           | OT\_CRU                       | TBS\_CRU          | TBS            | Otter\_Trawl       | Otter             | Shrimp\_Trawl         |
|  752 | TBS\_CRU\_5000             | NA           | OT\_CRU           | OT\_CRU                       | TBS\_CRU          | TBS            | Otter\_Trawl       | Otter             | Shrimp\_Trawl         |
|  753 | TBS\_CRU\_624              | NA           | OT\_CRU           | OT\_CRU                       | TBS\_CRU          | TBS            | Otter\_Trawl       | Otter             | Shrimp\_Trawl         |
|  754 | TBS\_CRU\_874              | NA           | OT\_CRU           | OT\_CRU                       | TBS\_CRU          | TBS            | Otter\_Trawl       | Otter             | Shrimp\_Trawl         |
|  755 | TBS\_CRU\_\<16\_0\_0       | NA           | OT\_CRU           | NA                            | TBS\_CRU          | TBS            | Otter\_Trawl       | Otter             | Shrimp\_Trawl         |
|  756 | TBS\_DEF\_0                | NA           | OT\_CRU           | NA                            | TBS\_DEF          | TBS            | Otter\_Trawl       | Otter             | Shrimp\_Trawl         |
|  757 | TBS\_DEF\_1249             | NA           | OT\_CRU           | OT\_DMF                       | TBS\_DEF          | TBS            | Otter\_Trawl       | Otter             | Shrimp\_Trawl         |
|  822 | LTL\_DEF\_349              | NA           | NA                | NA                            | LTL\_DEF          | LTL            | NA                 | Static            | Lines                 |
|  823 | LTL\_LPF\_0\_0\_0          | NA           | NA                | NA                            | LTL\_LPF          | LTL            | NA                 | Static            | Lines                 |
|  824 | LTL\_SPF\_0                | NA           | NA                | NA                            | LTL\_SPF          | LTL            | NA                 | Static            | Lines                 |
|  825 | LTL\_SPF\_0\_0\_0          | NA           | NA                | NA                            | LTL\_SPF          | LTL            | NA                 | Static            | Lines                 |
|  826 | LTL\_SPF\_1249             | NA           | NA                | NA                            | LTL\_SPF          | LTL            | NA                 | Static            | Lines                 |
|  827 | LTL\_SPF\_2499             | NA           | NA                | NA                            | LTL\_SPF          | LTL            | NA                 | Static            | Lines                 |
|  828 | LTL\_SPF\_349              | NA           | NA                | NA                            | LTL\_SPF          | LTL            | NA                 | Static            | Lines                 |
|  829 | LTL\_SPF\_624              | NA           | NA                | NA                            | LTL\_SPF          | LTL            | NA                 | Static            | Lines                 |
|  830 | LTL\_SPF\_874              | NA           | NA                | NA                            | LTL\_SPF          | LTL            | NA                 | Static            | Lines                 |
|  831 | LX\_DEF\_0                 | NA           | NA                | NA                            | LX\_DEF           | LX             | NA                 | Static            | Lines                 |
|  832 | LX\_DEF\_349               | NA           | NA                | NA                            | LX\_DEF           | LX             | NA                 | Static            | Lines                 |
|  833 | MIS\_CRU\_0-0\_0\_0        | NA           | NA                | NA                            | MIS\_CRU          | MIS            | NA                 | Other             | Other                 |
|  834 | MIS\_DEF\_0-0\_0\_0        | NA           | NA                | NA                            | MIS\_DEF          | MIS            | NA                 | Other             | Other                 |
|  835 | MIS\_DEF\_0\_0\_0          | NA           | NA                | NA                            | MIS\_DEF          | MIS            | NA                 | Other             | Other                 |
|  836 | MIS\_DEF\_874              | NA           | NA                | NA                            | MIS\_DEF          | MIS            | NA                 | Other             | Other                 |
|  837 | MIS\_DES\_0\_0\_0          | NA           | NA                | NA                            | MIS\_DES          | MIS            | NA                 | Other             | Other                 |
|  838 | MIS\_FWS\_0\_0\_0          | NA           | NA                | NA                            | MIS\_FWS          | MIS            | NA                 | Other             | Other                 |
|  839 | MIS\_MIS\_0\_0\_0          | NA           | NA                | NA                            | MIS\_MIS          | MIS            | NA                 | Other             | Other                 |
|  840 | MIS\_MPD\_0-0\_0\_0        | NA           | NA                | NA                            | MIS\_MPD          | MIS            | NA                 | Other             | Other                 |
|  841 | MIS\_SPF\_0-0\_0\_0        | NA           | NA                | NA                            | MIS\_SPF          | MIS            | NA                 | Other             | Other                 |
|  842 | MIS\_SPF\_0\_0\_0          | NA           | NA                | NA                            | MIS\_SPF          | MIS            | NA                 | Other             | Other                 |
|  843 | MIS\_SWD\_0\_0\_0          | NA           | NA                | NA                            | MIS\_SWD          | MIS            | NA                 | Other             | Other                 |
|  844 | MIS\_UND\_UND\_0\_0        | NA           | NA                | NA                            | MIS\_UND          | MIS            | NA                 | Other             | Other                 |
|  845 | NA                         | NA           | NA                | NA                            | NA                | NA             | NA                 | NA                | NA                    |
|  846 | NK\_DEF\_1249              | NA           | NA                | NA                            | NA                | NA             | NA                 | NA                | NA                    |
|  847 | NK\_DEF\_874               | NA           | NA                | NA                            | NA                | NA             | NA                 | NA                | NA                    |
|  848 | NO\_SPF\_UNK               | NA           | NA                | NA                            | NA                | NA             | NA                 | NA                | NA                    |
|  849 | NULL                       | NA           | NA                | NA                            | NA                | NA             | NA                 | NA                | NA                    |
|  850 | No\_Matrix6                | NA           | NA                | NA                            | NA                | NA             | NA                 | NA                | NA                    |
|  851 | No\_logbook6               | NA           | NA                | NA                            | NA                | NA             | NA                 | NA                | NA                    |
|  852 | OTB/OTM                    | NA           | OT\_MIX           | OT\_MIX                       | OTB/OTM           | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  853 | OTB\_ANA\_0\_0\_0          | NA           | OT\_MIX           | OT\_MIX\_DMF\_PEL             | OTB\_ANA          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  854 | OTB\_CAT\_0\_0\_0          | NA           | OT\_MIX           | OT\_MIX\_DMF\_PEL             | OTB\_CAT          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  855 | OTB\_CAT\_16\_31\_0        | NA           | OT\_MIX           | OT\_MIX\_DMF\_PEL             | OTB\_CAT          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  856 | OTB\_CAT\_20\_39\_0        | NA           | OT\_MIX           | OT\_MIX\_DMF\_PEL             | OTB\_CAT          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  857 | OTB\_CAT\_32\_54\_0        | NA           | OT\_MIX           | OT\_MIX\_DMF\_PEL             | OTB\_CAT          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  858 | OTB\_CAT\_55\_69\_0        | NA           | OT\_MIX           | OT\_MIX\_DMF\_PEL             | OTB\_CAT          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  859 | OTB\_CAT\_70\_99\_0        | NA           | OT\_MIX           | OT\_MIX\_DMF\_PEL             | OTB\_CAT          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  860 | OTB\_CAT\_\>0\_0\_0        | NA           | OT\_MIX           | OT\_MIX\_DMF\_PEL             | OTB\_CAT          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  861 | OTB\_CAT\_\>=70\_0         | NA           | OT\_MIX           | OT\_MIX\_DMF\_PEL             | OTB\_CAT          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  862 | OTB\_CEP\_0\_0\_0          | NA           | OT\_MIX           | NA                            | OTB\_CEP          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  863 | OTB\_CEP\_0\_16\_0         | NA           | OT\_MIX           | NA                            | OTB\_CEP          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  864 | OTB\_CEP\_100\_119\_0      | NA           | OT\_MIX           | NA                            | OTB\_CEP          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  865 | OTB\_CEP\_16\_31\_0        | NA           | OT\_MIX           | NA                            | OTB\_CEP          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  866 | OTB\_CEP\_32\_54\_0        | NA           | OT\_MIX           | NA                            | OTB\_CEP          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  867 | OTB\_CEP\_32\_69\_0        | NA           | OT\_MIX           | NA                            | OTB\_CEP          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  868 | OTB\_CEP\_55\_69\_0        | NA           | OT\_MIX           | NA                            | OTB\_CEP          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  869 | OTB\_CEP\_70\_99\_0        | NA           | OT\_MIX           | NA                            | OTB\_CEP          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  870 | OTB\_CEP\_\>=120\_0        | NA           | OT\_MIX           | NA                            | OTB\_CEP          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  871 | OTB\_CEP\_\>=65\_0         | NA           | OT\_MIX           | NA                            | OTB\_CEP          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  872 | OTB\_CEP\_\>=70\_0         | NA           | OT\_MIX           | NA                            | OTB\_CEP          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  873 | OTB\_CHECK\_100-119\_0     | NA           | OT\_MIX           | NA                            | OTB\_CHE          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  874 | OTB\_CHECK\_100-119\_0\_   | NA           | OT\_MIX           | NA                            | OTB\_CHE          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  875 | OTB\_CHECK\_32-69\_0\_0    | NA           | OT\_MIX           | NA                            | OTB\_CHE          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  876 | OTB\_CHECK\_70-99\_0\_0    | NA           | OT\_MIX           | NA                            | OTB\_CHE          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  877 | OTB\_CHECK\_\>=120\_0\_0   | NA           | OT\_MIX           | NA                            | OTB\_CHE          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  878 | OTB\_CRU\_0                | NA           | OT\_CRU           | NA                            | OTB\_CRU          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  879 | OTB\_CRU\_0-0\_0\_0        | NA           | OT\_CRU           | OT\_CRU                       | OTB\_CRU          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  880 | OTB\_CRU\_0\_0\_0          | NA           | OT\_CRU           | OT\_CRU                       | OTB\_CRU          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  881 | OTB\_CRU\_0\_16\_0         | NA           | OT\_CRU           | OT\_CRU                       | OTB\_CRU          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  882 | OTB\_DEF\_2499             | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  883 | OTB\_DEF\_32-69\_0\_0      | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  884 | OTB\_DEF\_32\_54\_0        | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  885 | OTB\_DEF\_32\_69\_0        | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  886 | OTB\_DEF\_349              | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  887 | OTB\_DEF\_3999             | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  888 | OTB\_DEF\_40\_54\_0        | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  889 | OTB\_DEF\_5000             | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  890 | OTB\_DEF\_55-69\_0\_0      | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  891 | OTB\_DEF\_55\_69\_0        | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  892 | OTB\_DEF\_624              | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  893 | OTB\_DEF\_65-69\_0\_0      | NA           | OT\_DMF           | NA                            | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  894 | OTB\_DEF\_70-89\_2\_35     | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  895 | OTB\_DEF\_70-99            | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  896 | OTB\_DEF\_70-99\_0\_0      | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  897 | OTB\_DEF\_70\_89\_0        | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  898 | OTB\_DEF\_70\_99\_0        | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  899 | OTB\_DEF\_874              | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  900 | OTB\_DEF\_90-104\_0\_0     | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  901 | OTB\_DEF\_90-119\_0\_0     | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  902 | OTB\_DEF\_90-119\_1\_110   | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  903 | OTB\_DEF\_90-119\_1\_120   | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  904 | OTB\_DEF\_90-119\_1\_140   | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  905 | OTB\_DEF\_90-119\_1\_300   | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  906 | OTB\_DEF\_90-99\_0\_0      | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  907 | OTB\_DEF\_90\_119\_0       | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  910 | OTB\_DEF\_\>=105\_0\_0     | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  911 | OTB\_DEF\_\>=105\_1\_110   | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  912 | OTB\_DEF\_\>=105\_1\_120   | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  913 | OTB\_DEF\_\>=120           | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  914 | OTB\_DEF\_\>=120\_0        | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  915 | OTB\_DEF\_\>=120\_0\_0     | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  916 | OTB\_DEF\_\>=120\_1\_110   | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  917 | OTB\_DEF\_\>=120\_1\_120   | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  918 | OTB\_DEF\_\>=130\_0\_0     | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  919 | OTB\_DEF\_\>=55\_0\_0      | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  920 | OTB\_DEF\_\>=65\_0         | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  921 | OTB\_DEF\_\>=65\_0\_0      | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  922 | OTB\_DEF\_\>=70\_0         | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  923 | OTB\_DEF\_\>=70\_0\_0      | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  924 | OTB\_DEF\_UND\_0\_0        | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  925 | OTB\_DEF\_UNK              | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  926 | OTB\_DEF\_misc\_0\_0       | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  927 | OTB\_DEF\_misc\_1\_110     | NA           | OT\_DMF           | OT\_DMF                       | OTB\_DEF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  928 | OTB\_DWS\_0                | NA           | OT\_MIX\_DMF\_BEN | NA                            | OTB\_DWS          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  929 | OTB\_DWS\_100-119\_0\_0    | NA           | OT\_MIX\_DMF\_BEN | OT\_MIX\_DMF\_BEN             | OTB\_DWS          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  930 | OTB\_MCF\_70-99\_0\_0      | NA           | OT\_MIX\_DMF\_PEL | OT\_MIX\_DMF\_PEL             | OTB\_MCF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  931 | OTB\_MIS\_0\_0\_0          | NA           | OT\_MIX           | OT\_MIX                       | OTB\_MIS          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  932 | OTB\_MOL\_0                | NA           | OT\_MIX           | NA                            | OTB\_MOL          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  933 | OTB\_MOL\_0\_0\_0          | NA           | OT\_MIX           | OT\_MIX                       | OTB\_MOL          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  934 | OTB\_MOL\_0\_16\_0         | NA           | OT\_MIX           | OT\_MIX                       | OTB\_MOL          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  935 | OTB\_MOL\_100-119\_0\_0    | NA           | OT\_MIX           | OT\_MIX                       | OTB\_MOL          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  936 | OTB\_MOL\_100\_119\_0      | NA           | OT\_MIX           | OT\_MIX                       | OTB\_MOL          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  937 | OTB\_MOL\_16-31\_0\_0      | NA           | OT\_MIX           | OT\_MIX                       | OTB\_MOL          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  938 | OTB\_MOL\_16\_31\_0        | NA           | OT\_MIX           | OT\_MIX                       | OTB\_MOL          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  939 | OTB\_MOL\_32-69\_0\_0      | NA           | OT\_MIX           | OT\_MIX                       | OTB\_MOL          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  940 | OTB\_MOL\_32\_54\_0        | NA           | OT\_MIX           | OT\_MIX                       | OTB\_MOL          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  941 | OTB\_MOL\_32\_69\_0        | NA           | OT\_MIX           | OT\_MIX                       | OTB\_MOL          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  942 | OTB\_MOL\_55\_69\_0        | NA           | OT\_MIX           | OT\_MIX                       | OTB\_MOL          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  943 | OTB\_MOL\_70-99\_0\_0      | NA           | OT\_MIX           | OT\_MIX                       | OTB\_MOL          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  944 | OTB\_MOL\_70\_99\_0        | NA           | OT\_MIX           | OT\_MIX                       | OTB\_MOL          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  945 | OTB\_MOL\_\<16\_0\_0       | NA           | OT\_MIX           | OT\_MIX                       | OTB\_MOL          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  946 | OTB\_MOL\_\>=120\_0\_0     | NA           | OT\_MIX           | OT\_MIX                       | OTB\_MOL          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  947 | OTB\_MOL\_\>=70\_0         | NA           | OT\_MIX           | OT\_MIX                       | OTB\_MOL          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  948 | OTB\_MPD\_16-31\_0\_0      | NA           | OT\_MIX\_DMF\_PEL | OT\_MIX\_DMF\_PEL             | OTB\_MPD          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  949 | OTB\_MPD\_70-99\_0\_0      | NA           | OT\_MIX\_DMF\_PEL | OT\_MIX\_DMF\_PEL             | OTB\_MPD          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  950 | OTB\_NOC\_100-119\_0\_0    | NA           | OT\_MIX           | NA                            | OTB\_NOC          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  951 | OTB\_NOC\_32-69\_0\_0      | NA           | OT\_MIX           | NA                            | OTB\_NOC          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  952 | OTB\_NOC\_70-99\_0\_0      | NA           | OT\_MIX           | NA                            | OTB\_NOC          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  953 | OTB\_NOC\_\>=120\_0\_0     | NA           | OT\_MIX           | NA                            | OTB\_NOC          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  954 | OTB\_SPF\_0                | NA           | OT\_SPF           | NA                            | OTB\_SPF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  955 | OTB\_SPF\_0-0\_0\_0        | NA           | OT\_SPF           | OT\_SPF                       | OTB\_SPF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  956 | OTB\_SPF\_0\_0\_0          | NA           | OT\_SPF           | OT\_SPF                       | OTB\_SPF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  957 | OTB\_SPF\_0\_16\_0         | NA           | OT\_SPF           | OT\_SPF                       | OTB\_SPF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  958 | OTB\_SPF\_100-119\_0\_0    | NA           | OT\_SPF           | OT\_SPF                       | OTB\_SPF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  959 | OTB\_SPF\_100\_119\_0      | NA           | OT\_SPF           | OT\_SPF                       | OTB\_SPF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  960 | OTB\_SPF\_1249             | NA           | OT\_SPF           | OT\_SPF                       | OTB\_SPF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  961 | OTB\_SPF\_16-104\_0\_0     | NA           | OT\_SPF           | OT\_SPF                       | OTB\_SPF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  962 | OTB\_SPF\_16-31\_0\_0      | NA           | OT\_SPF           | OT\_SPF                       | OTB\_SPF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  963 | OTB\_SPF\_16\_31\_0        | NA           | OT\_SPF           | OT\_SPF                       | OTB\_SPF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  964 | OTB\_SPF\_16\_31\_0\_0     | NA           | OT\_SPF           | OT\_SPF                       | OTB\_SPF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  965 | OTB\_SPF\_1749             | NA           | OT\_SPF           | OT\_SPF                       | OTB\_SPF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  966 | OTB\_SPF\_2499             | NA           | OT\_SPF           | OT\_SPF                       | OTB\_SPF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  967 | OTB\_SPF\_32-104\_0\_0     | NA           | OT\_SPF           | OT\_SPF                       | OTB\_SPF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  968 | OTB\_SPF\_32-54\_0\_0      | NA           | OT\_SPF           | OT\_SPF                       | OTB\_SPF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  969 | OTB\_SPF\_32-69\_0\_0      | NA           | OT\_SPF           | OT\_SPF                       | OTB\_SPF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  970 | OTB\_SPF\_32-89\_0\_0      | NA           | OT\_SPF           | OT\_SPF                       | OTB\_SPF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  971 | OTB\_SPF\_32\_54\_0        | NA           | OT\_SPF           | OT\_SPF                       | OTB\_SPF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  972 | OTB\_SPF\_32\_69\_0        | NA           | OT\_SPF           | OT\_SPF                       | OTB\_SPF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  973 | OTB\_SPF\_3999             | NA           | OT\_SPF           | OT\_SPF                       | OTB\_SPF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  974 | OTB\_SPF\_5000             | NA           | OT\_SPF           | OT\_SPF                       | OTB\_SPF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  975 | OTB\_SPF\_55-69\_0\_0      | NA           | OT\_SPF           | OT\_SPF                       | OTB\_SPF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  976 | OTB\_SPF\_55\_69\_0        | NA           | OT\_SPF           | OT\_SPF                       | OTB\_SPF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  977 | OTB\_SPF\_624              | NA           | OT\_SPF           | OT\_SPF                       | OTB\_SPF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  978 | OTB\_SPF\_70-99\_0\_0      | NA           | OT\_SPF           | OT\_SPF                       | OTB\_SPF          | OTB            | Otter\_Trawl       | Otter             | Otter\_Trawl          |
|  979 | OTM\_DEF\_\>=105\_1\_120   | NA           | NA                | NA                            | OTM\_DEF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  980 | OTM\_DEF\_\>=120\_0        | NA           | NA                | NA                            | OTM\_DEF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  981 | OTM\_DEF\_\>=120\_0\_0     | NA           | NA                | NA                            | OTM\_DEF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  982 | OTM\_DEF\_\>=70\_0         | NA           | NA                | NA                            | OTM\_DEF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  983 | OTM\_DEF\_UNK              | NA           | NA                | NA                            | OTM\_DEF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  984 | OTM\_DWS\_0                | NA           | NA                | NA                            | OTM\_DWS          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  985 | OTM\_DWS\_2499             | NA           | NA                | NA                            | OTM\_DWS          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  986 | OTM\_DWS\_3999             | NA           | NA                | NA                            | OTM\_DWS          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  987 | OTM\_DWS\_5000             | NA           | NA                | NA                            | OTM\_DWS          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  988 | OTM\_FWS\_55-69\_0\_0      | NA           | NA                | NA                            | OTM\_FWS          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  989 | OTM\_FWS\_\>0\_0\_0        | NA           | NA                | NA                            | OTM\_FWS          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  990 | OTM\_FWS\_UNK              | NA           | NA                | NA                            | OTM\_FWS          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  991 | OTM\_LPF\_0\_0\_0          | NA           | NA                | NA                            | OTM\_LPF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  992 | OTM\_LPF\_100-119\_0\_0    | NA           | NA                | NA                            | OTM\_LPF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  993 | OTM\_LPF\_100\_119\_0      | NA           | NA                | NA                            | OTM\_LPF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  994 | OTM\_LPF\_16\_31\_0        | NA           | NA                | NA                            | OTM\_LPF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  995 | OTM\_LPF\_32-54\_0\_0      | NA           | NA                | NA                            | OTM\_LPF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  996 | OTM\_LPF\_32-69\_0\_0      | NA           | NA                | NA                            | OTM\_LPF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  997 | OTM\_LPF\_32\_54\_0        | NA           | NA                | NA                            | OTM\_LPF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  998 | OTM\_LPF\_70\_99\_0        | NA           | NA                | NA                            | OTM\_LPF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
|  999 | OTM\_LPF\_\>=120\_0        | NA           | NA                | NA                            | OTM\_LPF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
| 1000 | OTM\_LPF\_\>=120\_0\_0     | NA           | NA                | NA                            | OTM\_LPF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
| 1001 | OTM\_LPF\_\>=70\_0         | NA           | NA                | NA                            | OTM\_LPF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
| 1002 | OTM\_MOL\_16-31\_0\_0      | NA           | NA                | NA                            | OTM\_MOL          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
| 1003 | OTM\_NOC\_16-31\_0\_0      | NA           | NA                | NA                            | OTM\_NOC          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
| 1004 | OTM\_NOC\_32-69\_0\_0      | NA           | NA                | NA                            | OTM\_NOC          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
| 1005 | OTM\_SPF\_0                | NA           | NA                | NA                            | OTM\_NOC          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
| 1006 | OTM\_SPF\_0\_0\_0          | NA           | NA                | NA                            | OTM\_SPF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
| 1007 | OTM\_SPF\_0\_16\_0         | NA           | NA                | NA                            | OTM\_SPF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
| 1008 | OTM\_SPF\_100-119\_0\_0    | NA           | NA                | NA                            | OTM\_SPF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
| 1009 | OTM\_SPF\_100\_119\_0      | NA           | NA                | NA                            | OTM\_SPF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
| 1010 | OTM\_SPF\_1249             | NA           | NA                | NA                            | OTM\_SPF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
| 1011 | OTM\_SPF\_16-104\_0\_0     | NA           | NA                | NA                            | OTM\_SPF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
| 1012 | OTM\_SPF\_16-31\_0\_0      | NA           | NA                | NA                            | OTM\_SPF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
| 1013 | OTM\_SPF\_16\_31\_0        | NA           | NA                | NA                            | OTM\_SPF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
| 1014 | OTM\_SPF\_16\_31\_0\_0     | NA           | NA                | NA                            | OTM\_SPF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
| 1015 | OTM\_SPF\_1749             | NA           | NA                | NA                            | OTM\_SPF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
| 1016 | OTM\_SPF\_2499             | NA           | NA                | NA                            | OTM\_SPF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
| 1017 | OTM\_SPF\_32-104\_0\_0     | NA           | NA                | NA                            | OTM\_SPF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
| 1018 | OTM\_SPF\_32-54\_0\_0      | NA           | NA                | NA                            | OTM\_SPF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
| 1019 | OTM\_SPF\_32-69\_0\_0      | NA           | NA                | NA                            | OTM\_SPF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
| 1020 | OTM\_SPF\_32-89\_0\_0      | NA           | NA                | NA                            | OTM\_SPF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
| 1021 | OTM\_SPF\_32\_54\_0        | NA           | NA                | NA                            | OTM\_SPF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
| 1022 | OTM\_SPF\_32\_69\_0        | NA           | NA                | NA                            | OTM\_SPF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
| 1023 | OTM\_SPF\_349              | NA           | NA                | NA                            | OTM\_SPF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
| 1024 | OTM\_SPF\_3999             | NA           | NA                | NA                            | OTM\_SPF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
| 1025 | OTM\_SPF\_40\_64\_0        | NA           | NA                | NA                            | OTM\_SPF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
| 1026 | OTM\_SPF\_5000             | NA           | NA                | NA                            | OTM\_SPF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
| 1027 | OTM\_SPF\_55-69\_0\_0      | NA           | NA                | NA                            | OTM\_SPF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
| 1028 | OTM\_SPF\_70-99\_0\_0      | NA           | NA                | NA                            | OTM\_SPF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
| 1029 | OTM\_SPF\_70\_99\_0        | NA           | NA                | NA                            | OTM\_SPF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
| 1030 | OTM\_SPF\_874              | NA           | NA                | NA                            | OTM\_SPF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
| 1031 | OTM\_SPF\_\<16\_0\_0       | NA           | NA                | NA                            | OTM\_SPF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
| 1032 | OTM\_SPF\_\>=120\_0\_0     | NA           | NA                | NA                            | OTM\_SPF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
| 1033 | OTM\_SPF\_\>=40\_0\_0      | NA           | NA                | NA                            | OTM\_SPF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
| 1034 | OTM\_SPF\_\>=65\_0         | NA           | NA                | NA                            | OTM\_SPF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
| 1035 | OTM\_SPF\_\>=70\_0         | NA           | NA                | NA                            | OTM\_SPF          | OTM            | NA                 | Midwater          | Midwater\_Trawl       |
| 1036 | OTT\_CRU\_\>=70\_0         | NA           | OT\_CRU           | OT\_CRU                       | OTT\_CRU          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
| 1037 | OTT\_DEF\_0\_0\_0          | NA           | OT\_DMF           | OT\_DMF                       | OTT\_DEF          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
| 1038 | OTT\_DEF\_0\_16\_0         | NA           | OT\_DMF           | OT\_DMF                       | OTT\_DEF          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
| 1039 | OTT\_DEF\_100-119\_0\_0    | NA           | OT\_DMF           | OT\_DMF                       | OTT\_DEF          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
| 1040 | OTT\_DEF\_100\_119\_0      | NA           | OT\_DMF           | OT\_DMF                       | OTT\_DEF          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
| 1041 | OTT\_DEF\_16-31\_0\_0      | NA           | OT\_DMF           | OT\_DMF                       | OTT\_DEF          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
| 1042 | OTT\_DEF\_16\_31\_0        | NA           | OT\_DMF           | OT\_DMF                       | OTT\_DEF          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
| 1043 | OTT\_DEF\_32-69\_0\_0      | NA           | OT\_DMF           | OT\_DMF                       | OTT\_DEF          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
| 1044 | OTT\_DEF\_32\_54\_0        | NA           | OT\_DMF           | OT\_DMF                       | OTT\_DEF          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
| 1045 | OTT\_DEF\_32\_69\_0        | NA           | OT\_DMF           | OT\_DMF                       | OTT\_DEF          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
| 1046 | OTT\_DEF\_55\_69\_0        | NA           | OT\_DMF           | OT\_DMF                       | OTT\_DEF          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
| 1047 | OTT\_DEF\_70-99\_0\_0      | NA           | OT\_DMF           | OT\_DMF                       | OTT\_DEF          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
| 1048 | OTT\_DEF\_70\_99\_0        | NA           | OT\_DMF           | OT\_DMF                       | OTT\_DEF          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
| 1049 | OTT\_DEF\_90-119\_0\_0     | NA           | OT\_DMF           | OT\_DMF                       | OTT\_DEF          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
| 1050 | OTT\_DEF\_90-119\_1\_120   | NA           | OT\_DMF           | OT\_DMF                       | OTT\_DEF          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
| 1051 | OTT\_DEF\_90-119\_1\_140   | NA           | OT\_DMF           | OT\_DMF                       | OTT\_DEF          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
| 1052 | OTT\_DEF\_90-119\_1\_300   | NA           | OT\_DMF           | OT\_DMF                       | OTT\_DEF          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
| 1053 | OTT\_DEF\_\<16\_0\_0       | NA           | OT\_DMF           | OT\_DMF                       | OTT\_DEF          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
| 1054 | OTT\_DEF\_\>0\_0\_0        | NA           | OT\_DMF           | OT\_DMF                       | OTT\_DEF          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
| 1055 | OTT\_DEF\_\>=105\_0\_0     | NA           | OT\_DMF           | OT\_DMF                       | OTT\_DEF          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
| 1056 | OTT\_DEF\_\>=105\_1\_120   | NA           | OT\_DMF           | OT\_DMF                       | OTT\_DEF          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
| 1057 | OTT\_DEF\_\>=120\_0        | NA           | OT\_DMF           | OT\_DMF                       | OTT\_DEF          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
| 1058 | OTT\_DEF\_\>=120\_0\_0     | NA           | OT\_DMF           | OT\_DMF                       | OTT\_DEF          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
| 1059 | OTT\_DEF\_\>=120\_1\_120   | NA           | OT\_DMF           | OT\_DMF                       | OTT\_DEF          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
| 1060 | OTT\_DEF\_\>=65\_0         | NA           | OT\_DMF           | OT\_DMF                       | OTT\_DEF          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
| 1061 | OTT\_DEF\_\>=70\_0         | NA           | OT\_DMF           | OT\_DMF                       | OTT\_DEF          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
| 1062 | OTT\_DWS\_100\_119\_0      | NA           | OT\_MIX\_DMF\_BEN | NA                            | OTT\_DWS          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
| 1063 | OTT\_DWS\_70-99\_0\_0      | NA           | OT\_MIX\_DMF\_BEN | NA                            | OTT\_DWS          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
| 1064 | OTT\_DWS\_\>=120\_0\_0     | NA           | OT\_MIX\_DMF\_BEN | NA                            | OTT\_DWS          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
| 1065 | OTT\_DWS\_\>=70\_0         | NA           | OT\_MIX\_DMF\_BEN | NA                            | OTT\_DWS          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
| 1066 | OTT\_FIF\_90-119\_0\_0     | NA           | OT\_DMF           | NA                            | OTT\_FIF          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
| 1067 | OTT\_FIF\_90-119\_1\_120   | NA           | OT\_DMF           | NA                            | OTT\_FIF          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
| 1068 | OTT\_MCD\_100-119\_0\_0    | NA           | OT\_MIX\_CRU\_DMF | OT\_MIX\_CRU                  | OTT\_MCD          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
| 1069 | OTT\_MCD\_70-99\_0\_0      | NA           | OT\_MIX\_CRU\_DMF | OT\_MIX\_CRU                  | OTT\_MCD          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
| 1070 | OTT\_MCD\_90-119\_0\_0     | NA           | OT\_MIX\_CRU\_DMF | OT\_MIX\_CRU                  | OTT\_MCD          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
| 1071 | OTT\_MCD\_90-119\_1\_120   | NA           | OT\_MIX\_CRU\_DMF | OT\_MIX\_CRU                  | OTT\_MCD          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
| 1072 | OTT\_MCD\_90-119\_1\_140   | NA           | OT\_MIX\_CRU\_DMF | OT\_MIX\_CRU                  | OTT\_MCD          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
| 1073 | OTT\_MCD\_90-119\_1\_300   | NA           | OT\_MIX\_CRU\_DMF | OT\_MIX\_CRU                  | OTT\_MCD          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
| 1074 | OTT\_MCD\_90-119\_1\_\>14  | NA           | OT\_MIX\_CRU\_DMF | OT\_MIX\_CRU                  | OTT\_MCD          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
| 1075 | OTT\_MCD\_90-119\_1\_\>140 | NA           | OT\_MIX\_CRU\_DMF | NA                            | OTT\_MCD          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
| 1076 | OTT\_MCD\_\>=120\_0\_0     | NA           | OT\_MIX\_CRU\_DMF | OT\_MIX\_CRU                  | OTT\_MCD          | OTT            | Otter\_Trawl\_Twin | Otter             | Twin\_Otter\_Trawl    |
| 1077 | PS2\_SPF\_5000             | NA           | NA                | NA                            | PS2\_SPF          | PS2            | NA                 | Seine             | Purse\_seine          |
| 1078 | PS2\_SPF\_624              | NA           | NA                | NA                            | PS2\_SPF          | PS2            | NA                 | Seine             | Purse\_seine          |
| 1079 | PS2\_SPF\_874              | NA           | NA                | NA                            | PS2\_SPF          | PS2            | NA                 | Seine             | Purse\_seine          |
| 1080 | PS\_DEF\_0                 | NA           | NA                | NA                            | PS\_DEF           | PS             | NA                 | Seine             | Purse\_seine          |
| 1081 | PS\_DEF\_0\_0\_0           | NA           | NA                | NA                            | PS\_DEF           | PS             | NA                 | Seine             | Purse\_seine          |
| 1082 | PS\_DEF\_0\_16\_0          | NA           | NA                | NA                            | PS\_DEF           | PS             | NA                 | Seine             | Purse\_seine          |
| 1083 | PS\_DEF\_100\_119\_0       | NA           | NA                | NA                            | PS\_DEF           | PS             | NA                 | Seine             | Purse\_seine          |
| 1084 | PS\_DEF\_1249              | NA           | NA                | NA                            | PS\_DEF           | PS             | NA                 | Seine             | Purse\_seine          |
| 1085 | PS\_DEF\_16\_31\_0         | NA           | NA                | NA                            | PS\_DEF           | PS             | NA                 | Seine             | Purse\_seine          |
| 1086 | PS\_DEF\_1749              | NA           | NA                | NA                            | PS\_DEF           | PS             | NA                 | Seine             | Purse\_seine          |
| 1087 | PS\_DEF\_2499              | NA           | NA                | NA                            | PS\_DEF           | PS             | NA                 | Seine             | Purse\_seine          |
| 1088 | PS\_DEF\_32\_54\_0         | NA           | NA                | NA                            | PS\_DEF           | PS             | NA                 | Seine             | Purse\_seine          |
| 1089 | PS\_DEF\_32\_69\_0         | NA           | NA                | NA                            | PS\_DEF           | PS             | NA                 | Seine             | Purse\_seine          |
| 1090 | PS\_DEF\_349               | NA           | NA                | NA                            | PS\_DEF           | PS             | NA                 | Seine             | Purse\_seine          |
| 1091 | PS\_DEF\_55\_69\_0         | NA           | NA                | NA                            | PS\_DEF           | PS             | NA                 | Seine             | Purse\_seine          |
| 1092 | PS\_DEF\_624               | NA           | NA                | NA                            | PS\_DEF           | PS             | NA                 | Seine             | Purse\_seine          |
| 1093 | PS\_DEF\_70\_99\_0         | NA           | NA                | NA                            | PS\_DEF           | PS             | NA                 | Seine             | Purse\_seine          |
| 1094 | PS\_DEF\_874               | NA           | NA                | NA                            | PS\_DEF           | PS             | NA                 | Seine             | Purse\_seine          |
| 1095 | PS\_DEF\_\>=120\_0         | NA           | NA                | NA                            | PS\_DEF           | PS             | NA                 | Seine             | Purse\_seine          |
| 1096 | PS\_DEF\_\>=70\_0          | NA           | NA                | NA                            | PS\_DEF           | PS             | NA                 | Seine             | Purse\_seine          |
| 1097 | PS\_LPF\_0\_0\_0           | NA           | NA                | NA                            | PS\_LPF           | PS             | NA                 | Seine             | Purse\_seine          |
| 1098 | PS\_LPF\_0\_16\_0          | NA           | NA                | NA                            | PS\_LPF           | PS             | NA                 | Seine             | Purse\_seine          |
| 1099 | PS\_LPF\_16\_31\_0         | NA           | NA                | NA                            | PS\_LPF           | PS             | NA                 | Seine             | Purse\_seine          |
| 1100 | PS\_LPF\_\>=120\_0         | NA           | NA                | NA                            | PS\_LPF           | PS             | NA                 | Seine             | Purse\_seine          |
| 1101 | PS\_LPF\_\>=70\_0          | NA           | NA                | NA                            | PS\_LPF           | PS             | NA                 | Seine             | Purse\_seine          |
| 1102 | PS\_SPF\_0                 | NA           | NA                | NA                            | PS\_SPF           | PS             | NA                 | Seine             | Purse\_seine          |
| 1103 | PS\_SPF\_0\_0\_0           | NA           | NA                | NA                            | PS\_SPF           | PS             | NA                 | Seine             | Purse\_seine          |
| 1104 | PS\_SPF\_0\_16\_0          | NA           | NA                | NA                            | PS\_SPF           | PS             | NA                 | Seine             | Purse\_seine          |
| 1105 | PS\_SPF\_100-119\_0\_0     | NA           | NA                | NA                            | PS\_SPF           | PS             | NA                 | Seine             | Purse\_seine          |
| 1106 | PS\_SPF\_100\_119\_0       | NA           | NA                | NA                            | PS\_SPF           | PS             | NA                 | Seine             | Purse\_seine          |
| 1107 | PS\_SPF\_1249              | NA           | NA                | NA                            | PS\_SPF           | PS             | NA                 | Seine             | Purse\_seine          |
| 1108 | PS\_SPF\_16-104\_0\_0      | NA           | NA                | NA                            | PS\_SPF           | PS             | NA                 | Seine             | Purse\_seine          |
| 1109 | PS\_SPF\_16-31\_0\_0       | NA           | NA                | NA                            | PS\_SPF           | PS             | NA                 | Seine             | Purse\_seine          |
| 1110 | PS\_SPF\_16\_31\_0         | NA           | NA                | NA                            | PS\_SPF           | PS             | NA                 | Seine             | Purse\_seine          |
| 1111 | PS\_SPF\_1749              | NA           | NA                | NA                            | PS\_SPF           | PS             | NA                 | Seine             | Purse\_seine          |
| 1112 | PS\_SPF\_2499              | NA           | NA                | NA                            | PS\_SPF           | PS             | NA                 | Seine             | Purse\_seine          |
| 1113 | PS\_SPF\_32-104\_0\_0      | NA           | NA                | NA                            | PS\_SPF           | PS             | NA                 | Seine             | Purse\_seine          |
| 1114 | PS\_SPF\_32-69\_0\_0       | NA           | NA                | NA                            | PS\_SPF           | PS             | NA                 | Seine             | Purse\_seine          |
| 1115 | PS\_SPF\_32\_54\_0         | NA           | NA                | NA                            | PS\_SPF           | PS             | NA                 | Seine             | Purse\_seine          |
| 1116 | PS\_SPF\_32\_69\_0         | NA           | NA                | NA                            | PS\_SPF           | PS             | NA                 | Seine             | Purse\_seine          |
| 1117 | PS\_SPF\_349               | NA           | NA                | NA                            | PS\_SPF           | PS             | NA                 | Seine             | Purse\_seine          |
| 1118 | PS\_SPF\_3999              | NA           | NA                | NA                            | PS\_SPF           | PS             | NA                 | Seine             | Purse\_seine          |
| 1119 | PS\_SPF\_5000              | NA           | NA                | NA                            | PS\_SPF           | PS             | NA                 | Seine             | Purse\_seine          |
| 1120 | PS\_SPF\_55\_69\_0         | NA           | NA                | NA                            | PS\_SPF           | PS             | NA                 | Seine             | Purse\_seine          |
| 1121 | PS\_SPF\_624               | NA           | NA                | NA                            | PS\_SPF           | PS             | NA                 | Seine             | Purse\_seine          |
| 1122 | PS\_SPF\_70\_99\_0         | NA           | NA                | NA                            | PS\_SPF           | PS             | NA                 | Seine             | Purse\_seine          |
| 1123 | PS\_SPF\_874               | NA           | NA                | NA                            | PS\_SPF           | PS             | NA                 | Seine             | Purse\_seine          |
| 1126 | PS\_SPF\_\>0\_0\_0         | NA           | NA                | NA                            | PS\_SPF           | PS             | NA                 | Seine             | Purse\_seine          |
| 1127 | PS\_SPF\_\>=120\_0         | NA           | NA                | NA                            | PS\_SPF           | PS             | NA                 | Seine             | Purse\_seine          |
| 1128 | PS\_SPF\_\>=16\_0\_0       | NA           | NA                | NA                            | PS\_SPF           | PS             | NA                 | Seine             | Purse\_seine          |
| 1129 | PS\_SPF\_\>=70\_0          | NA           | NA                | NA                            | PS\_SPF           | PS             | NA                 | Seine             | Purse\_seine          |
| 1130 | PS\_SPF\_misc\_0\_0        | NA           | NA                | NA                            | PS\_SPF           | PS             | NA                 | Seine             | Purse\_seine          |
| 1131 | PTB\_CEP\_0\_0\_0          | NA           | OT\_MIX           | NA                            | PTB\_CEP          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
| 1132 | PTB\_CHECK\_70-99\_0\_0    | NA           | OT\_MIX           | NA                            | PTB\_CHE          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
| 1133 | PTB\_CHECK\_\>=120\_0\_0   | NA           | OT\_MIX           | NA                            | PTB\_CHE          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
| 1134 | PTB\_CRU\_0                | NA           | OT\_CRU           | NA                            | PTB\_CRU          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
| 1135 | PTB\_CRU\_100-119\_0\_0    | NA           | OT\_CRU           | NA                            | PTB\_CRU          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
| 1136 | PTB\_CRU\_70-99\_0\_0      | NA           | OT\_CRU           | OT\_CRU                       | PTB\_CRU          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
| 1137 | PTB\_CRU\_874              | NA           | OT\_CRU           | OT\_CRU                       | PTB\_CRU          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
| 1138 | PTB\_CRU\_\>=120\_0\_0     | NA           | OT\_CRU           | NA                            | PTB\_CRU          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
| 1139 | PTB\_DEF\_0                | NA           | OT\_DMF           | NA                            | PTB\_DEF          | PTB            | Pair\_Trawl\_Seine | Otter             | Pair\_Trawl           |
| 1140 | AG\_UND\_UND\_0\_0         | NA           | NA                | NA                            | AG\_UND           | AG             | NA                 | NA                | NA                    |
| 1141 | BTF\_DEF\_0\_0\_0          | NA           | NA                | NA                            | BTF\_DEF          | BTF            | NA                 | NA                | NA                    |
| 1142 | BTF\_DEF\_10-30\_0\_0      | NA           | NA                | NA                            | BTF\_DEF          | BTF            | NA                 | NA                | NA                    |
| 1143 | BTF\_DEF\_110-156\_0\_0    | NA           | NA                | NA                            | BTF\_DEF          | BTF            | NA                 | NA                | NA                    |
| 1144 | BTF\_DEF\_50-59\_0\_0      | NA           | NA                | NA                            | BTF\_DEF          | BTF            | NA                 | NA                | NA                    |
| 1145 | BTF\_DEF\_\>=220\_0\_0     | NA           | NA                | NA                            | BTF\_DEF          | BTF            | NA                 | NA                | NA                    |
| 1146 | DIV\_CEP\_0\_0\_0          | NA           | NA                | NA                            | DIV\_CEP          | DIV            | NA                 | NA                | NA                    |
| 1147 | DIV\_DEF\_0\_0\_0          | NA           | NA                | NA                            | DIV\_DEF          | DIV            | NA                 | NA                | NA                    |
| 1148 | DIV\_DES\_0\_0\_0          | NA           | NA                | NA                            | DIV\_DES          | DIV            | NA                 | NA                | NA                    |
| 1149 | DIV\_MOL\_0\_0\_0          | NA           | NA                | NA                            | DIV\_MOL          | DIV            | NA                 | NA                | NA                    |
| 1150 | DRB\_CRU\_0-0\_0\_0        | NA           | DRB\_MOL          | NA                            | DRB\_CRU          | DRB            | Boat\_dredge       | Dredge            | Dredge                |
| 1151 | DRB\_CRU\_0\_0\_0          | NA           | DRB\_MOL          | NA                            | DRB\_CRU          | DRB            | Boat\_dredge       | Dredge            | Dredge                |
| 1152 | DRB\_DEF\_0-0\_0\_0        | NA           | DRB\_MOL          | NA                            | DRB\_DEF          | DRB            | Boat\_dredge       | Dredge            | Dredge                |
| 1153 | DRB\_DES\_0\_0\_0          | NA           | DRB\_MOL          | NA                            | DRB\_DES          | DRB            | Boat\_dredge       | Dredge            | Dredge                |
| 1154 | DRB\_DWS\_0-0\_0\_0        | NA           | DRB\_MOL          | NA                            | DRB\_DWS          | DRB            | Boat\_dredge       | Dredge            | Dredge                |
| 1155 | DRB\_MOL\_0                | NA           | DRB\_MOL          | DRB\_MOL                      | DRB\_MOL          | DRB            | Boat\_dredge       | Dredge            | Dredge                |
| 1156 | DRB\_MOL\_0-0\_0\_0        | NA           | DRB\_MOL          | DRB\_MOL                      | DRB\_MOL          | DRB            | Boat\_dredge       | Dredge            | Dredge                |
| 1157 | DRB\_MOL\_0\_0\_0          | NA           | DRB\_MOL          | DRB\_MOL                      | DRB\_MOL          | DRB            | Boat\_dredge       | Dredge            | Dredge                |
| 1158 | DRB\_MOL\_30\_0\_0         | NA           | DRB\_MOL          | NA                            | DRB\_MOL          | DRB            | Boat\_dredge       | Dredge            | Dredge                |
| 1159 | DRB\_MOL\_\>0\_0\_0        | NA           | DRB\_MOL          | DRB\_MOL                      | DRB\_MOL          | DRB            | Boat\_dredge       | Dredge            | Dredge                |
| 1160 | DRB\_NOC\_0\_0\_0          | NA           | DRB\_MOL          | NA                            | DRB\_NOC          | DRB            | Boat\_dredge       | Dredge            | Dredge                |
| 1161 | DRB\_SWD\_0\_0\_0          | NA           | DRB\_MOL          | NA                            | DRB\_SWD          | DRB            | Boat\_dredge       | Dredge            | Dredge                |
| 1162 | FAR\_SPF\_624              | NA           | NA                | NA                            | FAR\_SPF          | FAR            | NA                 | Other             | Aerial\_net           |
| 1163 | FG\_DEF\_624               | NA           | NA                | NA                            | FG\_DEF           | FG             | NA                 | Static            | Falling\_gear         |
| 1164 | FNC\_DEF\_624              | NA           | NA                | NA                            | FNC\_DEF          | FNC            | NA                 | Static            | Falling\_gear         |
| 1165 | FOO\_CEP\_0\_0\_0          | NA           | NA                | NA                            | FOO\_CEP          | FOO            | NA                 | NA                | NA                    |
| 1166 | FOO\_CRU\_0\_0\_0          | NA           | NA                | NA                            | FOO\_CRU          | FOO            | NA                 | NA                | NA                    |
| 1167 | FOO\_DES\_0\_0\_0          | NA           | NA                | NA                            | FOO\_DES          | FOO            | NA                 | NA                | NA                    |
| 1168 | FOO\_MOL\_0\_0\_0          | NA           | NA                | NA                            | FOO\_MOL          | FOO            | NA                 | NA                | NA                    |
| 1169 | FPN\_ANA\_\>0\_0\_0        | NA           | NA                | NA                            | FPN\_ANA          | FPN            | NA                 | Static            | poundnet              |
| 1170 | FPN\_CAT\_0\_0\_0          | NA           | NA                | NA                            | FPN\_CAT          | FPN            | NA                 | Static            | poundnet              |
| 1171 | FPN\_CAT\_\>0\_0\_0        | NA           | NA                | NA                            | FPN\_CAT          | FPN            | NA                 | Static            | poundnet              |
| 1172 | FPN\_DEF\_\>0\_0\_0        | NA           | NA                | NA                            | FPN\_DEF          | FPN            | NA                 | Static            | poundnet              |
| 1173 | FPN\_FWS\_\>0\_0\_0        | NA           | NA                | NA                            | FPN\_FWS          | FPN            | NA                 | Static            | poundnet              |
| 1174 | FPN\_SPF\_\>0\_0\_0        | NA           | NA                | NA                            | FPN\_SPF          | FPN            | NA                 | Static            | poundnet              |
| 1175 | FPO\_ANA\_0\_0\_0          | NA           | NA                | NA                            | FPO\_ANA          | FPO            | NA                 | Static            | Pot                   |
| 1176 | FPO\_ANA\_\>0\_0\_0        | NA           | NA                | NA                            | FPO\_ANA          | FPO            | NA                 | Static            | Pot                   |
| 1177 | FPO\_CAT\_0\_0\_0          | NA           | NA                | NA                            | FPO\_CAT          | FPO            | NA                 | Static            | Pot                   |
| 1178 | FPO\_CAT\_10-30\_0\_0      | NA           | NA                | NA                            | FPO\_CAT          | FPO            | NA                 | Static            | Pot                   |
| 1179 | FPO\_CAT\_31-49\_0\_0      | NA           | NA                | NA                            | FPO\_CAT          | FPO            | NA                 | Static            | Pot                   |
| 1180 | FPO\_CAT\_\>0\_0\_0        | NA           | NA                | NA                            | FPO\_CAT          | FPO            | NA                 | Static            | Pot                   |
| 1181 | FPO\_CEP\_0\_0\_0          | NA           | NA                | NA                            | FPO\_CEP          | FPO            | NA                 | Static            | Pot                   |
| 1182 | FPO\_CRU\_0                | NA           | NA                | NA                            | FPO\_CRU          | FPO            | NA                 | Static            | Pot                   |
| 1183 | FPO\_CRU\_0-0\_0\_0        | NA           | NA                | NA                            | FPO\_CRU          | FPO            | NA                 | Static            | Pot                   |
| 1184 | FPO\_CRU\_0\_0\_0          | NA           | NA                | NA                            | FPO\_CRU          | FPO            | NA                 | Static            | Pot                   |
| 1185 | FPO\_CRU\_10-30\_0\_0      | NA           | NA                | NA                            | FPO\_CRU          | FPO            | NA                 | Static            | Pot                   |
| 1186 | FPO\_CRU\_1249             | NA           | NA                | NA                            | FPO\_CRU          | FPO            | NA                 | Static            | Pot                   |
| 1187 | FPO\_CRU\_1749             | NA           | NA                | NA                            | FPO\_CRU          | FPO            | NA                 | Static            | Pot                   |
| 1188 | FPO\_CRU\_349              | NA           | NA                | NA                            | FPO\_CRU          | FPO            | NA                 | Static            | Pot                   |
| 1189 | FPO\_CRU\_3999             | NA           | NA                | NA                            | FPO\_CRU          | FPO            | NA                 | Static            | Pot                   |
| 1190 | FPO\_CRU\_50-70\_0\_0      | NA           | NA                | NA                            | FPO\_CRU          | FPO            | NA                 | Static            | Pot                   |
| 1191 | FPO\_CRU\_5000             | NA           | NA                | NA                            | FPO\_CRU          | FPO            | NA                 | Static            | Pot                   |
| 1192 | FPO\_CRU\_624              | NA           | NA                | NA                            | FPO\_CRU          | FPO            | NA                 | Static            | Pot                   |
| 1193 | FPO\_CRU\_\>0\_0\_0        | NA           | NA                | NA                            | FPO\_CRU          | FPO            | NA                 | Static            | Pot                   |
| 1194 | FPO\_CRU\_ALL\_0\_0        | NA           | NA                | NA                            | FPO\_CRU          | FPO            | NA                 | Static            | Pot                   |
| 1195 | FPO\_CRU\_UND\_0\_0        | NA           | NA                | NA                            | FPO\_CRU          | FPO            | NA                 | Static            | Pot                   |
| 1196 | FPO\_DEF\_0                | NA           | NA                | NA                            | FPO\_DEF          | FPO            | NA                 | Static            | Pot                   |
| 1197 | FPO\_DEF\_0-0\_0\_0        | NA           | NA                | NA                            | FPO\_DEF          | FPO            | NA                 | Static            | Pot                   |
| 1198 | FPO\_DEF\_0\_0\_0          | NA           | NA                | NA                            | FPO\_DEF          | FPO            | NA                 | Static            | Pot                   |
| 1199 | FPO\_DEF\_110-156\_0\_0    | NA           | NA                | NA                            | FPO\_DEF          | FPO            | NA                 | Static            | Pot                   |
| 1200 | FPO\_DEF\_349              | NA           | NA                | NA                            | FPO\_DEF          | FPO            | NA                 | Static            | Pot                   |
| 1201 | FPO\_DEF\_624              | NA           | NA                | NA                            | FPO\_DEF          | FPO            | NA                 | Static            | Pot                   |
| 1202 | FPO\_DEF\_\>0\_0\_0        | NA           | NA                | NA                            | FPO\_DEF          | FPO            | NA                 | Static            | Pot                   |
| 1203 | FPO\_FIF\_0\_0\_0          | NA           | NA                | NA                            | FPO\_FIF          | FPO            | NA                 | Static            | Pot                   |
| 1204 | FPO\_FIF\_\>0\_0\_0        | NA           | NA                | NA                            | FPO\_FIF          | FPO            | NA                 | Static            | Pot                   |
| 1205 | FPO\_FIN\_0\_0\_0          | NA           | NA                | NA                            | FPO\_FIN          | FPO            | NA                 | Static            | Pot                   |
| 1206 | FPO\_FWS\_0\_0\_0          | NA           | NA                | NA                            | FPO\_FWS          | FPO            | NA                 | Static            | Pot                   |
| 1207 | FPO\_FWS\_10-30\_0\_0      | NA           | NA                | NA                            | FPO\_FWS          | FPO            | NA                 | Static            | Pot                   |
| 1208 | PTM\_CEP\_16\_31\_0        | NA           | NA                | NA                            | PTM\_CEP          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1209 | PTM\_CEP\_32\_54\_0        | NA           | NA                | NA                            | PTM\_CEP          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1210 | PTM\_CEP\_32\_69\_0        | NA           | NA                | NA                            | PTM\_CEP          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1211 | PTM\_CEP\_70\_99\_0        | NA           | NA                | NA                            | PTM\_CEP          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1212 | PTM\_CEP\_\>=70\_0         | NA           | NA                | NA                            | PTM\_CEP          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1213 | PTM\_CRU\_0                | NA           | NA                | NA                            | PTM\_CRU          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1214 | PTM\_CRU\_100-119\_0\_0    | NA           | NA                | NA                            | PTM\_CRU          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1215 | PTM\_CRU\_32-69\_0\_0      | NA           | NA                | NA                            | PTM\_CRU          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1216 | PTM\_CRU\_70-99\_0\_0      | NA           | NA                | NA                            | PTM\_CRU          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1217 | PTM\_DEF\_0                | NA           | NA                | NA                            | PTM\_DEF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1218 | PTM\_DEF\_0\_0\_0          | NA           | NA                | NA                            | PTM\_DEF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1219 | PTM\_DEF\_0\_16\_0         | NA           | NA                | NA                            | PTM\_DEF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1220 | PTM\_DEF\_100-119\_0\_0    | NA           | NA                | NA                            | PTM\_DEF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1221 | PTM\_DEF\_100\_119\_0      | NA           | NA                | NA                            | PTM\_DEF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1222 | PTM\_DEF\_1249             | NA           | NA                | NA                            | PTM\_DEF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1223 | PTM\_DEF\_16-31\_0\_0      | NA           | NA                | NA                            | PTM\_DEF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1224 | PTM\_DEF\_16\_31\_0        | NA           | NA                | NA                            | PTM\_DEF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1225 | PTM\_DEF\_1749             | NA           | NA                | NA                            | PTM\_DEF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1226 | PTM\_DEF\_2499             | NA           | NA                | NA                            | PTM\_DEF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1227 | PTM\_DEF\_32-69\_0\_0      | NA           | NA                | NA                            | PTM\_DEF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1228 | PTM\_DEF\_32\_54\_0        | NA           | NA                | NA                            | PTM\_DEF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1229 | PTM\_DEF\_32\_69\_0        | NA           | NA                | NA                            | PTM\_DEF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1230 | PTM\_DEF\_3999             | NA           | NA                | NA                            | PTM\_DEF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1231 | PTM\_DEF\_5000             | NA           | NA                | NA                            | PTM\_DEF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1232 | PTM\_DEF\_55\_69\_0        | NA           | NA                | NA                            | PTM\_DEF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1233 | PTM\_DEF\_70-99\_0\_0      | NA           | NA                | NA                            | PTM\_DEF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1234 | PTM\_DEF\_70\_99\_0        | NA           | NA                | NA                            | PTM\_DEF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1235 | PTM\_DEF\_874              | NA           | NA                | NA                            | PTM\_DEF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1236 | PTM\_DEF\_90-104\_0\_0     | NA           | NA                | NA                            | PTM\_DEF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1237 | PTM\_DEF\_\<16\_0\_0       | NA           | NA                | NA                            | PTM\_DEF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1238 | PTM\_DEF\_\>=105\_1\_110   | NA           | NA                | NA                            | PTM\_DEF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1239 | PTM\_DEF\_\>=105\_1\_120   | NA           | NA                | NA                            | PTM\_DEF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1240 | PTM\_DEF\_\>=120\_0        | NA           | NA                | NA                            | PTM\_DEF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1241 | PTM\_DEF\_\>=120\_0\_0     | NA           | NA                | NA                            | PTM\_DEF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1242 | PTM\_DEF\_\>=65\_0         | NA           | NA                | NA                            | PTM\_DEF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1243 | PTM\_DEF\_\>=70\_0         | NA           | NA                | NA                            | PTM\_DEF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1244 | PTM\_DWS\_0                | NA           | NA                | NA                            | PTM\_DWS          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1245 | PTM\_DWS\_1249             | NA           | NA                | NA                            | PTM\_DWS          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1246 | PTM\_DWS\_1749             | NA           | NA                | NA                            | PTM\_DWS          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1247 | PTM\_DWS\_2499             | NA           | NA                | NA                            | PTM\_DWS          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1248 | PTM\_DWS\_3999             | NA           | NA                | NA                            | PTM\_DWS          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1249 | PTM\_DWS\_5000             | NA           | NA                | NA                            | PTM\_DWS          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1250 | PTM\_FWS\_\>0\_0\_0        | NA           | NA                | NA                            | PTM\_FWS          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1251 | PTM\_LPF\_0\_0\_0          | NA           | NA                | NA                            | PTM\_LPF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1252 | PTM\_LPF\_100-119\_0\_0    | NA           | NA                | NA                            | PTM\_LPF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1253 | PTM\_LPF\_100\_119\_0      | NA           | NA                | NA                            | PTM\_LPF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1254 | PTM\_LPF\_16-31\_0\_0      | NA           | NA                | NA                            | PTM\_LPF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1255 | PTM\_LPF\_16\_31\_0        | NA           | NA                | NA                            | PTM\_LPF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1256 | PTM\_LPF\_32-54\_0\_0      | NA           | NA                | NA                            | PTM\_LPF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1257 | PTM\_LPF\_32-69\_0\_0      | NA           | NA                | NA                            | PTM\_LPF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1258 | PTM\_LPF\_32\_54\_0        | NA           | NA                | NA                            | PTM\_LPF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1259 | PTM\_LPF\_70-99\_0\_0      | NA           | NA                | NA                            | PTM\_LPF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1260 | PTM\_LPF\_70\_99\_0        | NA           | NA                | NA                            | PTM\_LPF          | PTM            | NA                 | Midwater          | Midwater\_Pair\_Trawl |
| 1261 | GND\_LPF\_100\_119\_0      | NA           | NA                | NA                            | GND\_LPF          | GND            | NA                 | Static            | Drift\_gillnets       |
| 1262 | GND\_LPF\_50\_59\_0        | NA           | NA                | NA                            | GND\_LPF          | GND            | NA                 | Static            | Drift\_gillnets       |
| 1263 | GND\_LPF\_60\_79\_0        | NA           | NA                | NA                            | GND\_LPF          | GND            | NA                 | Static            | Drift\_gillnets       |
| 1264 | GND\_LPF\_80\_99\_0        | NA           | NA                | NA                            | GND\_LPF          | GND            | NA                 | Static            | Drift\_gillnets       |
| 1265 | GND\_LPF\_\>=100\_0        | NA           | NA                | NA                            | GND\_LPF          | GND            | NA                 | Static            | Drift\_gillnets       |
| 1266 | GND\_SPF\_0\_0\_0          | NA           | NA                | NA                            | GND\_SPF          | GND            | NA                 | Static            | Drift\_gillnets       |
| 1267 | GND\_SPF\_0\_40\_0         | NA           | NA                | NA                            | GND\_SPF          | GND            | NA                 | Static            | Drift\_gillnets       |
| 1268 | GND\_SPF\_10\_30\_0        | NA           | NA                | NA                            | GND\_SPF          | GND            | NA                 | Static            | Drift\_gillnets       |
| 1269 | GND\_SPF\_120\_219\_0      | NA           | NA                | NA                            | GND\_SPF          | GND            | NA                 | Static            | Drift\_gillnets       |
| 1270 | GND\_SPF\_50\_59\_0        | NA           | NA                | NA                            | GND\_SPF          | GND            | NA                 | Static            | Drift\_gillnets       |
| 1271 | GND\_SPF\_50\_70\_0        | NA           | NA                | NA                            | GND\_SPF          | GND            | NA                 | Static            | Drift\_gillnets       |
| 1272 | GND\_SPF\_60\_79\_0        | NA           | NA                | NA                            | GND\_SPF          | GND            | NA                 | Static            | Drift\_gillnets       |
| 1273 | GND\_SPF\_80\_99\_0        | NA           | NA                | NA                            | GND\_SPF          | GND            | NA                 | Static            | Drift\_gillnets       |
| 1274 | GND\_SPF\_90\_99\_0        | NA           | NA                | NA                            | GND\_SPF          | GND            | NA                 | Static            | Drift\_gillnets       |
| 1275 | GND\_SPF\_\>=100\_0        | NA           | NA                | NA                            | GND\_SPF          | GND            | NA                 | Static            | Drift\_gillnets       |
| 1276 | GNF\_DEF\_0                | NA           | NA                | NA                            | GNF\_DEF          | GNF            | NA                 | Static            | Gillnet               |
| 1277 | GNF\_DEF\_624              | NA           | NA                | NA                            | GNF\_DEF          | GNF            | NA                 | Static            | Gillnet               |
| 1278 | GNS\_ANA\_0\_0\_0          | NA           | NA                | NA                            | GNS\_ANA          | GNS            | NA                 | Static            | Gillnet               |
| 1279 | GNS\_ANA\_100-109\_0\_0    | NA           | NA                | NA                            | GNS\_ANA          | GNS            | NA                 | Static            | Gillnet               |
| 1280 | GNS\_ANA\_110-156\_0\_0    | NA           | NA                | NA                            | GNS\_ANA          | GNS            | NA                 | Static            | Gillnet               |
| 1281 | GNS\_ANA\_157-219\_0\_0    | NA           | NA                | NA                            | GNS\_ANA          | GNS            | NA                 | Static            | Gillnet               |
| 1282 | GNS\_ANA\_31-49\_0\_0      | NA           | NA                | NA                            | GNS\_ANA          | GNS            | NA                 | Static            | Gillnet               |
| 1283 | GNS\_ANA\_60-69\_0\_0      | NA           | NA                | NA                            | GNS\_ANA          | GNS            | NA                 | Static            | Gillnet               |
| 1284 | GNS\_ANA\_70-79\_0\_0      | NA           | NA                | NA                            | GNS\_ANA          | GNS            | NA                 | Static            | Gillnet               |
| 1285 | GNS\_ANA\_80-89\_0\_0      | NA           | NA                | NA                            | GNS\_ANA          | GNS            | NA                 | Static            | Gillnet               |
| 1286 | GNS\_ANA\_90-99\_0\_0      | NA           | NA                | NA                            | GNS\_ANA          | GNS            | NA                 | Static            | Gillnet               |
| 1287 | GNS\_ANA\_\>=157\_0\_0     | NA           | NA                | NA                            | GNS\_ANA          | GNS            | NA                 | Static            | Gillnet               |
| 1288 | GNS\_ANA\_\>=220\_0\_0     | NA           | NA                | NA                            | GNS\_ANA          | GNS            | NA                 | Static            | Gillnet               |
| 1289 | GNS\_CAT\_0\_0\_0          | NA           | NA                | NA                            | GNS\_CAT          | GNS            | NA                 | Static            | Gillnet               |
| 1290 | GNS\_CAT\_0\_40\_0         | NA           | NA                | NA                            | GNS\_CAT          | GNS            | NA                 | Static            | Gillnet               |
| 1291 | GNS\_CAT\_100\_119\_0      | NA           | NA                | NA                            | GNS\_CAT          | GNS            | NA                 | Static            | Gillnet               |
| 1292 | GNS\_CAT\_157-219\_0\_0    | NA           | NA                | NA                            | GNS\_CAT          | GNS            | NA                 | Static            | Gillnet               |
| 1293 | GNS\_CAT\_50\_59\_0        | NA           | NA                | NA                            | GNS\_CAT          | GNS            | NA                 | Static            | Gillnet               |
| 1294 | GNS\_CAT\_50\_70\_0        | NA           | NA                | NA                            | GNS\_CAT          | GNS            | NA                 | Static            | Gillnet               |
| 1295 | GNS\_CAT\_60\_79\_0        | NA           | NA                | NA                            | GNS\_CAT          | GNS            | NA                 | Static            | Gillnet               |
| 1296 | GNS\_CAT\_80\_99\_0        | NA           | NA                | NA                            | GNS\_CAT          | GNS            | NA                 | Static            | Gillnet               |
| 1297 | GNS\_CAT\_\>0\_0\_0        | NA           | NA                | NA                            | GNS\_CAT          | GNS            | NA                 | Static            | Gillnet               |
| 1298 | GNS\_CAT\_\>=100\_0        | NA           | NA                | NA                            | GNS\_CAT          | GNS            | NA                 | Static            | Gillnet               |
| 1299 | GNS\_CEP\_0\_0\_0          | NA           | NA                | NA                            | GNS\_CEP          | GNS            | NA                 | Static            | Gillnet               |
| 1300 | GNS\_CRU\_0                | NA           | NA                | NA                            | GNS\_CRU          | GNS            | NA                 | Static            | Gillnet               |
| 1301 | GNS\_CRU\_0-0\_0\_0        | NA           | NA                | NA                            | GNS\_CRU          | GNS            | NA                 | Static            | Gillnet               |
| 1302 | GNS\_CRU\_0\_0\_0          | NA           | NA                | NA                            | GNS\_CRU          | GNS            | NA                 | Static            | Gillnet               |
| 1303 | GNS\_CRU\_0\_40\_0         | NA           | NA                | NA                            | GNS\_CRU          | GNS            | NA                 | Static            | Gillnet               |
| 1304 | GNS\_CRU\_10-30\_0\_0      | NA           | NA                | NA                            | GNS\_CRU          | GNS            | NA                 | Static            | Gillnet               |
| 1305 | GNS\_CRU\_100-119\_0\_0    | NA           | NA                | NA                            | GNS\_CRU          | GNS            | NA                 | Static            | Gillnet               |
| 1306 | GNS\_CRU\_100\_119\_0      | NA           | NA                | NA                            | GNS\_CRU          | GNS            | NA                 | Static            | Gillnet               |
| 1307 | GNS\_CRU\_10\_30\_0        | NA           | NA                | NA                            | GNS\_CRU          | GNS            | NA                 | Static            | Gillnet               |
| 1308 | GNS\_CRU\_120-219\_0\_0    | NA           | NA                | NA                            | GNS\_CRU          | GNS            | NA                 | Static            | Gillnet               |
| 1309 | GNS\_CRU\_120\_219\_0      | NA           | NA                | NA                            | GNS\_CRU          | GNS            | NA                 | Static            | Gillnet               |
| 1310 | GNS\_CRU\_40\_49\_0        | NA           | NA                | NA                            | GNS\_CRU          | GNS            | NA                 | Static            | Gillnet               |
| 1311 | GNS\_CRU\_50-70\_0\_0      | NA           | NA                | NA                            | GNS\_CRU          | GNS            | NA                 | Static            | Gillnet               |
| 1312 | GNS\_CRU\_50\_59\_0        | NA           | NA                | NA                            | GNS\_CRU          | GNS            | NA                 | Static            | Gillnet               |
| 1313 | GNS\_CRU\_50\_70\_0        | NA           | NA                | NA                            | GNS\_CRU          | GNS            | NA                 | Static            | Gillnet               |
| 1314 | GNS\_CRU\_60\_79\_0        | NA           | NA                | NA                            | GNS\_CRU          | GNS            | NA                 | Static            | Gillnet               |
| 1315 | GNS\_CRU\_624              | NA           | NA                | NA                            | GNS\_CRU          | GNS            | NA                 | Static            | Gillnet               |
| 1316 | GNS\_CRU\_80\_99\_0        | NA           | NA                | NA                            | GNS\_CRU          | GNS            | NA                 | Static            | Gillnet               |
| 1317 | GNS\_CRU\_90-99\_0\_0      | NA           | NA                | NA                            | GNS\_CRU          | GNS            | NA                 | Static            | Gillnet               |
| 1318 | GNS\_CRU\_90\_99\_0        | NA           | NA                | NA                            | GNS\_CRU          | GNS            | NA                 | Static            | Gillnet               |
| 1319 | GNS\_CRU\_\>0\_0\_0        | NA           | NA                | NA                            | GNS\_CRU          | GNS            | NA                 | Static            | Gillnet               |
| 1320 | GNS\_CRU\_\>=100\_0        | NA           | NA                | NA                            | GNS\_CRU          | GNS            | NA                 | Static            | Gillnet               |
| 1321 | GNS\_CRU\_\>=220\_0        | NA           | NA                | NA                            | GNS\_CRU          | GNS            | NA                 | Static            | Gillnet               |
| 1322 | GNS\_CRU\_\>=220\_0\_0     | NA           | NA                | NA                            | GNS\_CRU          | GNS            | NA                 | Static            | Gillnet               |
| 1323 | GNS\_DEF\_0                | NA           | NA                | NA                            | GNS\_DEF          | GNS            | NA                 | Static            | Gillnet               |
| 1324 | GNS\_FWS\_70-79\_0\_0      | NA           | NA                | NA                            | GNS\_FWS          | GNS            | NA                 | Static            | Gillnet               |
| 1325 | GNS\_FWS\_80-89\_0\_0      | NA           | NA                | NA                            | GNS\_FWS          | GNS            | NA                 | Static            | Gillnet               |
| 1326 | GNS\_FWS\_90-99\_0\_0      | NA           | NA                | NA                            | GNS\_FWS          | GNS            | NA                 | Static            | Gillnet               |
| 1327 | GNS\_FWS\_\>0\_0\_0        | NA           | NA                | NA                            | GNS\_FWS          | GNS            | NA                 | Static            | Gillnet               |
| 1328 | GNS\_FWS\_\>=220\_0\_0     | NA           | NA                | NA                            | GNS\_FWS          | GNS            | NA                 | Static            | Gillnet               |
| 1329 | GNS\_FWS\_NA\_0\_0         | NA           | NA                | NA                            | GNS\_FWS          | GNS            | NA                 | Static            | Gillnet               |
| 1330 | GNS\_LPF\_0\_0\_0          | NA           | NA                | NA                            | GNS\_LPF          | GNS            | NA                 | Static            | Gillnet               |
| 1331 | GNS\_LPF\_0\_40\_0         | NA           | NA                | NA                            | GNS\_LPF          | GNS            | NA                 | Static            | Gillnet               |
| 1332 | GNS\_LPF\_100\_119\_0      | NA           | NA                | NA                            | GNS\_LPF          | GNS            | NA                 | Static            | Gillnet               |
| 1333 | GNS\_LPF\_120-219\_0\_0    | NA           | NA                | NA                            | GNS\_LPF          | GNS            | NA                 | Static            | Gillnet               |
| 1334 | GNS\_LPF\_120\_219\_0      | NA           | NA                | NA                            | GNS\_LPF          | GNS            | NA                 | Static            | Gillnet               |
| 1335 | GNS\_LPF\_40\_49\_0        | NA           | NA                | NA                            | GNS\_LPF          | GNS            | NA                 | Static            | Gillnet               |
| 1336 | GNS\_LPF\_50\_59\_0        | NA           | NA                | NA                            | GNS\_LPF          | GNS            | NA                 | Static            | Gillnet               |
| 1337 | GNS\_LPF\_50\_70\_0        | NA           | NA                | NA                            | GNS\_LPF          | GNS            | NA                 | Static            | Gillnet               |
| 1338 | GNS\_LPF\_60\_79\_0        | NA           | NA                | NA                            | GNS\_LPF          | GNS            | NA                 | Static            | Gillnet               |
| 1339 | GNS\_LPF\_80\_99\_0        | NA           | NA                | NA                            | GNS\_LPF          | GNS            | NA                 | Static            | Gillnet               |
| 1340 | GNS\_LPF\_\>=100\_0        | NA           | NA                | NA                            | GNS\_LPF          | GNS            | NA                 | Static            | Gillnet               |
| 1341 | GNS\_MCD\_100-119\_0\_0    | NA           | NA                | NA                            | GNS\_MCD          | GNS            | NA                 | Static            | Gillnet               |
| 1342 | GNS\_MCD\_120-219\_0\_0    | NA           | NA                | NA                            | GNS\_MCD          | GNS            | NA                 | Static            | Gillnet               |
| 1343 | GNS\_MOL\_10-30\_0\_0      | NA           | NA                | NA                            | GNS\_MOL          | GNS            | NA                 | Static            | Gillnet               |
| 1344 | GNS\_MOL\_50-70\_0\_0      | NA           | NA                | NA                            | GNS\_MOL          | GNS            | NA                 | Static            | Gillnet               |
| 1345 | GNS\_MOL\_\>0\_0\_0        | NA           | NA                | NA                            | GNS\_MOL          | GNS            | NA                 | Static            | Gillnet               |
| 1346 | GNS\_MOL\_\>=220\_0\_0     | NA           | NA                | NA                            | GNS\_MOL          | GNS            | NA                 | Static            | Gillnet               |
| 1347 | GNS\_MPD\_120-219\_0\_0    | NA           | NA                | NA                            | GNS\_MPD          | GNS            | NA                 | Static            | Gillnet               |
| 1348 | GNS\_MPD\_\>=220\_0\_0     | NA           | NA                | NA                            | GNS\_MPD          | GNS            | NA                 | Static            | Gillnet               |
| 1349 | GNS\_NOC\_120-219\_0\_0    | NA           | NA                | NA                            | GNS\_NOC          | GNS            | NA                 | Static            | Gillnet               |
| 1350 | GNS\_NOC\_\>=220\_0\_0     | NA           | NA                | NA                            | GNS\_NOC          | GNS            | NA                 | Static            | Gillnet               |
| 1351 | GNS\_SPF\_0                | NA           | NA                | NA                            | GNS\_SPF          | GNS            | NA                 | Static            | Gillnet               |
| 1352 | GNS\_SPF\_0-0\_0\_0        | NA           | NA                | NA                            | GNS\_SPF          | GNS            | NA                 | Static            | Gillnet               |
| 1353 | GNS\_SPF\_0\_0\_0          | NA           | NA                | NA                            | GNS\_SPF          | GNS            | NA                 | Static            | Gillnet               |
| 1354 | GNS\_SPF\_0\_40\_0         | NA           | NA                | NA                            | GNS\_SPF          | GNS            | NA                 | Static            | Gillnet               |
| 1355 | GNS\_SPF\_10-30\_0\_0      | NA           | NA                | NA                            | GNS\_SPF          | GNS            | NA                 | Static            | Gillnet               |
| 1356 | GNS\_SPF\_100-119\_0\_0    | NA           | NA                | NA                            | GNS\_SPF          | GNS            | NA                 | Static            | Gillnet               |
| 1357 | GNS\_SPF\_100\_119\_0      | NA           | NA                | NA                            | GNS\_SPF          | GNS            | NA                 | Static            | Gillnet               |
| 1358 | GNS\_SPF\_10\_30\_0        | NA           | NA                | NA                            | GNS\_SPF          | GNS            | NA                 | Static            | Gillnet               |
| 1359 | GNS\_SPF\_110-156\_0\_0    | NA           | NA                | NA                            | GNS\_SPF          | GNS            | NA                 | Static            | Gillnet               |
| 1360 | GNS\_SPF\_120-219\_0\_0    | NA           | NA                | NA                            | GNS\_SPF          | GNS            | NA                 | Static            | Gillnet               |
| 1361 | GNS\_SPF\_120\_219\_0      | NA           | NA                | NA                            | GNS\_SPF          | GNS            | NA                 | Static            | Gillnet               |
| 1362 | GNS\_SPF\_157-219\_0\_0    | NA           | NA                | NA                            | GNS\_SPF          | GNS            | NA                 | Static            | Gillnet               |
| 1363 | GNS\_SPF\_16-109           | NA           | NA                | NA                            | GNS\_SPF          | GNS            | NA                 | Static            | Gillnet               |
| 1364 | GNS\_SPF\_16-109\_0\_0     | NA           | NA                | NA                            | GNS\_SPF          | GNS            | NA                 | Static            | Gillnet               |
| 1365 | GNS\_SPF\_31-49\_0\_0      | NA           | NA                | NA                            | GNS\_SPF          | GNS            | NA                 | Static            | Gillnet               |
| 1366 | GNS\_SPF\_32-109\_0\_0     | NA           | NA                | NA                            | GNS\_SPF          | GNS            | NA                 | Static            | Gillnet               |
| 1367 | GNS\_SPF\_40\_49\_0        | NA           | NA                | NA                            | GNS\_SPF          | GNS            | NA                 | Static            | Gillnet               |
| 1368 | GNS\_SPF\_50-59\_0\_0      | NA           | NA                | NA                            | GNS\_SPF          | GNS            | NA                 | Static            | Gillnet               |
| 1369 | GNS\_SPF\_50-70\_0\_0      | NA           | NA                | NA                            | GNS\_SPF          | GNS            | NA                 | Static            | Gillnet               |
| 1370 | GNS\_SPF\_50\_59\_0        | NA           | NA                | NA                            | GNS\_SPF          | GNS            | NA                 | Static            | Gillnet               |
| 1371 | GNS\_SPF\_50\_70\_0        | NA           | NA                | NA                            | GNS\_SPF          | GNS            | NA                 | Static            | Gillnet               |
| 1372 | GNS\_SPF\_60-69\_0\_0      | NA           | NA                | NA                            | GNS\_SPF          | GNS            | NA                 | Static            | Gillnet               |
| 1373 | GNS\_SPF\_60\_79\_0        | NA           | NA                | NA                            | GNS\_SPF          | GNS            | NA                 | Static            | Gillnet               |
| 1374 | GNS\_SPF\_624              | NA           | NA                | NA                            | GNS\_SPF          | GNS            | NA                 | Static            | Gillnet               |
| 1375 | GNS\_SPF\_70-79\_0\_0      | NA           | NA                | NA                            | GNS\_SPF          | GNS            | NA                 | Static            | Gillnet               |
| 1376 | GNS\_SPF\_80\_99\_0        | NA           | NA                | NA                            | GNS\_SPF          | GNS            | NA                 | Static            | Gillnet               |
| 1377 | GNS\_SPF\_90-99\_0\_0      | NA           | NA                | NA                            | GNS\_SPF          | GNS            | NA                 | Static            | Gillnet               |
| 1378 | GNS\_SPF\_90\_99\_0        | NA           | NA                | NA                            | GNS\_SPF          | GNS            | NA                 | Static            | Gillnet               |
| 1379 | GNS\_SPF\_\>=100\_0        | NA           | NA                | NA                            | GNS\_SPF          | GNS            | NA                 | Static            | Gillnet               |
| 1380 | GNS\_SPF\_\>=157\_0\_0     | NA           | NA                | NA                            | GNS\_SPF          | GNS            | NA                 | Static            | Gillnet               |
| 1381 | GNS\_SPF\_\>=220\_0        | NA           | NA                | NA                            | GNS\_SPF          | GNS            | NA                 | Static            | Gillnet               |
| 1382 | GNS\_SPF\_\>=220\_0\_0     | NA           | NA                | NA                            | GNS\_SPF          | GNS            | NA                 | Static            | Gillnet               |
| 1383 | GNS\_SPF\_misc\_0\_0       | NA           | NA                | NA                            | GNS\_SPF          | GNS            | NA                 | Static            | Gillnet               |
| 1384 | GNS\_UNK\_0                | NA           | NA                | NA                            | GNS\_UNK          | GNS            | NA                 | Static            | Gillnet               |
| 1385 | GNS\_UNK\_349              | NA           | NA                | NA                            | GNS\_UNK          | GNS            | NA                 | Static            | Gillnet               |
| 1386 | GN\_DEF\_0                 | NA           | NA                | NA                            | GN\_DEF           | GN             | NA                 | Static            | Gillnet               |
| 1387 | GN\_DEF\_1249              | NA           | NA                | NA                            | GN\_DEF           | GN             | NA                 | Static            | Gillnet               |
| 1388 | SDN\_CEP\_100\_119\_0      | NA           | SDN\_DMF          | SDN\_DMF                      | SDN\_CEP          | SDN            | NA                 | Seine             | Danish\_seine         |
| 1389 | SDN\_CEP\_16\_31\_0        | NA           | SDN\_DMF          | NA                            | SDN\_CEP          | SDN            | NA                 | Seine             | Danish\_seine         |
| 1390 | SDN\_CEP\_32\_54\_0        | NA           | SDN\_DMF          | SDN\_DMF                      | SDN\_CEP          | SDN            | NA                 | Seine             | Danish\_seine         |
| 1391 | SDN\_CEP\_32\_69\_0        | NA           | SDN\_DMF          | SDN\_DMF                      | SDN\_CEP          | SDN            | NA                 | Seine             | Danish\_seine         |
| 1392 | SDN\_CEP\_70\_99\_0        | NA           | SDN\_DMF          | SDN\_DMF                      | SDN\_CEP          | SDN            | NA                 | Seine             | Danish\_seine         |
| 1393 | SDN\_CEP\_\>=120\_0        | NA           | SDN\_DMF          | NA                            | SDN\_CEP          | SDN            | NA                 | Seine             | Danish\_seine         |
| 1394 | SDN\_CEP\_\>=70\_0         | NA           | SDN\_DMF          | SDN\_DMF                      | SDN\_CEP          | SDN            | NA                 | Seine             | Danish\_seine         |
| 1395 | SDN\_DEF\_0                | NA           | SDN\_DMF          | NA                            | SDN\_DEF          | SDN            | NA                 | Seine             | Danish\_seine         |
| 1396 | SDN\_DEF\_0\_0\_0          | NA           | SDN\_DMF          | SDN\_DMF                      | SDN\_DEF          | SDN            | NA                 | Seine             | Danish\_seine         |
| 1397 | SDN\_DEF\_0\_16\_0         | NA           | SDN\_DMF          | SDN\_DMF                      | SDN\_DEF          | SDN            | NA                 | Seine             | Danish\_seine         |
| 1398 | SDN\_DEF\_100-119\_0\_0    | NA           | SDN\_DMF          | SDN\_DMF                      | SDN\_DEF          | SDN            | NA                 | Seine             | Danish\_seine         |
| 1399 | SDN\_DEF\_100\_119\_0      | NA           | SDN\_DMF          | SDN\_DMF                      | SDN\_DEF          | SDN            | NA                 | Seine             | Danish\_seine         |
| 1400 | SDN\_DEF\_1249             | NA           | SDN\_DMF          | SDN\_DMF                      | SDN\_DEF          | SDN            | NA                 | Seine             | Danish\_seine         |
| 1401 | SDN\_DEF\_2499             | NA           | SDN\_DMF          | SDN\_DMF                      | SDN\_DEF          | SDN            | NA                 | Seine             | Danish\_seine         |
| 1402 | SDN\_DEF\_32-54\_0\_0      | NA           | SDN\_DMF          | NA                            | SDN\_DEF          | SDN            | NA                 | Seine             | Danish\_seine         |
| 1403 | SDN\_DEF\_32\_69\_0        | NA           | SDN\_DMF          | SDN\_DMF                      | SDN\_DEF          | SDN            | NA                 | Seine             | Danish\_seine         |
| 1404 | SDN\_DEF\_349              | NA           | SDN\_DMF          | SDN\_DMF                      | SDN\_DEF          | SDN            | NA                 | Seine             | Danish\_seine         |
| 1405 | SDN\_DEF\_624              | NA           | SDN\_DMF          | SDN\_DMF                      | SDN\_DEF          | SDN            | NA                 | Seine             | Danish\_seine         |
| 1406 | SDN\_DEF\_70-99\_0\_0      | NA           | SDN\_DMF          | SDN\_DMF                      | SDN\_DEF          | SDN            | NA                 | Seine             | Danish\_seine         |
| 1407 | SDN\_DEF\_70\_99\_0        | NA           | SDN\_DMF          | SDN\_DMF                      | SDN\_DEF          | SDN            | NA                 | Seine             | Danish\_seine         |
| 1408 | SDN\_DEF\_874              | NA           | SDN\_DMF          | SDN\_DMF                      | SDN\_DEF          | SDN            | NA                 | Seine             | Danish\_seine         |
| 1409 | SDN\_DEF\_90-119\_0\_0     | NA           | SDN\_DMF          | SDN\_DMF                      | SDN\_DEF          | SDN            | NA                 | Seine             | Danish\_seine         |
| 1410 | SDN\_DEF\_\>0              | NA           | SDN\_DMF          | NA                            | SDN\_DEF          | SDN            | NA                 | Seine             | Danish\_seine         |
| 1411 | SDN\_DEF\_\>0\_0\_0        | NA           | SDN\_DMF          | SDN\_DMF                      | SDN\_DEF          | SDN            | NA                 | Seine             | Danish\_seine         |
| 1412 | SDN\_DEF\_\>=105\_0\_0     | NA           | SDN\_DMF          | SDN\_DMF                      | SDN\_DEF          | SDN            | NA                 | Seine             | Danish\_seine         |
| 1413 | SDN\_DEF\_\>=105\_1\_110   | NA           | SDN\_DMF          | SDN\_DMF                      | SDN\_DEF          | SDN            | NA                 | Seine             | Danish\_seine         |
| 1414 | SDN\_DEF\_\>=105\_1\_120   | NA           | SDN\_DMF          | SDN\_DMF                      | SDN\_DEF          | SDN            | NA                 | Seine             | Danish\_seine         |
| 1415 | SDN\_DEF\_\>=120\_0        | NA           | SDN\_DMF          | SDN\_DMF                      | SDN\_DEF          | SDN            | NA                 | Seine             | Danish\_seine         |
| 1416 | SDN\_DEF\_\>=120\_0\_0     | NA           | SDN\_DMF          | SDN\_DMF                      | SDN\_DEF          | SDN            | NA                 | Seine             | Danish\_seine         |
| 1417 | SDN\_DEF\_\>=70\_0         | NA           | SDN\_DMF          | SDN\_DMF                      | SDN\_DEF          | SDN            | NA                 | Seine             | Danish\_seine         |
| 1418 | SDN\_FWS\_0\_0\_0          | NA           | SDN\_DMF          | NA                            | SDN\_FWS          | SDN            | NA                 | Seine             | Danish\_seine         |
| 1419 | SDN\_SPF\_0\_0\_0          | NA           | SDN\_DMF          | NA                            | SDN\_SPF          | SDN            | NA                 | Seine             | Danish\_seine         |
| 1420 | SDN\_SPF\_32-54\_0\_0      | NA           | SDN\_DMF          | NA                            | SDN\_SPF          | SDN            | NA                 | Seine             | Danish\_seine         |
| 1421 | SPR\_DEF\_0                | NA           | SDN\_DMF          | NA                            | SPR\_DEF          | SPR            | Pair\_Trawl\_Seine | Seine             | Pair\_seine           |
| 1422 | SPR\_DEF\_100-119\_0\_0    | NA           | SDN\_DMF          | SDN\_DMF                      | SPR\_DEF          | SPR            | Pair\_Trawl\_Seine | Seine             | Pair\_seine           |
| 1423 | SPR\_DEF\_1249             | NA           | SDN\_DMF          | SDN\_DMF                      | SPR\_DEF          | SPR            | Pair\_Trawl\_Seine | Seine             | Pair\_seine           |
| 1424 | SPR\_DEF\_70-99\_0\_0      | NA           | SDN\_DMF          | SDN\_DMF                      | SPR\_DEF          | SPR            | Pair\_Trawl\_Seine | Seine             | Pair\_seine           |
| 1425 | SPR\_DEF\_\>=120\_0\_0     | NA           | SDN\_DMF          | NA                            | SPR\_DEF          | SPR            | Pair\_Trawl\_Seine | Seine             | Pair\_seine           |
| 1426 | SSC\_CRU\_0                | NA           | SSC\_DMF          | NA                            | SSC\_CRU          | SSC            | NA                 | Seine             | Scottish\_Seine       |
| 1427 | SSC\_CRU\_100-119\_0\_0    | NA           | SSC\_DMF          | NA                            | SSC\_CRU          | SSC            | NA                 | Seine             | Scottish\_Seine       |
| 1428 | SSC\_CRU\_349              | NA           | SSC\_DMF          | SSC\_DMF                      | SSC\_CRU          | SSC            | NA                 | Seine             | Scottish\_Seine       |
| 1429 | SSC\_CRU\_624              | NA           | SSC\_DMF          | SSC\_DMF                      | SSC\_CRU          | SSC            | NA                 | Seine             | Scottish\_Seine       |
| 1430 | SSC\_DEF\_0                | NA           | SSC\_DMF          | NA                            | SSC\_DEF          | SSC            | NA                 | Seine             | Scottish\_Seine       |
| 1431 | SSC\_DEF\_0\_0\_0          | NA           | SSC\_DMF          | SSC\_DMF                      | SSC\_DEF          | SSC            | NA                 | Seine             | Scottish\_Seine       |
| 1432 | SSC\_DEF\_100-119          | NA           | SSC\_DMF          | SSC\_DMF                      | SSC\_DEF          | SSC            | NA                 | Seine             | Scottish\_Seine       |
| 1433 | SSC\_DEF\_100-119\_0\_0    | NA           | SSC\_DMF          | SSC\_DMF                      | SSC\_DEF          | SSC            | NA                 | Seine             | Scottish\_Seine       |
| 1434 | SSC\_DEF\_1249             | NA           | SSC\_DMF          | SSC\_DMF                      | SSC\_DEF          | SSC            | NA                 | Seine             | Scottish\_Seine       |
| 1435 | SSC\_DEF\_1749             | NA           | SSC\_DMF          | SSC\_DMF                      | SSC\_DEF          | SSC            | NA                 | Seine             | Scottish\_Seine       |
| 1436 | SSC\_DEF\_2499             | NA           | SSC\_DMF          | SSC\_DMF                      | SSC\_DEF          | SSC            | NA                 | Seine             | Scottish\_Seine       |
| 1437 | SSC\_DEF\_32-69\_0\_0      | NA           | SSC\_DMF          | SSC\_DMF                      | SSC\_DEF          | SSC            | NA                 | Seine             | Scottish\_Seine       |
| 1438 | SSC\_DEF\_349              | NA           | SSC\_DMF          | SSC\_DMF                      | SSC\_DEF          | SSC            | NA                 | Seine             | Scottish\_Seine       |
| 1439 | SSC\_DEF\_3999             | NA           | SSC\_DMF          | SSC\_DMF                      | SSC\_DEF          | SSC            | NA                 | Seine             | Scottish\_Seine       |
| 1440 | SSC\_DEF\_624              | NA           | SSC\_DMF          | SSC\_DMF                      | SSC\_DEF          | SSC            | NA                 | Seine             | Scottish\_Seine       |
| 1441 | GTR\_DEF\_50-70\_0\_0      | NA           | NA                | NA                            | GTR\_DEF          | GTR            | NA                 | Static            | Trammel               |
| 1442 | GTR\_DEF\_50\_59\_0        | NA           | NA                | NA                            | GTR\_DEF          | GTR            | NA                 | Static            | Trammel               |
| 1443 | GTR\_DEF\_50\_70\_0        | NA           | NA                | NA                            | GTR\_DEF          | GTR            | NA                 | Static            | Trammel               |
| 1444 | GTR\_DEF\_60\_79\_0        | NA           | NA                | NA                            | GTR\_DEF          | GTR            | NA                 | Static            | Trammel               |
| 1445 | GTR\_DEF\_80\_99\_0        | NA           | NA                | NA                            | GTR\_DEF          | GTR            | NA                 | Static            | Trammel               |
| 1446 | GTR\_DEF\_90-99            | NA           | NA                | NA                            | GTR\_DEF          | GTR            | NA                 | Static            | Trammel               |
| 1447 | GTR\_DEF\_90-99\_0\_0      | NA           | NA                | NA                            | GTR\_DEF          | GTR            | NA                 | Static            | Trammel               |
| 1448 | GTR\_DEF\_90\_99\_0        | NA           | NA                | NA                            | GTR\_DEF          | GTR            | NA                 | Static            | Trammel               |
| 1449 | GTR\_DEF\_\>=100\_0        | NA           | NA                | NA                            | GTR\_DEF          | GTR            | NA                 | Static            | Trammel               |
| 1450 | GTR\_DEF\_\>=100\_0\_0     | NA           | NA                | NA                            | GTR\_DEF          | GTR            | NA                 | Static            | Trammel               |
| 1451 | GTR\_DEF\_\>=157\_0\_0     | NA           | NA                | NA                            | GTR\_DEF          | GTR            | NA                 | Static            | Trammel               |
| 1452 | GTR\_DEF\_\>=220\_0        | NA           | NA                | NA                            | GTR\_DEF          | GTR            | NA                 | Static            | Trammel               |
| 1453 | GTR\_DEF\_\>=220\_0\_0     | NA           | NA                | NA                            | GTR\_DEF          | GTR            | NA                 | Static            | Trammel               |
| 1454 | GTR\_DEF\_\>=80\_0\_0      | NA           | NA                | NA                            | GTR\_DEF          | GTR            | NA                 | Static            | Trammel               |
| 1455 | GTR\_DEF\_misc\_0\_0       | NA           | NA                | NA                            | GTR\_DEF          | GTR            | NA                 | Static            | Trammel               |
| 1456 | GTR\_FIF\_NA\_0\_0         | NA           | NA                | NA                            | GTR\_FIF          | GTR            | NA                 | Static            | Trammel               |
| 1457 | GTR\_FWS\_0\_0\_0          | NA           | NA                | NA                            | GTR\_FWS          | GTR            | NA                 | Static            | Trammel               |
| 1458 | GTR\_FWS\_\>0\_0\_0        | NA           | NA                | NA                            | GTR\_FWS          | GTR            | NA                 | Static            | Trammel               |
| 1459 | GTR\_SPF\_32-109\_0\_0     | NA           | NA                | NA                            | GTR\_SPF          | GTR            | NA                 | Static            | Trammel               |
| 1460 | HAR\_UNK\_1249             | NA           | NA                | NA                            | HAR\_UNK          | HAR            | NA                 | Other             | Harpoon               |
| 1461 | HAR\_UNK\_349              | NA           | NA                | NA                            | HAR\_UNK          | HAR            | NA                 | Other             | Harpoon               |
| 1462 | HAR\_UNK\_624              | NA           | NA                | NA                            | HAR\_UNK          | HAR            | NA                 | Other             | Harpoon               |
| 1463 | HAR\_UNK\_874              | NA           | NA                | NA                            | HAR\_UNK          | HAR            | NA                 | Other             | Harpoon               |
| 1464 | HMD\_MOL\_0\_0\_0          | NA           | NA                | NA                            | HMD\_MOL          | HMD            | NA                 | Dredge            | Dredge                |
| 1465 | HMD\_MOL\_70-99\_0\_0      | NA           | NA                | NA                            | HMD\_MOL          | HMD            | NA                 | Dredge            | Dredge                |
| 1466 | HMD\_MOL\_\<16\_0\_0       | NA           | NA                | NA                            | HMD\_MOL          | HMD            | NA                 | Dredge            | Dredge                |
| 1467 | HMD\_MOL\_\>=120\_0\_0     | NA           | NA                | NA                            | HMD\_MOL          | HMD            | NA                 | Dredge            | Dredge                |
| 1468 | HMD\_MOL\_UND\_0\_0        | NA           | NA                | NA                            | HMD\_MOL          | HMD            | NA                 | Dredge            | Dredge                |
| 1469 | LA\_DEF\_0                 | NA           | NA                | NA                            | LA\_DEF           | LA             | NA                 | Static            | Lines                 |
| 1470 | LA\_DEF\_0\_0\_0           | NA           | NA                | NA                            | LA\_DEF           | LA             | NA                 | Static            | Lines                 |
| 1471 | LA\_DEF\_1249              | NA           | NA                | NA                            | LA\_DEF           | LA             | NA                 | Static            | Lines                 |
| 1472 | LHM\_DEF\_0                | NA           | NA                | NA                            | LHM\_DEF          | LHM            | NA                 | Static            | Lines                 |
| 1473 | LHM\_DEF\_349              | NA           | NA                | NA                            | LHM\_DEF          | LHM            | NA                 | Static            | Lines                 |
| 1474 | LHM\_FIF\_0\_0\_0          | NA           | NA                | NA                            | LHM\_FIF          | LHM            | NA                 | Static            | Lines                 |
| 1475 | LHM\_SPF\_0                | NA           | NA                | NA                            | LHM\_SPF          | LHM            | NA                 | Static            | Lines                 |
| 1476 | LHM\_SPF\_624              | NA           | NA                | NA                            | LHM\_SPF          | LHM            | NA                 | Static            | Lines                 |
| 1477 | LHM\_UNK\_0                | NA           | NA                | NA                            | LHM\_UNK          | LHM            | NA                 | Static            | Lines                 |
| 1478 | LHM\_UNK\_349              | NA           | NA                | NA                            | LHM\_UNK          | LHM            | NA                 | Static            | Lines                 |
| 1479 | LHP\_CEP\_0\_0\_0          | NA           | NA                | NA                            | LHP\_CEP          | LHP            | NA                 | Static            | Lines                 |
| 1480 | LHP\_CRU\_0-0\_0\_0        | NA           | NA                | NA                            | LHP\_CRU          | LHP            | NA                 | Static            | Lines                 |
| 1481 | LHP\_DEF\_0                | NA           | NA                | NA                            | LHP\_DEF          | LHP            | NA                 | Static            | Lines                 |
| 1482 | LHP\_DEF\_0-0\_0\_0        | NA           | NA                | NA                            | LHP\_DEF          | LHP            | NA                 | Static            | Lines                 |
| 1483 | LHP\_DEF\_0\_0\_0          | NA           | NA                | NA                            | LHP\_DEF          | LHP            | NA                 | Static            | Lines                 |
| 1484 | LHP\_FIF\_-\_0\_0          | NA           | NA                | NA                            | LHP\_FIF          | LHP            | NA                 | Static            | Lines                 |
| 1485 | LHP\_FIF\_0\_0\_0          | NA           | NA                | NA                            | LHP\_FIF          | LHP            | NA                 | Static            | Lines                 |
| 1486 | LHP\_FIN\_0\_0\_0          | NA           | NA                | NA                            | LHP\_FIN          | LHP            | NA                 | Static            | Lines                 |
| 1487 | LHP\_LPF\_0-0\_0\_0        | NA           | NA                | NA                            | LHP\_LPF          | LHP            | NA                 | Static            | Lines                 |
| 1488 | LHP\_LPF\_0\_0\_0          | NA           | NA                | NA                            | LHP\_LPF          | LHP            | NA                 | Static            | Lines                 |
| 1489 | LHP\_SPF\_0-0\_0\_0        | NA           | NA                | NA                            | LHP\_SPF          | LHP            | NA                 | Static            | Lines                 |
| 1490 | LHP\_SPF\_0\_0\_0          | NA           | NA                | NA                            | LHP\_SPF          | LHP            | NA                 | Static            | Lines                 |
| 1491 | LLD\_ANA\_0\_0\_0          | NA           | NA                | NA                            | LLD\_ANA          | LLD            | NA                 | Static            | Longlines             |
| 1492 | LLD\_ANA\_10-30\_0\_0      | NA           | NA                | NA                            | LLD\_ANA          | LLD            | NA                 | Static            | Longlines             |
| 1493 | LLD\_ANA\_50-59\_0\_0      | NA           | NA                | NA                            | LLD\_ANA          | LLD            | NA                 | Static            | Longlines             |
| 1494 | LLD\_ANA\_NA\_0\_0         | NA           | NA                | NA                            | LLD\_ANA          | LLD            | NA                 | Static            | Longlines             |
| 1495 | LLD\_CRU\_0-0\_0\_0        | NA           | NA                | NA                            | LLD\_CRU          | LLD            | NA                 | Static            | Longlines             |
| 1496 | LLD\_DEF\_0                | NA           | NA                | NA                            | LLD\_DEF          | LLD            | NA                 | Static            | Longlines             |
| 1497 | LLD\_DEF\_0-0\_0\_0        | NA           | NA                | NA                            | LLD\_DEF          | LLD            | NA                 | Static            | Longlines             |
| 1498 | LLD\_DEF\_0\_0\_0          | NA           | NA                | NA                            | LLD\_DEF          | LLD            | NA                 | Static            | Longlines             |
| 1499 | LLD\_DEF\_10-30\_0\_0      | NA           | NA                | NA                            | LLD\_DEF          | LLD            | NA                 | Static            | Longlines             |
| 1500 | LLD\_DEF\_349              | NA           | NA                | NA                            | LLD\_DEF          | LLD            | NA                 | Static            | Longlines             |
| 1501 | LLD\_DEF\_624              | NA           | NA                | NA                            | LLD\_DEF          | LLD            | NA                 | Static            | Longlines             |
| 1502 | LLD\_DEF\_874              | NA           | NA                | NA                            | LLD\_DEF          | LLD            | NA                 | Static            | Longlines             |
| 1503 | LLD\_FWS\_10-30\_0\_0      | NA           | NA                | NA                            | LLD\_FWS          | LLD            | NA                 | Static            | Longlines             |
| 1504 | LLD\_LPF\_0\_0\_0          | NA           | NA                | NA                            | LLD\_LPF          | LLD            | NA                 | Static            | Longlines             |
| 1505 | LLD\_SPF\_0-0\_0\_0        | NA           | NA                | NA                            | LLD\_SPF          | LLD            | NA                 | Static            | Longlines             |
| 1506 | LLD\_SPF\_0\_0\_0          | NA           | NA                | NA                            | LLD\_SPF          | LLD            | NA                 | Static            | Longlines             |
| 1507 | LLS\_ANA\_0\_0\_0          | NA           | NA                | NA                            | LLS\_ANA          | LLS            | NA                 | Static            | Longlines             |
| 1508 | LE\_MET\_level6            | NA           | Benthis\_metiers  | Benthis\_metiers\_2016\_Wrong | Metier\_level5    | Metier\_level4 | JNCC\_grouping     | Fishing\_category | Description           |
| 1509 | DRB\_MOL\_100\_0\_0        | NA           | DRB\_MOL          | DRB\_MOL                      | DRB\_MOL          | Dredge         | Boat\_dredge       | Dredge            | Benthis\_metiers      |
| 1510 | FPO\_CRU\_120-219\_0\_0    | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            | DRB\_MOL              |
| 1523 | OTB\_DEF\_0\_SAN           | NA           | OT\_DMF           | OT\_DMF                       | OT\_DMF           | Otter          | Otter\_Trawl       | Otter             | TBB\_MOL              |
| 1526 | OTB\_DMF\_135\_0\_0        | NA           | OT\_DMF           | OT\_DMF                       | OT\_DMF           | Otter          | Otter\_Trawl       | Otter             |                       |
| 1527 | OTB\_DMF\_155\_0\_0        | NA           | OT\_DMF           | OT\_DMF                       | OT\_DMF           | Otter          | Otter\_Trawl       | Otter             |                       |
| 1529 | OTB\_DWS\_0\_SAN           | NA           | OT\_MIX\_DMF\_BEN | OT\_MIX\_DMF\_BEN             | OT\_MIX\_DMF\_BEN | Otter          | Otter\_Trawl       | Otter             |                       |
| 1531 | OTB\_FWS\_0                | NA           | OT\_DMF           | OT\_DMF                       | OT\_DMF           | Otter          | Otter\_Trawl       | Otter             |                       |
| 1533 | OTB\_NEP\_80\_0\_0         | NA           | OT\_CRU           | OT\_CRU                       | OT\_CRU           | Otter          | Otter\_Trawl       | Otter             |                       |
| 1534 | OTB\_SHR\_36\_0\_0         | NA           | OT\_CRU           | OT\_CRU                       | OT\_CRU           | Otter          | Otter\_Trawl       | Otter             |                       |
| 1535 | OTB\_SHR\_40\_0\_0         | NA           | OT\_CRU           | OT\_CRU                       | OT\_CRU           | Otter          | Otter\_Trawl       | Otter             |                       |
| 1537 | OTB\_SPF\_0\_SAN           | NA           | OT\_SPF           | OT\_SPF                       | OT\_SPF           | Otter          | Otter\_Trawl       | Otter             |                       |
| 1540 | OTM\_DEF\_0\_SAN           | NA           | NA                | NA                            | NA                | Midwater       | NA                 | Midwater          |                       |
| 1543 | OTM\_SPF\_0\_SAN           | NA           | NA                | NA                            | NA                | Midwater       | NA                 | Midwater          |                       |
| 1547 | OTM\_UNK\_0                | NA           | NA                | NA                            | NA                | Midwater       | NA                 | Midwater          |                       |
| 1557 | PTB\_MOL\_0                | NA           | OT\_MIX           | OT\_MIX                       | OT\_MIX           | Otter          | Pair\_Trawl\_Seine | Otter             |                       |
| 1560 | PTM\_DEF\_0\_SAN           | NA           | NA                | NA                            | NA                | Midwater       | NA                 | Midwater          |                       |
| 1574 | FPO\_CRU\_90-99\_0\_0      | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1575 | FPO\_MCD\_0                | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1576 | FPO\_MCD\_UND\_0\_0        | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1577 | FPO\_vvv\_vvv\_vvv\_vvv    | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1578 | FYK\_ANA\_\>0\_0\_0        | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1579 | FYK\_CAT\_\>=220\_0\_0     | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1580 | FYK\_CAT\_100-119\_0\_0    | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1581 | FYK\_CAT\_10-30\_0\_0      | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1582 | FYK\_CAT\_120-219\_0\_0    | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1583 | FYK\_CAT\_50-70\_0\_0      | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1584 | FYK\_CAT\_UND\_0\_0        | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1585 | GEN\_DEF\_0                | NA           | NA                | NA                            | NA                | Other          | NA                 | Other             |                       |
| 1586 | GEN\_UNK\_0                | NA           | NA                | NA                            | NA                | Other          | NA                 | Other             |                       |
| 1587 | GN\_SPF\_0                 | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1588 | GND\_DEF\_\>=220\_0\_0     | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1590 | GND\_DEF\_100-119\_0\_0    | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1592 | GND\_DEF\_10-30\_0\_0      | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1594 | GND\_DEF\_120-219\_0\_0    | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1595 | GND\_DEF\_50-70\_0\_0      | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1596 | GND\_DEF\_90-99\_0\_0      | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1597 | GND\_LPF\_90\_99\_0        | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1598 | GND\_SPF\_\>=220\_0        | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1599 | GND\_SPF\_\>=220\_0\_0     | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1600 | GND\_SPF\_0                | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1601 | GND\_SPF\_100-119\_0\_0    | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1602 | GND\_SPF\_10-30\_0\_0      | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1603 | GND\_SPF\_120-219\_0\_0    | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1604 | GND\_SPF\_40\_49\_0        | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1605 | GND\_SPF\_50-70\_0\_0      | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1606 | GND\_SPF\_90-99\_0\_0      | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1607 | GNS\_ANA\_\_\_             | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1608 | GNS\_CAT\_120\_219\_0      | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1609 | GNS\_DEF\_\_\_             | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1610 | GNS\_DEF\_\<40\_0\_0       | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1611 | GNS\_DEF\_60-70\_0\_0      | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1612 | GNS\_DWS\_\>=100\_0\_0     | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1613 | GNS\_DWS\_10-30\_0\_0      | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1614 | GNS\_DWS\_50-70\_0\_0      | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1615 | GNS\_DWS\_90-99\_0\_0      | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1616 | GNS\_SPF\_\_\_             | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1617 | GNS\_SPF\_100-119\_\_      | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1618 | GNS\_vvv\_vvv\_vvv\_vvv    | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1619 | GTN\_DEF\_0                | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1620 | GTN\_DEF\_100\_119\_0      | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1621 | GTN\_DEF\_110-156\_0\_0    | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1622 | GTN\_UND\_100-119\_0\_0    | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1623 | GTN\_UND\_120-219\_0\_0    | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1624 | GTR\_DEF\_\>=70\_0\_0      | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1625 | GTR\_DEF\_\>0\_0\_0        | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1626 | GTR\_DEF\_90-109\_0\_0     | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1627 | GTR\_DEF\_UND\_0\_0        | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1628 | GTR\_vvv\_vvv\_vvv\_vvv    | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1629 | HAR\_UNK\_0                | NA           | NA                | NA                            | NA                | Other          | NA                 | Other             |                       |
| 1630 | LHP\_CRU\_16-31\_0\_0      | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1631 | LHP\_MPD\_0\_0\_0          | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1632 | LLD\_DWS\_0\_0\_0          | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1633 | LLS\_DEF\_\>0\_0\_0        | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1634 | LLS\_vvv\_vvv\_vvv\_vvv    | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1635 | LNB\_UND\_100-119\_0\_0    | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1636 | LTL\_UND\_UND\_0\_0        | NA           | NA                | NA                            | NA                | Static         | NA                 | Static            |                       |
| 1637 | MISSING                    | NA           | NA                | NA                            | NA                | Other          | NA                 | Other             |                       |
| 1638 | NK\_UND\_UND\_0\_0         | NA           | NA                | NA                            | NA                | Other          | NA                 | Other             |                       |
| 1639 | OFG\_UND\_10-30\_0\_0      | NA           | NA                | NA                            | NA                | Other          | NA                 | Other             |                       |
| 1640 | OTB\_\_100-119\_0\_0       | NA           | OT\_DMF           | OT\_DMF                       | OT\_DMF           | Otter          | Otter\_Trawl       | Otter             |                       |
| 1641 | OTB\_CRU\_32-54\_2\_19-22  | NA           | OT\_CRU           | OT\_CRU                       | OT\_CRU           | Otter          | Otter\_Trawl       | Otter             |                       |
| 1642 | OTB\_CRU\_60-89\_0\_0      | NA           | OT\_CRU           | OT\_CRU                       | OT\_CRU           | Otter          | Otter\_Trawl       | Otter             |                       |
| 1643 | OTB\_DEF\_\<16\_0\_0       | NA           | OT\_DMF           | OT\_DMF                       | OT\_DMF           | Otter          | Otter\_Trawl       | Otter             |                       |
| 1644 | OTB\_DEF\_\>=55\_0         | NA           | OT\_DMF           | OT\_DMF                       | OT\_DMF           | Otter          | Otter\_Trawl       | Otter             |                       |
| 1645 | OTB\_DEF\_100-129\_0\_0    | NA           | OT\_DMF           | OT\_DMF                       | OT\_DMF           | Otter          | Otter\_Trawl       | Otter             |                       |
| 1646 | OTB\_DEF\_16-31\_2\_35     | NA           | OT\_DMF           | OT\_DMF                       | OT\_DMF           | Otter          | Otter\_Trawl       | Otter             |                       |
| 1647 | OTB\_DEF\_70-89\_0\_0      | NA           | OT\_DMF           | OT\_DMF                       | OT\_DMF           | Otter          | Otter\_Trawl       | Otter             |                       |
| 1648 | OTB\_DEF\_x\_x\_x          | NA           | OT\_DMF           | OT\_DMF                       | OT\_DMF           | Otter          | Otter\_Trawl       | Otter             |                       |
| 1649 | OTB\_DWS\_\<16\_0\_0       | NA           | OT\_MIX\_DMF\_BEN | OT\_MIX\_DMF\_BEN             | OT\_MIX\_DMF\_BEN | Otter          | Otter\_Trawl       | Otter             |                       |
| 1650 | OTB\_DWS\_\>=130\_0\_0     | NA           | OT\_MIX\_DMF\_BEN | OT\_MIX\_DMF\_BEN             | OT\_MIX\_DMF\_BEN | Otter          | Otter\_Trawl       | Otter             |                       |
| 1651 | OTB\_DWS\_100-129\_0\_0    | NA           | OT\_MIX\_DMF\_BEN | OT\_MIX\_DMF\_BEN             | OT\_MIX\_DMF\_BEN | Otter          | Otter\_Trawl       | Otter             |                       |
| 1652 | OTB\_MOL\_\>=70\_0\_0      | NA           | OT\_MIX           | OT\_MIX                       | OT\_MIX           | Otter          | Otter\_Trawl       | Otter             |                       |
| 1653 | OTB\_SPF\_\>=70\_0\_0      | NA           | OT\_SPF           | OT\_SPF                       | OT\_SPF           | Otter          | Otter\_Trawl       | Otter             |                       |
| 1654 | OTB\_SPF\_x\_x\_x          | NA           | OT\_SPF           | OT\_SPF                       | OT\_SPF           | Otter          | Otter\_Trawl       | Otter             |                       |
| 1655 | OTG\_UND\_16-31\_0\_0      | NA           | NA                | NA                            | NA                | Other          | NA                 | Other             |                       |
| 1656 | OTM\_\_\>=120\_0\_0        | NA           | NA                | NA                            | NA                | Midwater       | NA                 | Midwater          |                       |
| 1657 | OTM\_\_100-119\_0\_0       | NA           | NA                | NA                            | NA                | Midwater       | NA                 | Midwater          |                       |
| 1658 | OTM\_\_16-31\_0\_0         | NA           | NA                | NA                            | NA                | Midwater       | NA                 | Midwater          |                       |
| 1659 | OTM\_DEF\_16-31\_2\_35     | NA           | NA                | NA                            | NA                | Midwater       | NA                 | Midwater          |                       |
| 1660 | OTM\_DEF\_x\_x\_x          | NA           | NA                | NA                            | NA                | Midwater       | NA                 | Midwater          |                       |
| 1661 | OTM\_DWS\_0\_0\_0          | NA           | NA                | NA                            | NA                | Midwater       | NA                 | Midwater          |                       |
| 1662 | OTM\_SPF\_\>=110\_0\_0     | NA           | NA                | NA                            | NA                | Midwater       | NA                 | Midwater          |                       |
| 1663 | OTM\_SPF\_40-59\_0\_0      | NA           | NA                | NA                            | NA                | Midwater       | NA                 | Midwater          |                       |
| 1664 | OTM\_SPF\_55\_69\_0        | NA           | NA                | NA                            | NA                | Midwater       | NA                 | Midwater          |                       |
| 1665 | OTM\_SPF\_60-89\_0\_0      | NA           | NA                | NA                            | NA                | Midwater       | NA                 | Midwater          |                       |
| 1666 | OTM\_SPF\_x\_x\_x          | NA           | NA                | NA                            | NA                | Midwater       | NA                 | Midwater          |                       |
| 1667 | OTS\_CRU\_0                | NA           | OT\_CRU           | OT\_CRU                       | OT\_CRU           | Otter          | Otter\_Trawl       | Otter             |                       |
| 1668 | OTT\_DEF\_\>=130\_0\_0     | NA           | OT\_DMF           | OT\_DMF                       | OT\_DMF           | Otter          | Otter\_Trawl\_Twin | Otter             |                       |
| 1669 | OTT\_DEF\_130-279\_0\_0    | NA           | OT\_DMF           | OT\_DMF                       | OT\_DMF           | Otter          | Otter\_Trawl\_Twin | Otter             |                       |
| 1670 | OTT\_MCD\_\<16\_0\_0       | NA           | OT\_MIX\_CRU\_DMF | OT\_MIX\_CRU\_DMF             | OT\_MIX\_CRU\_DMF | Otter          | Otter\_Trawl\_Twin | Otter             |                       |
| 1671 | OTT\_MCD\_\>=120\_1\_120   | NA           | OT\_MIX\_CRU\_DMF | OT\_MIX\_CRU\_DMF             | OT\_MIX\_CRU\_DMF | Otter          | Otter\_Trawl\_Twin | Otter             |                       |
| 1672 | PS\_DWS\_0                 | NA           | NA                | NA                            | NA                | Seine          | NA                 | Seine             |                       |
| 1673 | PS\_LPF\_0                 | NA           | NA                | NA                            | NA                | Seine          | NA                 | Seine             |                       |
| 1674 | PS\_SPF\_\<16\_0\_0        | NA           | NA                | NA                            | NA                | Seine          | NA                 | Seine             |                       |
| 1676 | PS\_SPF\_\>=120\_0\_0      | NA           | NA                | NA                            | NA                | Seine          | NA                 | Seine             |                       |
| 1677 | PS\_SPF\_70-99\_0\_0       | NA           | NA                | NA                            | NA                | Seine          | NA                 | Seine             |                       |
| 1678 | PS\_SPF\_UND\_0\_0         | NA           | NA                | NA                            | NA                | Seine          | NA                 | Seine             |                       |
| 1679 | PT\_DEF\_0                 | NA           | OT\_DMF           | OT\_DMF                       | OT\_DMF           | Otter          | Pair\_Trawl\_Seine | Otter             |                       |
| 1680 | PTB\_CRU\_\>=70\_0         | NA           | OT\_CRU           | OT\_CRU                       | OT\_CRU           | Otter          | Pair\_Trawl\_Seine | Otter             |                       |
| 1681 | PTB\_CRU\_16-31\_0\_0      | NA           | OT\_CRU           | OT\_CRU                       | OT\_CRU           | Otter          | Pair\_Trawl\_Seine | Otter             |                       |
| 1682 | PTB\_CRU\_32-69\_0\_0      | NA           | OT\_CRU           | OT\_CRU                       | OT\_CRU           | Otter          | Pair\_Trawl\_Seine | Otter             |                       |
| 1683 | PTB\_DEF\_\>=130\_0\_0     | NA           | OT\_DMF           | OT\_DMF                       | OT\_DMF           | Otter          | Pair\_Trawl\_Seine | Otter             |                       |
| 1684 | PTB\_DEF\_16-31\_2\_35     | NA           | OT\_DMF           | OT\_DMF                       | OT\_DMF           | Otter          | Pair\_Trawl\_Seine | Otter             |                       |
| 1685 | PTB\_DEF\_UND\_0\_0        | NA           | OT\_DMF           | OT\_DMF                       | OT\_DMF           | Otter          | Pair\_Trawl\_Seine | Otter             |                       |
| 1686 | PTB\_SPF\_\<16\_0\_0       | NA           | OT\_SPF           | OT\_SPF                       | OT\_SPF           | Otter          | Pair\_Trawl\_Seine | Otter             |                       |
| 1687 | PTM\_\_16-31\_0\_0         | NA           | NA                | NA                            | NA                | Midwater       | NA                 | Midwater          |                       |
| 1688 | PTM\_DEF\_16-31\_2\_35     | NA           | NA                | NA                            | NA                | Midwater       | NA                 | Midwater          |                       |
| 1689 | PTM\_LPF\_32\_69\_0        | NA           | NA                | NA                            | NA                | Midwater       | NA                 | Midwater          |                       |
| 1690 | PTM\_SPF\_x\_x\_x          | NA           | NA                | NA                            | NA                | Midwater       | NA                 | Midwater          |                       |
| 1691 | REC\_DEF\_0\_0\_0          | NA           | NA                | NA                            | NA                | NA             | NA                 | NA                |                       |
| 1692 | REC\_SPF\_0\_0\_0          | NA           | NA                | NA                            | NA                | NA             | NA                 | NA                |                       |
| 1693 | SDN\_DEF\_\<16\_0\_0       | NA           | SDN\_DMF          | SDN\_DMF                      | SDN\_DMF          | Seine          | Seine              | Seine             |                       |
| 1694 | SDN\_DEF\_\>=130\_0\_0     | NA           | SDN\_DMF          | SDN\_DMF                      | SDN\_DMF          | Seine          | Seine              | Seine             |                       |
| 1695 | SDN\_DEF\_90-104\_0\_0     | NA           | SDN\_DMF          | SDN\_DMF                      | SDN\_DMF          | Seine          | Seine              | Seine             |                       |
| 1696 | SDN\_FIF\_\>0\_0\_0        | NA           | SDN\_DMF          | SDN\_DMF                      | SDN\_DMF          | Seine          | Seine              | Seine             |                       |
| 1697 | SDN\_SPF\_32-104\_0\_0     | NA           | SDN\_DMF          | SDN\_DMF                      | SDN\_DMF          | Seine          | Seine              | Seine             |                       |
| 1698 | SND\_DEF\_0                | NA           | SDN\_DMF          | SDN\_DMF                      | SDN\_DMF          | Seine          | Seine              | Seine             |                       |
| 1699 | SND\_UNK\_0                | NA           | SDN\_DMF          | SDN\_DMF                      | SDN\_DMF          | Seine          | Seine              | Seine             |                       |
| 1700 | SPR\_SPF\_0                | NA           | SDN\_DMF          | SDN\_DMF                      | SDN\_DMF          | Seine          | Pair\_Trawl\_Seine | Seine             |                       |
| 1701 | SSC\_DWS\_0                | NA           | SSC\_DMF          | SSC\_DMF                      | SSC\_DMF          | Seine          | Seine              | Seine             |                       |
| 1703 | SSC\_FWS\_\>0\_0\_0        | NA           | SSC\_DMF          |                               |                   |                | Seine              | Seine             |                       |
| 1704 | SUM\_UND\_70-99\_0\_0      | NA           | NA                |                               |                   |                | NA                 | NA                |                       |
| 1705 | SUM\_UND\_90-119\_0\_0     | NA           | NA                |                               |                   |                | NA                 | NA                |                       |
| 1706 | SV\_CRU\_0                 | NA           | SDN\_DMF          |                               |                   |                | Seine              | Seine             |                       |
| 1707 | TB\_DWS\_0                 | NA           | OT\_DMF           |                               |                   |                | Otter\_Trawl       | Otter             |                       |
| 1708 | TB\_LPF\_0                 | NA           | OT\_SPF           |                               |                   |                | Otter\_Trawl       | Otter             |                       |
| 1709 | TBS\_CRU\_0\_0\_0          | NA           | OT\_CRU           |                               |                   |                | Otter\_Trawl       | Otter             |                       |
| 1710 | TBS\_CRU\_16\_31\_0        | NA           | OT\_CRU           |                               |                   |                | Otter\_Trawl       | Otter             |                       |
| 1711 | TBS\_CRU\_35\_0\_0         | NA           | OT\_CRU           |                               |                   |                | Otter\_Trawl       | Otter             |                       |
| 1712 | TM\_CRU\_0                 | NA           | NA                |                               |                   |                | NA                 | Midwater          |                       |
| 1713 | TM\_DWS\_0                 | NA           | NA                |                               |                   |                | NA                 | Midwater          |                       |
| 1714 | TMS\_SPF\_0                | NA           | NA                |                               |                   |                | NA                 | NA                |                       |
| 1715 | TX\_CRU\_0                 | NA           | NA                |                               |                   |                | NA                 | Other             |                       |
| 1716 | TX\_DEF\_0                 | NA           | NA                |                               |                   |                | NA                 | Other             |                       |
| 1717 | TX\_DWS\_0                 | NA           | NA                |                               |                   |                | NA                 | Other             |                       |
| 1718 | TX\_SPF\_0                 | NA           | NA                |                               |                   |                | NA                 | Other             |                       |
| 1719 | OTM\_SPF\_20\_0\_0         | NA           | NA                | NA                            | NA                | NA             | NA                 | Midwater          | ecomarNeedsUpdate     |
| 1720 | OTM\_SPF\_20\_0\_0         | NA           | NA                | NA                            | NA                | NA             | NA                 | Midwater          | ecomarNeedsUpdate     |
| 1721 | OTB\_DEF\_120\_0\_0        | NA           | OT\_DMF           | NA                            | OTB\_DEF          | NA             | NA                 | Otter             | ecomarNeedsUpdate     |
| 1722 | DRB\_MOL\_ALL\_0\_0        | NA           | DRB\_MOL          | NA                            | DRB\_MOL          | NA             | NA                 | Dredge            | ecomarNeedsUpdate     |
| 1723 | OTM\_DEF\_0\_SAN\_SAN      | NA           | NA                | NA                            | NA                | NA             | NA                 | Midwater          | ecomarNeedsUpdate2    |
| 1724 | OTB\_DEF\_0\_SAN\_SAN      | NA           | OT\_DMF           | NA                            | OTB\_DEF          | NA             | NA                 | Otter             | ecomarNeedsUpdate2    |
| 1725 | OTM\_0\_20\_0\_0           | NA           | NA                | NA                            | NA                | NA             | NA                 | Midwater          | ecomarNeedsUpdate2    |

# References

<div id="refs" class="references">

<div id="ref-reese03_csquares">

Rees, Tony. 2003. “C-Squares, a New Spatial Indexing System and Its
Applicability to the Description of Oceanographic Datasets.”
*Oceanography* 16 (1): 11–19. <https://doi.org/10.5670/oceanog.2003.52>.

</div>

</div>

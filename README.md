
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pkgTesting

<!-- badges: start -->

[![License: GPL
v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
<!-- badges: end -->

Author: Adam Coger

This package is to hold a Shiny app for making and viewing graphs about
COVID-19 in the United States. It does access the web, so it is of no
use while offline. The name “pkgTesting” came from trying to use this as
practice for “writing a shiny app as a package”.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
devtools::install_github("monkeychex3/pkgTesting")
```

The main launching function is called as:

``` r
pkgTesting::runApp()
```

## Walkthrough

1.  This app’s tabs are navigated between through the navigation bar. It
    is only a recommended order to proceed in, but once the data is
    loaded in and states are selected, everything will update
    dynamically to changes made. So returning to previous tabs is not
    discouraged.

![](D:\\Users\\monke\\OneDrive\\Desktop\\shinyApps\\pkgTesting\\navExample.jpg)

<br>

2.  Below is the first tab shown when launched. It is to select a date
    range to load in. On button press, it downloads the data and saves
    into into a data frame.

![](D:\\Users\\monke\\OneDrive\\Desktop\\shinyApps\\pkgTesting\\datesExample.jpg)

<br>

3.  After loading in the data over the supplied date range, this tab is
    to narrow down which states to look at. The summary statistics on
    the right are cumulative of the selected states, but this is just to
    verify that the checklist is functioning properly to the user.

![](D:\\Users\\monke\\OneDrive\\Desktop\\shinyApps\\pkgTesting\\statesExample.jpg)

<br>

4.  Here is the most interesting tab for curious users. It allows you to
    make new variables as combinations of previous ones. Users are
    allowed to chain together new variables as operations on other
    variables they have created as well.

![](D:\\Users\\monke\\OneDrive\\Desktop\\shinyApps\\pkgTesting\\editExample.jpg)
<br>

5.  This tab is for the visualization and comparison of variables
    (included or made).

![](D:\\Users\\monke\\OneDrive\\Desktop\\shinyApps\\pkgTesting\\graphExample.jpg)

<br>

## Reference

this package was built using COVID19::covid19() from
<https://covid19datahub.io>

Guidotti, E., Ardia, D., (2020).<br> COVID-19 Data Hub<br> Journal of
Open Source Software, 5(51):2376<br>
<https://doi.org/10.21105/joss.02376>

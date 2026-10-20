## R CMD check results

Checked using
* R version 4.5.3 (2026-03-11)
* using platform: x86_64-pc-linux-gnu
* running under: Ubuntu 24.04.4 LTS
* using options '--as-cran --run-donttest'

0 errors | 0 warnings | 1 note

* checking CRAN incoming feasibility ... NOTE
  New submission
  Package was archived on CRAN
  X-CRAN-Comment: Archived on 2024-07-16 for policy violation.
  On Internet access.

## Resubmission of an archived package

The package was archived because an example run with --run-donttest gave an
error when an ICES web service could not be reached. In this version:

* all functions that use internet resources now fail gracefully, with an
  informative message, if the resource is not available or returns an
  error: they return NULL rather than giving an error.
* the vocabulary checks (check_ecoregion() etc.) skip the check, with a
  message, and return NA if the vocabulary web service can not be reached.
* this was tested by running the functions against unreachable hosts and
  web services returning HTTP errors.

The ICES web services used by the package have also moved to a new address,
which has been updated throughout.

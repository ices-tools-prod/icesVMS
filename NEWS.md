<!-- NEWS.md is maintained by https://cynkra.github.io/fledge, do not edit -->
# icesVMS 1.1.6

* the web services have moved to https://data.ices.dk/vms/api, all functions
  now use this address (#4)
* functions now fail gracefully if a web service is not available: a message
  is given and NULL is returned. check_ecoregion(), check_stat_recs() and
  check_countries() skip the check, with a message, and return NA if the
  vocabulary can not be downloaded
* get_vms() and get_logbook() use the new GetVMSData and GetLogbookData web
  services, and country and year are now required. These services only
  filter by country and year, so the other arguments are applied after
  downloading, where possible. Arguments the services can not filter on are
  ignored, with a warning. The returned columns have new names, set by the
  web service (e.g. cSquare, gearCode, leMetLevel6)
* get_sar() is deprecated, as the web service no longer provides this data.
  It now gives a warning and returns NULL
* get_screening_details(), get_screening_messages() and screen_vms_file() use
  the new web service address
* bugfix: get_effort_map() always returned 2022 data, the year argument was
  ignored
* screen_vms_file() now handles files with a header row

# icesVMS 1.1.3

* Added examples to all exported functions
* Added functions to check vocabuluries: check_ecoregion(), check_stat_recs()
* Internal refactoring to simplify maintenence

# icesVMS 1.1.0

* Same as previous version.


# icesVMS 1.0.0.9022

* add sendEmail argument to screen_vms_file
* add function screen_vms_file(), remove datsu functions from exports
* add datacall arg to get_passive_footprint
* allow null for ecoregion in get_passive_footprint
* add datacall argument to wgfbit functions
* added get_wgfbit_data3, get_sar, and updated get_sar_map to return an sf object if the package is installed
* add datsu session functions
* add datacall year argument to get_vms()
* add function get_upload_summary()
* moved http requests to icesConnect package


# icesVMS 1.0.0.9013

* bugfix in get_logbook()


# icesVMS 1.0.0.9012

* add get_logbook() to download logbook data


# icesVMS 1.0.0.9011

* fixing bugs in url construction


# icesVMS 1.0.0.9010

*  bug fixes


# icesVMS 1.0.0.9009

*  improved  get and add arg - metier_level4 to get_passive_footprint()


# icesVMS 1.0.0.9008

* add get_passive_footprint()


# icesVMS 1.0.0.9007

* add nyears argument to get_sar_map()


# icesVMS 1.0.0.9006

* add get_wgfbit_data2()


# icesVMS 1.0.0.9005

* added function get_wgfbit_data1()
* add get_sar_map() function


# icesVMS 1.0.0.9004

* add get_fo_landings()


# icesVMS 1.0.0.9003

* add get_effort_map() function


# icesVMS 1.0.0.9002

* add get_fo_effort() fisheries overviews effort function
* add get_square() function


# icesVMS 1.0.0.9001

* write jwt.token to tempdir
* add filtering args to get_vms() function


# icesVMS 1.0.0.9000

- Internal changes only.

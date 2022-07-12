# tidyergo

## Overview

[Ergo](https://ergoplatform.org/en/) is a resilient blockchain platform for contractual money. In addition to [Bitcoin](https://bitcoin.org/en/)-like blockchain architecture Ergo provides advanced contractual capabilities based on eUTXO model, which are not possible in Bitcoin.

This R/Tidyverse package leverages the API endpoints from the official [Ergo Explorer](https://api.ergoplatform.com/api/v1/docs/), [ErgoWatch](https://ergo.watch/api/v0/docs), [ErgoDEX](https://api.ergodex.io/v1/docs/), and [ErgoPad](https://github.com/ergo-pad/ergopad-api/tree/dev/app/api/v1/routes) to retrieve blockchain data across the ecosystem.

## Installation
```r
# install.packages("devtools")
devtools::install_github("Eeysirhc/tidyergo")
```

## Usage

`library(tidyergo)` will load distinct API functions for each service.

* Ergo Explorer
* ErgoWatch
* ErgoDEX
* ErgoPad

## Examples

### ErgoWatch

#### Balance history of an address
```r
bearwhale <- "9hyDXH72HoNTiG2pvxFQwxAhWBU8CrbvwtJDtnYoa4jfpaSk1d3"
addressesBalanceHistory(bearwhale)
```

#### Current P2PK address count
```r
# addresses holding >= 1M+ $MiGoreng
migoreng <- "0779ec04f2fae64e87418a1ad917639d4668f78484f45df962b0dec14a2591d2"
p2pkCount(bal_ge = 1000000, token_id = migoreng)
```

#### Token supply: emitted, circulating, and burned
```r
migoreng <- "0779ec04f2fae64e87418a1ad917639d4668f78484f45df962b0dec14a2591d2"
tokensSupply(migoreng)
```

### ErgoDEX

#### Retrieve AMM platform statistics
```r
ergodexPlatformStats()
```

#### Retrieve statistics for all liquidity pools
```r
ergodexAllPoolStats()
```


## Packages

Installing this package also installs a selection of other R packages as dependencies. 

* [httr](https://github.com/r-lib/httr), web APIs
* [jsonlite](https://github.com/jeroen/jsonlite), JSON handling
* [dplyr](https://dplyr.tidyverse.org/), data manipulation
* [tidyr](https://tidyr.tidyverse.org/), data tidying
* [purrr](https://purrr.tidyverse.org/), functional programming


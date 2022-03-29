# tidyergo

## Overview
[Ergo](https://ergoplatform.org/en/) blockchain statistics with R/Tidyverse leveraging the API endpoints from [Explorer](https://api.ergoplatform.com/api/v1/docs/), [ErgoWatch](https://ergo.watch/api/v0/docs), and [ErgoDEX](https://api.ergodex.io/v1/docs/).


## Installation
```r
# install.packages("devtools")
devtools::install_github("Eeysirhc/tidyergo")
```


## Usage

### Current ERG balance for an address
```r
bearwhale <- "9hyDXH72HoNTiG2pvxFQwxAhWBU8CrbvwtJDtnYoa4jfpaSk1d3"
addressesBalance(bearwhale)
```

### Balance history of an address
```r
bearwhale <- "9hyDXH72HoNTiG2pvxFQwxAhWBU8CrbvwtJDtnYoa4jfpaSk1d3"
addressesBalanceHistory(bearwhale)
```

### Current P2PK address count
```r
# addresses holding >= 1M+ $MiGoreng
migoreng <- "0779ec04f2fae64e87418a1ad917639d4668f78484f45df962b0dec14a2591d2"
p2pkCount(bal_ge = 1000000, token_id = migoreng)
```


### Token supply: emitted, circulating, and burned
```r
migoreng <- "0779ec04f2fae64e87418a1ad917639d4668f78484f45df962b0dec14a2591d2"
tokensSupply(migoreng)
```

## Roadmap

- [] Develop function parity with Ergo Explorer
- [x] Develop function parity with ErgoWatch
- [] Develop function parity with ErgoDEX



## Changelog

- v0.1.0: [unreleased]








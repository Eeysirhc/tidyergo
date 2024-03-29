##########################################
################ ErgoWatch ###############
##########################################



##############################
# ADDRESSES: address specific data
##############################

#####
##### ADDRESS BALANCE
##### https://ergo.watch/api/v0/docs#/addresses/address_balance_addresses__address__balance_get
#####

#' Address Balance
#'
#' Current $ERG or token balance of an address.
#'
#' @param address Required: the P2PK address.
#' @param token_id Token ID.
#'
#' @return A tibble with the requested address and balance.
#' @import httr
#' @import dplyr
#' @import jsonlite
#' @export
#'
#' @examples
#' bearwhale <- "9hyDXH72HoNTiG2pvxFQwxAhWBU8CrbvwtJDtnYoa4jfpaSk1d3"
#' ew_addressesBalance(bearwhale)
#'
#' bearwhale <- "9hyDXH72HoNTiG2pvxFQwxAhWBU8CrbvwtJDtnYoa4jfpaSk1d3"
#' erdoge <- "3a7eb9b71a231b8df485c4d8b081726eda9876d2ce2d59bab5e5874c6cbba220"
#' ew_addressesBalance(bearwhale, token_id = erdoge)

ew_addressesBalance <- function(address, token_id = NULL){

  url_request <- paste0("https://ergo.watch/api/v0/addresses/", address, "/balance",
                        ifelse(!is.null(token_id),
                               paste0("?token_id=", token_id), ""))

  df <- GET(url_request) %>%
    content(as = "text", encoding = "UTF-8") %>%
    jsonlite::fromJSON(flatten = TRUE) %>%
    as_tibble() %>%
    mutate(address = address)

  return(df)
}

#####
##### ADDRESS BALANCE AT HEIGHT
##### https://ergo.watch/api/v0/docs#/addresses/address_balance_at_height_addresses__address__balance_at_height__height__get
#####

#' Address Balance At Height
#'
#' $ERG or token balancee of an address at a specific block height.
#'
#' @param address Required: the P2PK address.
#' @param height Required: block height.
#' @param token_id Token ID.
#'
#' @return A tibble with requested address, specific block height, and balance.
#' @import httr
#' @import dplyr
#' @import jsonlite
#' @export
#'
#' @examples
#' bearwhale <- "9hyDXH72HoNTiG2pvxFQwxAhWBU8CrbvwtJDtnYoa4jfpaSk1d3"
#' ew_addressesBalanceHeight(bearwhale, height = 700000)
#'
#' bearwhale <- "9hyDXH72HoNTiG2pvxFQwxAhWBU8CrbvwtJDtnYoa4jfpaSk1d3"
#' erdoge <- "3a7eb9b71a231b8df485c4d8b081726eda9876d2ce2d59bab5e5874c6cbba220"
#' ew_addressesBalanceHeight(bearwhale, height = 700000, token_id = erdoge)

ew_addressesBalanceHeight <- function(address, height, token_id = NULL){

  url_request <- paste0("https://ergo.watch/api/v0/addresses/", address, "/balance/at/height/", height,
                        ifelse(!is.null(token_id),
                               paste0("?token_id=", token_id), ""))

  df <- GET(url_request) %>%
    content(as = "text", encoding = "UTF-8") %>%
    jsonlite::fromJSON(flatten = TRUE) %>%
    as_tibble() %>%
    mutate(address = address,
           height = height)

  return(df)
}

#####
##### ADDRESS BALANCE AT TIMESTAMP
##### https://ergo.watch/api/v0/docs#/addresses/address_balance_at_timestamp_addresses__address__balance_at_timestamp__timestamp__get
#####

#' Address Balance At Timestamp
#'
#' $ERG or token balance of an address at a specific timestamp.
#'
#' @param address Required: the P2PK address.
#' @param timestamp Required: timestamp.
#' @param token_id Token ID.
#'
#' @return A tibble with the requested address, specific timestamp, and balance.
#' @import httr
#' @import dplyr
#' @import jsonlite
#' @export
#'
#' @examples
#' bearwhale <- "9hyDXH72HoNTiG2pvxFQwxAhWBU8CrbvwtJDtnYoa4jfpaSk1d3"
#' ew_addressesBalanceTimestamp(bearwhale, timestamp = 1614307368646)
#'
#' bearwhale <- "9hyDXH72HoNTiG2pvxFQwxAhWBU8CrbvwtJDtnYoa4jfpaSk1d3"
#' erdoge <- "3a7eb9b71a231b8df485c4d8b081726eda9876d2ce2d59bab5e5874c6cbba220"
#' ew_addressesBalanceTimestamp(bearwhale, timestamp = 1614307368646, token_id = erdoge)

ew_addressesBalanceTimestamp <- function(address, timestamp, token_id = NULL){

  url_request <- paste0("https://ergo.watch/api/v0/addresses/", address, "/balance/at/timestamp/", timestamp,
                        ifelse(!is.null(token_id),
                               paste0("?token_id=", token_id), ""))

  df <- GET(url_request) %>%
    content(as = "text", encoding = "UTF-8") %>%
    jsonlite::fromJSON(flatten = TRUE) %>%
    as_tibble() %>%
    mutate(timestamp = timestamp,
           datetime = as.POSIXct(timestamp / 1000, origin = "1970-01-01"),
           address = address)

  return(df)
}

#####
##### ADDRESS BALANCE HISTORY
##### https://ergo.watch/api/v0/docs#/addresses/address_balance_history_addresses__address__balance_history_get
#####

#' Address Balance History
#'
#' $ERG or token balance history of an address.
#'
#' Sorts by oldest first with a limit of 10,000 rows.
#'
#' @param address Required: the P2PK address.
#' @param token_id Token ID.
#'
#' @return A tibble with requested address, block height, timestamp/datetime, and balance.
#' @import httr
#' @import dplyr
#' @import jsonlite
#' @export
#'
#' @examples
#' bearwhale <- "9hyDXH72HoNTiG2pvxFQwxAhWBU8CrbvwtJDtnYoa4jfpaSk1d3"
#' ew_addressesBalanceHistory(bearwhale)
#'
#' bearwhale <- "9hyDXH72HoNTiG2pvxFQwxAhWBU8CrbvwtJDtnYoa4jfpaSk1d3"
#' erdoge <- "3a7eb9b71a231b8df485c4d8b081726eda9876d2ce2d59bab5e5874c6cbba220"
#' ew_addressesBalanceHistory(bearwhale, token_id = erdoge)

ew_addressesBalanceHistory <- function(address, token_id = NULL){

  url_request <- paste0("https://ergo.watch/api/v0/addresses/", address, "/balance/history?timestamps=true&flat=true&limit=10000&offset=0&desc=false",
                        ifelse(!is.null(token_id),
                               paste0("&token_id=", token_id), ""))

  df <- GET(url_request) %>%
    content(as = "text", encoding = "UTF-8") %>%
    jsonlite::fromJSON(flatten = TRUE) %>%
    as_tibble() %>%
    mutate(datetime = as.POSIXct(timestamps / 1000, origin = "1970-01-01"),
           address = address)

  return(df)
}

#####
##### ADDRESS TAGS
##### https://ergo.watch/api/v0/docs#/addresses/address_balance_history_addresses__address__balance_history_get
#####

#' Address Tags
#'
#' Returns all tags associated for a given address (e.g. exchange address, known contract, etc.)
#'
#' @param address Required: the P2PK or P2S address.
#'
#' @return A tibble with the tags associated to a given address.
#' @import httr
#' @import dplyr
#' @import jsonlite
#' @export
#'
#' @examples
#' coinex <- "9fPiW45mZwoTxSwTLLXaZcdekqi72emebENmScyTGsjryzrntUe"
#' ew_addressesTags(coinex)

ew_addressesTags <- function(address){

  url_request <- paste0("https://ergo.watch/api/v0/addresses/", address, "/tags")

  df <- GET(url_request) %>%
    content(as = "text", encoding = "UTF-8") %>%
    jsonlite::fromJSON(flatten = TRUE) %>%
    as_tibble() %>%
    mutate(address = address)

  return(df)
}



##############################
# P2PK: P2PK address statistics
##############################

#####
##### NUMBER OF P2PK ADDRESSES
##### https://ergo.watch/api/v0/docs#/p2pk/Number_of_P2PK_addresses_p2pk_count_get
#####

#' Number of P2PK Addresses
#'
#' Current P2PK addresses count.
#'
#' @param bal_ge Only count contract addresses with balance greater or equal to bal_ge. Default at 0.
#' @param bal_lt Only count contract addresses with balance lower than bal_lt.
#' @param token_id Token ID.
#'
#' @return A tibble with total count of P2PK addresses.
#' @import httr
#' @import dplyr
#' @import jsonlite
#' @export
#'
#' @examples
#' ew_p2pkCount()
#'
#' ew_p2pkCount(bal_ge = 1000000)
#'
#' migoreng <- "0779ec04f2fae64e87418a1ad917639d4668f78484f45df962b0dec14a2591d2"
#' ew_p2pkCount(bal_ge = 1e9, token_id = migoreng)

ew_p2pkCount <- function(bal_ge = 0, bal_lt = NULL, token_id = NULL){

  url_request <- paste0("https://ergo.watch/api/v0/p2pk/count?bal_ge=", format(bal_ge, scientific = FALSE),
                        ifelse(!is.null(bal_lt),
                               paste0("&bal_lt=", format(bal_lt, scientific = FALSE)), ""),
                        ifelse(!is.null(token_id),
                               paste0("&token_id=", token_id), ""))

  df <- GET(url_request) %>%
    content(as = "text", encoding = "UTF-8") %>%
    jsonlite::fromJSON(flatten = TRUE) %>%
    as_tibble() %>%
    dplyr::rename(total_addresses = value)

  return(df)
}



##############################
# CONTRACTS: P2S & P2SH address statistics
##############################

#####
##### GET CONTRACT ADDRESS COUNT
##### https://ergo.watch/api/v0/docs#/contracts/get_contract_address_count_contracts_count_get
#####

#' Get Contract Address Count
#'
#' Current contract addresses count.
#'
#' @param bal_ge Only count contract addresses with balance greater or equal to bal_ge. Default at 0.
#' @param bal_lt Only count contract addresses with balance lower than bal_lt.
#' @param token_id Token ID.
#'
#' @return A tibble with total count of contract addresses.
#' @import httr
#' @import dplyr
#' @import jsonlite
#' @export
#'
#' @examples
#' ew_contractsCount()

ew_contractsCount <- function(bal_ge = 0, bal_lt = NULL, token_id = NULL){

  url_request <- paste0("https://ergo.watch/api/v0/contracts/count?bal_ge=", format(bal_ge, scientific = FALSE),
                        ifelse(!is.null(bal_lt),
                               paste0("&bal_lt=", format(bal_lt, scientific = FALSE)), ""),
                        ifelse(!is.null(token_id),
                               paste0("&token_id=", token_id), ""))

  df <- GET(url_request) %>%
    content(as = "text", encoding = "UTF-8") %>%
    jsonlite::fromJSON(flatten = TRUE) %>%
    as_tibble() %>%
    dplyr::rename(total_addresses = value)

  return(df)
}

#####
##### SUPPLY IN CONTRACTS
##### https://ergo.watch/api/v0/docs#/contracts/supply_in_contracts_contracts_supply_get
#####

#' Supply In Contracts
#'
#' Supply in contracts.
#'
#' @param token_id Token ID.
#'
#' @return A tibble with total value supplied in contracts.
#' @import httr
#' @import dplyr
#' @import jsonlite
#' @export
#'
#' @examples
#' ew_contractsSupply()
#'
#' migoreng <- "0779ec04f2fae64e87418a1ad917639d4668f78484f45df962b0dec14a2591d2"
#' ew_contractsSupply(migoreng)

ew_contractsSupply <- function(token_id = NULL){

  url_request <- paste0("https://ergo.watch/api/v0/contracts/supply",
                        ifelse(!is.null(token_id),
                               paste0("?token_id=", token_id), ""))

  df <- GET(url_request) %>%
    content(as = "text", encoding = "UTF-8") %>%
    jsonlite::fromJSON(flatten = TRUE) %>%
    as_tibble()

  return(df)
}



##############################
# EXCHANGES: individual exchange data
##############################

#####
##### EXCHANGES
##### https://ergo.watch/api/v0/docs#/exchanges/list_tracked_exchanges_exchanges_get
##### 

#' List Tracked Exchanges
#'
#' List ID's of tracked exchanges.
#'
#' @return A tibble with the ID's for exchanges being tracked on ErgoWatch.
#' @import httr
#' @import dplyr
#' @import jsonlite
#' @export
#'
#' @examples
#' ew_exchanges()

ew_exchanges <- function(){

  url_request <- paste0("https://ergo.watch/api/v0/exchanges")

  df <- GET(url_request) %>%
    content(as = "text", encoding = "UTF-8") %>%
    jsonlite::fromJSON(flatten = TRUE) %>%
    as_tibble()

  return(df)
}

#####
##### EXCHANGES SUPPLY
##### https://ergo.watch/api/v0/docs#/exchanges/exchange_supply_history_exchanges__exchange__supply_get
##### 

#' Exchange Supply History
#'
#' Supply on known main and deposit addresses.
#'
#' @param exchange Required: Exchange ID (use ew_exchanges() function).
#' @param since Height or timestamp of first record.
#' @param limit Maximum of 10,000.
#'
#' @return A tibble with the ID's for exchanges being tracked on ErgoWatch.
#' @import httr
#' @import dplyr
#' @import jsonlite
#' @export
#'
#' @examples
#' ew_exchangesSupply(exchange = "kucoin")
#' 
#' Note: the "since" and "limit" parameters MUST be used together.
#' ew_exchangesSupply(exchange = "gate", since = 1, limit = 100)

ew_exchangesSupply <- function(exchange, since = NULL, limit = NULL){

  url_request <- paste0("https://ergo.watch/api/v0/exchanges/", exchange, "/supply",
                        ifelse(!is.null(since),
                               paste0("?since=", since), ""),
                        ifelse(!is.null(limit),
                               paste0("&limit=", limit), ""))

  df <- GET(url_request) %>%
    content(as = "text", encoding = "UTF-8") %>%
    jsonlite::fromJSON(flatten = TRUE) %>%
    as_tibble()

  return(df)
}



##############################
# LISTS: rich lists, etc.
##############################

#####
##### RICH LIST
##### https://ergo.watch/api/v0/docs#/lists/rich_list_lists_addresses_by_balance_get
##### 

#' Rich List
#'
#' Get addresses with largest balance.
#'
#' @param token_id Token ID.
#' @param limit Default value of 100 with maximum of 10,000.
#'
#' @return A tibble with the top addresses and their respective values for holding $ERG or a given token ID.
#' @import httr
#' @import dplyr
#' @import jsonlite
#' @export
#'
#' @examples
#' ew_richlistsBalance()
#'
#' comet <- "0cd8c9f416e5b1ca9f986a7f10a84191dfb85941619e49e53c0dc30ebf83324b"
#' ew_richlistsBalance(comet)

ew_richlistsBalance <- function(token_id = NULL, limit = NULL){

  url_request <- paste0("https://ergo.watch/api/v0/lists/addresses/by/balance",
                        ifelse(!is.null(limit),
                               paste0("?limit=", limit), "?limit=100"),
                        ifelse(!is.null(token_id),
                               paste0("&token_id=", token_id), ""))

  df <- GET(url_request) %>%
    content(as = "text", encoding = "UTF-8") %>%
    jsonlite::fromJSON(flatten = TRUE) %>%
    as_tibble()

  return(df)
}


########## IN PROGRESS ##########
##############################
# METRICS: metrics over time
##############################

#####
##### SUPPLY ACROSS EXCHANGES
##### https://ergo.watch/api/v0/docs#/metrics/supply_across_all_tracked_exchanges_metrics_exchanges_supply_get
#####

#' Supply Across All Tracked Exchanges
#'
#' Returns total supply and supply on deposit addresses. Supply on main addresses is total - deposit.
#'
#' @param fr placeholder
#' @param to placeholder
#' @param r placeholder
#'
#' @return A tibble that does this...
#' @import httr
#' @import dplyr
#' @import jsonlite
#' @export
#'
#' @examples
#' ew_metricsExchangesSupply()

ew_metricsExchangesSupply <- function(token_id = NULL, limit = NULL){

  url_request <- paste0("https://ergo.watch/api/v0/lists/addresses/by/balance",
                        ifelse(!is.null(limit),
                               paste0("?limit=", limit), "?limit=100"),
                        ifelse(!is.null(token_id),
                               paste0("&token_id=", token_id), ""))

  df <- GET(url_request) %>%
    content(as = "text", encoding = "UTF-8") %>%
    jsonlite::fromJSON(flatten = TRUE) %>%
    as_tibble()

  return(df)
}

#####
##### UTXO COUNTS
##### https://ergo.watch/api/v0/docs#/metrics/counts_metrics_utxos_get
#####

#' Number of UTxO's
#'
#' UTxO counts.
#'
#' @param fr placeholder
#' @param to placeholder
#' @param r placeholder
#'
#' @return A tibble that does that...
#' @import httr
#' @import dplyr
#' @import jsonlite
#' @export
#'
#' @examples
#' ew_metricsUtxos()

ew_metricsUtxos <- function(token_id = NULL, limit = NULL){

  url_request <- paste0("https://ergo.watch/api/v0/lists/addresses/by/balance",
                        ifelse(!is.null(limit),
                               paste0("?limit=", limit), "?limit=100"),
                        ifelse(!is.null(token_id),
                               paste0("&token_id=", token_id), ""))

  df <- GET(url_request) %>%
    content(as = "text", encoding = "UTF-8") %>%
    jsonlite::fromJSON(flatten = TRUE) %>%
    as_tibble()

  return(df)
}
########## END IN PROGRESS ##########


##############################
# TOKENS: token specific data
##############################

#####
##### TOKEN DETAILS
##### https://ergo.watch/api/v0/docs#/tokens/token_details_tokens__token_id__get
#####

#' Token Details
#'
#' Details for a specific token.
#'
#' @param token_id Required: Token ID.
#'
#' @return A tibble with token detail information: name, description, emission amount, decimals, and standard.
#' @import httr
#' @import dplyr
#' @import jsonlite
#' @export
#'
#' @examples
#' migoreng <- "0779ec04f2fae64e87418a1ad917639d4668f78484f45df962b0dec14a2591d2"
#' ew_tokensDetail(migoreng)

ew_tokensDetail <- function(token_id){

  url_request <- paste0("https://ergo.watch/api/v0/tokens/", token_id)

  df <- GET(url_request) %>%
    content(as = "text", encoding = "UTF-8") %>%
    jsonlite::fromJSON(flatten = TRUE) %>%
    as_tibble()

  return(df)
}

#####
##### TOKEN SUPPLY
##### https://ergo.watch/api/v0/docs#/tokens/token_supply_tokens__token_id__supply_get
#####

#' Token Supply
#'
#' Emitted, circulating (P2PK addresses vs contracts), and burned token supply.
#'
#' @param token_id Required: Token ID.
#'
#' @return A tibble with token supply breakdown: emitted, in P2PK addresses, in contracts, and burned. Emitted is sum of other three.
#' @import httr
#' @import dplyr
#' @import jsonlite
#' @export
#'
#' @examples
#' migoreng <- "0779ec04f2fae64e87418a1ad917639d4668f78484f45df962b0dec14a2591d2"
#' ew_tokensSupply(migoreng)

ew_tokensSupply <- function(token_id){

  url_request <- paste0("https://ergo.watch/api/v0/tokens/", token_id, "/supply")

  df <- GET(url_request) %>%
    content(as = "text", encoding = "UTF-8") %>%
    jsonlite::fromJSON(flatten = TRUE) %>%
    as_tibble()

  return(df)
}



##############################
# MISC: miscellaneous functions 
##############################

#####
##### P2PK ADDRESS RANK
##### https://ergo.watch/api/v0/docs#/misc/P2PK_address_rank_ranking__p2pk_address__get
#####

#' P2PK Address Rank
#'
#' Get the rank of a P2PK address by current balance.
#'
#' @param address Required: the P2PK address.
#'
#' @return A tibble with the target address, rank, balance, and the next/previous addresses as well.
#' @import httr
#' @import dplyr
#' @import jsonlite
#' @import purrr
#' @import tidyr
#' @export
#'
#' @examples
#' bearwhale <- "9hyDXH72HoNTiG2pvxFQwxAhWBU8CrbvwtJDtnYoa4jfpaSk1d3"
#' ew_p2pkRanking(bearwhale)

ew_p2pkRanking <- function(address){

  url_request <- paste0("https://ergo.watch/api/v0/ranking/", address)

  df <- GET(url_request) %>%
    content(as = "text", encoding = "UTF-8") %>%
    jsonlite::fromJSON(flatten = TRUE) %>%
    as_tibble() %>%
    purrr::map(unlist) %>%
    as_tibble() %>%
    mutate(category = row_number()) %>%
    tidyr::pivot_longer(1:3) %>%
    mutate(category = case_when(category == 1 ~ "rank",
                                category == 2 ~ "address",
                                category == 3 ~ "balance")) %>%
    select(segment = name, category, value) %>%
    arrange(segment) %>%
    tidyr::pivot_wider(id_cols = segment, names_from = 2)


  return(df)
}




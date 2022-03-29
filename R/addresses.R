# Address specific data

library(httr)
library(dplyr)
library(jsonlite)

options(digits = 10,
        scipen = 100)


# https://ergo.watch/api/v0/docs#/addresses/address_balance_addresses__address__balance_get
#' Address Balance
#'
#' Current $ERG or token balance of an address.
#'
#' @param address Required: the P2PK address.
#' @param token_id Token ID.
#'
#' @return
#' @export
#'
#' @examples

addressesBalance <- function(address, token_id = NULL){

  url_request <- paste0("https://ergo.watch/api/v0/addresses/", address, "/balance",
                        ifelse(!is.null(token_id),
                               paste0("?token_id=", token_id), ""))

  df <- GET(url_request) %>%
    content(as = "text", encoding = "UTF-8") %>%
    fromJSON(flatten = TRUE) %>%
    as_tibble() %>%
    mutate(address = address)

  return(df)
}



# https://ergo.watch/api/v0/docs#/addresses/address_balance_at_height_addresses__address__balance_at_height__height__get
#' Address Balance At Height
#'
#' $ERG or token balancee of an address at a specific block height.
#'
#' @param address Required: the P2PK address.
#' @param height Required: block height.
#' @param token_id Token ID.
#'
#' @return
#' @export
#'
#' @examples

addressesBalanceHeight <- function(address, height, token_id = NULL){

  url_request <- paste0("https://ergo.watch/api/v0/addresses/", address, "/balance/at/height/", height,
                        ifelse(!is.null(token_id),
                               paste0("?token_id=", token_id), ""))

  df <- GET(url_request) %>%
    content(as = "text", encoding = "UTF-8") %>%
    fromJSON(flatten = TRUE) %>%
    as_tibble() %>%
    mutate(address = address,
           height = height)

  return(df)
}



# https://ergo.watch/api/v0/docs#/addresses/address_balance_at_timestamp_addresses__address__balance_at_timestamp__timestamp__get
#' Address Balance At Timestamp
#'
#' $ERG or token balance of an address at a specific timestamp.
#'
#' @param address Required: the P2PK address.
#' @param timestamp Required: timestamp.
#' @param token_id Token ID.
#'
#' @return
#' @export
#'
#' @examples

addressesBalanceTimestamp <- function(address, timestamp, token_id = NULL){

  url_request <- paste0("https://ergo.watch/api/v0/addresses/", address, "/balance/at/timestamp/", timestamp,
                        ifelse(!is.null(token_id),
                               paste0("?token_id=", token_id), ""))

  df <- GET(url_request) %>%
    content(as = "text", encoding = "UTF-8") %>%
    fromJSON(flatten = TRUE) %>%
    as_tibble() %>%
    mutate(timestamp = timestamp,
           datetime = as.POSIXct(timestamp / 1000, origin = "1970-01-01"),
           address = address)

  return(df)
}




# https://ergo.watch/api/v0/docs#/addresses/address_balance_history_addresses__address__balance_history_get
#' Address Balance History
#'
#' $ERG or token balance history of an address.
#'
#' Sorts by oldest first with a limit of 10,000 rows.
#'
#' @param address Required: the P2PK address.
#' @param token_id Token ID.
#'
#' @return
#' @export
#'
#' @examples

addressesBalanceHistory <- function(address, token_id = NULL){

  url_request <- paste0("https://ergo.watch/api/v0/addresses/", address, "/balance/history?timestamps=true&flat=true&limit=10000&offset=0&desc=false",
                        ifelse(!is.null(token_id),
                               paste0("&token_id=", token_id), ""))

  df <- GET(url_request) %>%
    content(as = "text", encoding = "UTF-8") %>%
    fromJSON(flatten = TRUE) %>%
    as_tibble() %>%
    mutate(datetime = as.POSIXct(timestamps / 1000, origin = "1970-01-01"),
           address = address)

  return(df)
}




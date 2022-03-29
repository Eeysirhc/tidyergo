# Miscellaneous functions

library(httr)
library(dplyr)
library(jsonlite)

options(digits = 10,
        scipen = 100)

# https://ergo.watch/api/v0/docs#/misc/P2PK_address_rank_ranking__p2pk_address__get
#' P2PK Address Rank
#'
#' Get the rank of a P2PK address by current balance.
#'
#' Includes next and previous addresses as well.
#'
#' @param address Required: the P2PK address.
#'
#' @return work in progress.
#' @export
#'
#' @examples

p2pkRanking <- function(address){

  url_request <- paste0("https://ergo.watch/api/v0/ranking/", address)

  df <- GET(url_request) %>%
    content(as = "text", encoding = "UTF-8") %>%
    fromJSON(flatten = TRUE)

  return(df)
}


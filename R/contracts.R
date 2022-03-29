# P2S & P2SH address statistics

library(httr)
library(dplyr)
library(jsonlite)

options(digits = 10,
        scipen = 100)

# https://ergo.watch/api/v0/docs#/contracts/get_contract_address_count_contracts_count_get
#' Get Contract Address Count
#'
#' Current contract addresses count.
#'
#' @param bal_ge Only count contract addresses with balance greater or equal to bal_ge. Default at 0.
#' @param bal_lt Only count contract addresses with balance lower than bal_lt.
#' @param token_id Token ID.
#'
#' @return A tibble with total count of contract addresses.
#' @export
#'
#' @examples

contractsCount <- function(bal_ge = 0, bal_lt = NULL, token_id = NULL){

  url_request <- paste0("https://ergo.watch/api/v0/contracts/count?bal_ge=", bal_ge,
                        ifelse(!is.null(bal_lt),
                               paste0("&bal_lt=", bal_lt), ""),
                        ifelse(!is.null(token_id),
                               paste0("&token_id=", token_id), ""))

  df <- GET(url_request) %>%
    content(as = "text", encoding = "UTF-8") %>%
    fromJSON(flatten = TRUE) %>%
    as_tibble() %>%
    rename(total_addresses = value)

  return(df)
}

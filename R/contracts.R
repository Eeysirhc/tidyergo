#' P2S & P2SH address statistics

library(httr)
library(dplyr)
library(jsonlite)

options(digits = 10,
        scipen = 100)

### Get Contract Address Count ###
# https://ergo.watch/api/v0/docs#/contracts/get_contract_address_count_contracts_count_get

contractsCount <- function(bal_ge = 0, bal_lt = NULL, token_id = NULL){

  url_request <- paste0("https://ergo.watch/api/v0/contracts/count?bal_ge=", bal_ge,
                        ifelse(!is.null(bal_lt),
                               paste0("&bal_lt=", bal_lt), ""),
                        ifelse(!is.null(token_id),
                               paste0("&token_id=", token_id), ""))

  df <- GET(url_request) %>%
    content(as = "text", encoding = "UTF-8") %>%
    fromJSON(flatten = TRUE) %>%
    as_tibble()

  return(df)
}





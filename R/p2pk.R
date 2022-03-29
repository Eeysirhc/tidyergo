#' P2PK address statistics

library(httr)
library(dplyr)
library(jsonlite)

options(digits = 10,
        scipen = 100)

### Number of P2PK Addresses ###
# https://ergo.watch/api/v0/docs#/p2pk/Number_of_P2PK_addresses_p2pk_count_get

p2pkCount <- function(bal_ge = 0, bal_lt = NULL, token_id = NULL){

  url_request <- paste0("https://ergo.watch/api/v0/p2pk/count?bal_ge=", bal_ge,
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


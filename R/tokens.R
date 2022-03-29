# Token functions

library(httr)
library(dplyr)
library(jsonlite)

options(digits = 10,
        scipen = 100)

# https://ergo.watch/api/v0/docs#/tokens/token_supply_tokens__token_id__supply_get
#' Token Supply
#'
#' Emitted, circulating, and burned token supply.
#'
#' @param token_id Token ID.
#'
#' @return A tibble with total, circulating, and burned supply for a specific token.
#' @export
#'
#' @examples
#' migoreng <- "0779ec04f2fae64e87418a1ad917639d4668f78484f45df962b0dec14a2591d2"
#' tokensSupply(migoreng)

tokensSupply <- function(token_id){

  url_request <- paste0("https://ergo.watch/api/v0/tokens/", token_id, "/supply")

  df <- GET(url_request) %>%
    content(as = "text", encoding = "UTF-8") %>%
    fromJSON(flatten = TRUE) %>%
    as_tibble()

  return(df)
}






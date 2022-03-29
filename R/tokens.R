library(httr)
library(dplyr)
library(jsonlite)

options(digits = 10,
        scipen = 100)

### Token Supply
# https://ergo.watch/api/v0/docs#/tokens/token_supply_tokens__token_id__supply_get



#' Token Supply
#'
#' Emitted, circulating, and burned token supply.
#'
#' @param token_id The token ID on the Ergo blockchain.
#'
#' @return A tibble with total, circulating, and burned supply for a specific token.
#' @export
#'
#' @examples
#'

tokensSupply <- function(token_id){

  url_request <- paste0("https://ergo.watch/api/v0/tokens/", token_id, "/supply")

  df <- GET(url_request) %>%
    content(as = "text", encoding = "UTF-8") %>%
    fromJSON(flatten = TRUE) %>%
    as_tibble()

  return(df)
}





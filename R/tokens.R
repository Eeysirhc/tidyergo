# Token functions

# https://ergo.watch/api/v0/docs#/tokens/token_details_tokens__token_id__get
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
#' tokensDetail(migoreng)

tokensDetail <- function(token_id){

  url_request <- paste0("https://ergo.watch/api/v0/tokens/", token_id)

  df <- GET(url_request) %>%
    content(as = "text", encoding = "UTF-8") %>%
    jsonlite::fromJSON(flatten = TRUE) %>%
    as_tibble()

  return(df)
}


# https://ergo.watch/api/v0/docs#/tokens/token_supply_tokens__token_id__supply_get
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
#' tokensSupply(migoreng)

tokensSupply <- function(token_id){

  url_request <- paste0("https://ergo.watch/api/v0/tokens/", token_id, "/supply")

  df <- GET(url_request) %>%
    content(as = "text", encoding = "UTF-8") %>%
    jsonlite::fromJSON(flatten = TRUE) %>%
    as_tibble()

  return(df)
}





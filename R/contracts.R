# P2S & P2SH address statistics

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
#' @import httr
#' @import dplyr
#' @import jsonlite
#' @export
#'
#' @examples
#' contractsCount()

contractsCount <- function(bal_ge = 0, bal_lt = NULL, token_id = NULL){

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



# https://ergo.watch/api/v0/docs#/contracts/supply_in_contracts_contracts_supply_get
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
#' contractsSupply()
#'
#' migoreng <- "0779ec04f2fae64e87418a1ad917639d4668f78484f45df962b0dec14a2591d2"
#' contractsSupply(migoreng)

contractsSupply <- function(token_id = NULL){

  url_request <- paste0("https://ergo.watch/api/v0/contracts/supply",
                        ifelse(!is.null(token_id),
                               paste0("?token_id=", token_id), ""))

  df <- GET(url_request) %>%
    content(as = "text", encoding = "UTF-8") %>%
    jsonlite::fromJSON(flatten = TRUE) %>%
    as_tibble()

  return(df)
}




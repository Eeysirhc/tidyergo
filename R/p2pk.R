# P2PK address statistics

#library(httr)
#library(dplyr)
#library(jsonlite)

options(digits = 10,
        scipen = 100)


# https://ergo.watch/api/v0/docs#/p2pk/Number_of_P2PK_addresses_p2pk_count_get
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
#' p2pkCount()
#'
#' p2pkCount(bal_ge = 1000000)
#'
#' migoreng <- "0779ec04f2fae64e87418a1ad917639d4668f78484f45df962b0dec14a2591d2"
#' p2pkCount(bal_ge = 1000000000, token_id = migoreng)

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
    dplyr::rename(total_addresses = value)

  return(df)
}

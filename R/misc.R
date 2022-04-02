# Miscellaneous functions


# https://ergo.watch/api/v0/docs#/misc/P2PK_address_rank_ranking__p2pk_address__get
# Future: move to p2pk.R functions
#' P2PK Address Rank
#'
#' Get the rank of a P2PK address by current balance.
#'
#' @param address Required: the P2PK address.
#'
#' @return A tibble with the target address, rank, balance, and the next/previous addresses as well.
#' @import httr
#' @import dplyr
#' @import jsonlite
#' @import purrr
#' @import tidyr
#' @export
#'
#' @examples
#' bearwhale <- "9hyDXH72HoNTiG2pvxFQwxAhWBU8CrbvwtJDtnYoa4jfpaSk1d3"
#' p2pkRanking(bearwhale)

p2pkRanking <- function(address){

  url_request <- paste0("https://ergo.watch/api/v0/ranking/", address)

  df <- GET(url_request) %>%
    content(as = "text", encoding = "UTF-8") %>%
    jsonlite::fromJSON(flatten = TRUE) %>%
    as_tibble() %>%
    purrr::map(unlist) %>%
    as_tibble() %>%
    mutate(category = row_number()) %>%
    tidyr::pivot_longer(1:3) %>%
    mutate(category = case_when(category == 1 ~ "rank",
                                category == 2 ~ "address",
                                category == 3 ~ "balance")) %>%
    select(segment = name, category, value) %>%
    arrange(segment) %>%
    tidyr::pivot_wider(id_cols = segment, names_from = 2)


  return(df)
}





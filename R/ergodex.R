##########################################
################# ErgoDEX ################
##########################################



#####
##### PLATFORM STATISTICS
##### https://api.ergodex.io/v1/docs/#operation/Platform%20stats
#####

#' Platform Statistics
#'
#' Get statistics on whole AMM.
#'
#' @return A tibble with platform statistics for volume and TVL.
#' @import dplyr
#' @import httr
#' @import jsonlite
#' @import purrr
#' @import tidyr
#' @export
#'
#' @examples
#' ed_platformStats()

ed_platformStats <- function(){

  url_request <- paste0("https://api.ergodex.io/v1/amm/platform/stats")

  df <- GET(url_request) %>%
    content(as = "text", encoding = "UTF-8") %>%
    jsonlite::fromJSON(flatten = TRUE) %>%
    purrr::map(unlist) %>%
    as_tibble() %>%
    tidyr::pivot_longer(1:2) %>%
    group_by(name) %>%
    mutate(category = row_number()) %>%
    ungroup() %>%
    mutate(category = case_when(category == 1 ~ "value",
                                category == 2 ~ "currency",
                                category == 3 ~ "decimals")) %>%
    arrange(name) %>%
    tidyr::pivot_wider(names_from = category, values_from = value)

  return(df)
}

#####
##### ALL POOL STATS
##### https://api.ergodex.io/v1/docs/#operation/All%20pools%20stats
#####

#' All Pool Stats
#'
#' Get statistics on all liquidity pools.
#'
#' @param from Window lower bound (UNIX timestamp millis).
#' @param to Window upper bound (UNIX timestamp millis).
#'
#' @return A tibble with all liquidity pool statistics.
#' @import dplyr
#' @import httr
#' @import jsonlite
#' @export
#'
#' @examples
#' ed_allPoolStats()
#'
#' start <- 1648796400000
#' end <- 1648926788038
#' ed_allPoolStats(from = start, to = end)

ed_allPoolStats <- function(from = NULL, to = NULL){

  url_request <- paste0("https://api.ergodex.io/v1/amm/markets",
                        ifelse(!is.null(from),
                               paste0("?from=", from, "&to=", to), ""))

  df <- GET(url_request) %>%
    content(as = "text", encoding = "UTF-8") %>%
    jsonlite::fromJSON(flatten = TRUE) %>%
    as_tibble()

  return(df)
}




########## IN PROGRESS ##########

##########################################
############## Ergo Explorer #############
##########################################


library(httr)
library(dplyr)
library(jsonlite)




# https://api.ergoplatform.com/api/v1/docs/#operation/getApiV1AddressesP1Transactions

AddressesP1Transactions <- function(address){
  
  url_request <- paste0("https://api.ergoplatform.com/api/v1/addresses/", address, "/transactions")
  
  df <- GET(url_request) %>% 
    content(as = "text", encoding="UTF-8") %>% 
    fromJSON(flatten = TRUE)
  
  return(df)
}

df <- AddressesP1Transactions("address")








# https://api.ergoplatform.com/api/v1/docs/#operation/getApiV1AddressesP1BalanceConfirmed

AddressesP1BalanceConfirmed_ergo <- function(address){
  
  url_request <- paste0("https://api.ergoplatform.com/api/v1/addresses/", address, "/balance/confirmed")
  
  df <- GET(url_request) %>% 
    content(as = "text", encoding="UTF-8") %>% 
    fromJSON(flatten = TRUE)
  
  df <- df$nanoErgs %>% 
    as_tibble() %>% 
    mutate(erg = format(value / 10^9, nsmall = 5)) %>% 
    rename(nanoErg = value)
  
  return(df)
}

AddressesP1BalanceConfirmed_ergo("address")



AddressesP1BalanceConfirmed_tokens <- function(address){
  
  url_request <- paste0("https://api.ergoplatform.com/api/v1/addresses/", address, "/balance/confirmed")
  
  df <- GET(url_request) %>% 
    content(as = "text", encoding="UTF-8") %>% 
    fromJSON(flatten = TRUE)
  df <- df$tokens %>% 
    as_tibble() %>% 
    mutate(amountStandardized = amount / 10^decimals)
  
  return(df)
}

AddressesP1BalanceConfirmed_tokens("address")











# https://api.ergoplatform.com/api/v1/docs/#operation/getApiV1AssetsSearchBytokenid

AssetsSearchBytokenid <- function(tokenid){
  
  url_request <- paste0("https://api.ergoplatform.com/api/v1/assets/search/byTokenId?query=", tokenid, "&limit=500")
  
  df <- GET(url_request) %>% 
    content(as = "text", encoding="UTF-8") %>% 
    fromJSON(flatten = TRUE)
  
  df <- df$items %>% 
    as_tibble()
  
  return(df)
}

AssetsSearchBytokenid("tokenID")





# https://api.ergoplatform.com/api/v1/docs/#operation/getApiV1BoxesByaddressP1

BoxesByaddressP1 <- function(address){
  
  url_request <- paste0("https://api.ergoplatform.com/api/v1/boxes/byAddress/", address, "?limit=500")
  
  df <- GET(url_request) %>% 
    content(as = "text", encoding="UTF-8") %>% 
    fromJSON(flatten = TRUE)
  
  df <- df$items %>% 
    as_tibble()
  
  return(df)
}



BoxesByaddressP1("address")





% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ergowatch.R
\name{ew_addressesBalance}
\alias{ew_addressesBalance}
\title{Address Balance}
\usage{
ew_addressesBalance(address, token_id = NULL)
}
\arguments{
\item{address}{Required: the P2PK address.}

\item{token_id}{Token ID.}
}
\value{
A tibble with the requested address and balance.
}
\description{
Current $ERG or token balance of an address.
}
\examples{
bearwhale <- "9hyDXH72HoNTiG2pvxFQwxAhWBU8CrbvwtJDtnYoa4jfpaSk1d3"
ew_addressesBalance(bearwhale)

bearwhale <- "9hyDXH72HoNTiG2pvxFQwxAhWBU8CrbvwtJDtnYoa4jfpaSk1d3"
erdoge <- "3a7eb9b71a231b8df485c4d8b081726eda9876d2ce2d59bab5e5874c6cbba220"
ew_addressesBalance(bearwhale, token_id = erdoge)
}

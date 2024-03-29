% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ergowatch.R
\name{ew_addressesBalanceTimestamp}
\alias{ew_addressesBalanceTimestamp}
\title{Address Balance At Timestamp}
\usage{
ew_addressesBalanceTimestamp(address, timestamp, token_id = NULL)
}
\arguments{
\item{address}{Required: the P2PK address.}

\item{timestamp}{Required: timestamp.}

\item{token_id}{Token ID.}
}
\value{
A tibble with the requested address, specific timestamp, and balance.
}
\description{
$ERG or token balance of an address at a specific timestamp.
}
\examples{
bearwhale <- "9hyDXH72HoNTiG2pvxFQwxAhWBU8CrbvwtJDtnYoa4jfpaSk1d3"
ew_addressesBalanceTimestamp(bearwhale, timestamp = 1614307368646)

bearwhale <- "9hyDXH72HoNTiG2pvxFQwxAhWBU8CrbvwtJDtnYoa4jfpaSk1d3"
erdoge <- "3a7eb9b71a231b8df485c4d8b081726eda9876d2ce2d59bab5e5874c6cbba220"
ew_addressesBalanceTimestamp(bearwhale, timestamp = 1614307368646, token_id = erdoge)
}

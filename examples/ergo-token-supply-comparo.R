#############
# Author: @eeysirhc
# Date written: 2022-07-23
# Last updated: 2022-07-30
# Objective: compare Ergo native tokens and how their supply is distributed between contracts and P2PK addresses.
#############

# LOAD PACKAGES
library(tidyverse)
library(tidyergo)
library(ggrepel)
library(scales)

#####
# CREATE FUNCTION
comparo <- function(token_id, category){

  supply <- ew_tokensSupply(token_id) %>%
    mutate(token_id = token_id)

  details <- ew_tokensDetail(token_id)

  df <- supply %>%
    left_join(details) %>%
    mutate(emitted = emitted / 10^decimals,
           in_p2pks = in_p2pks / 10^decimals,
           in_contracts = in_contracts / 10^decimals,
           burned = burned / 10^decimals) %>%
    mutate(category = category)

  return(df)

}
#####

# MAP ERGO TOKEN IDS
id_neta <- "472c3d4ecaa08fb7392ff041ee2e6af75f4a558810a74b28600549d5392810e8"
id_ergopad <- "d71693c49a84fbbecd4908c94813b46514b18b67a99952dc1e6e4791556de413"
id_valleydao <- "0b7c3cd3145209c6f455e2a0b890195eafcde934e09ca3d54d7972d1f1ce3c44"
id_migoreng <- "0779ec04f2fae64e87418a1ad917639d4668f78484f45df962b0dec14a2591d2"
id_comet <- "0cd8c9f416e5b1ca9f986a7f10a84191dfb85941619e49e53c0dc30ebf83324b"
id_erdoge <- "36aba4b4a97b65be491cf9f5ca57b5408b0da8d0194f30ec8330d1e8946161c1"
id_kushti <- "fbbaac7337d051c10fc3da0ccb864f4d32d40027551e1c3ea3ce361f39b91e40"
id_paideia <- "1fd6e032e8476c4aa54c18c1a308dce83940e8f4a28f576440513ed7326ad489"
id_egio <- "00b1e236b60b95c2c6f8007a9d89bc460fc9e78f98b09faec9449007b40bccf3"
id_ergolend <- "007fd64d1ee54d78dd269c8930a38286caa28d3f29d27cadcb796418ab15c283"
id_thz <- "02f31739e2e4937bb9afb552943753d1e3e9cdd1a5e5661949cb0cef93f907ea"

# RETRIEVE DATA FROM ERGOWATCH
# Future: add sleep 1 second to not hammer API
neta <- comparo(id_neta, "Token")
ergopad <- comparo(id_ergopad, "Token")
valleydao <- comparo(id_valleydao, "Token")
migoreng <- comparo(id_migoreng, "Memecoin")
comet <- comparo(id_comet, "Memecoin")
erdoge <- comparo(id_erdoge, "Memecoin")
kushti <- comparo(id_kushti, "Memecoin")
paideia <- comparo(id_paideia, "ErgoPad Family")
egio <- comparo(id_egio, "ErgoPad Family")
ergolend <- comparo(id_ergolend, "ErgoPad Family")
thz <- comparo(id_thz, "ErgoPad Family")

# CONSOLIDATE DATA FRAMES
df <- bind_rows(neta, ergopad, valleydao, migoreng, comet, erdoge,
                kushti, paideia, egio, ergolend, thz)

# CALCULATE % DISTRO
df_clean <- df %>%
  mutate(pct_p2pks = in_p2pks / (emitted - burned),
         pct_contracts = in_contracts / (emitted - burned))

# PLOT GRAPH
df_clean %>%
  ggplot(aes(pct_p2pks, pct_contracts, label = name)) +
  geom_text_repel(aes(color = category), size = 5) +
  geom_point(aes(color = category), alpha = 0.7) +
  geom_abline(lty = 2) +
  labs(color = "Category",
       x = "Token Supply in P2PK Addresses",
       y = "Token Supply in Contracts",
       caption = "source: {tidyergo}",
       title = "Ergo Token Supply: P2PK Addresses vs Contracts") +
  scale_color_brewer(palette = "Set1") +
  scale_x_continuous(labels = percent_format()) +
  scale_y_continuous(labels = percent_format()) +
  theme_bw(base_size = 20)




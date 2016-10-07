library(tidyverse)
library(stringr)
f = list.files("data/stocks/", full.names = TRUE)
stocks = lapply(f, read_csv)
names(stocks) = str_sub(f, 14, 16)

close = broom::fix_data_frame(do.call(rbind, lapply(stocks, "[[", "Close")))
colnames(close) = c("symbol", broom::fix_data_frame(stocks[[1]])[[1]])

write_tsv(close, "data/stocks.tsv")


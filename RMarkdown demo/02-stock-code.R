library(dplyr)
library(xts)
library(quantmod)

prices <- getSymbols("GOOG", auto.assign = FALSE)
move <- Cl(last(prices)) - Op(last(prices))

ifelse(move > 0, "BUY", "SELL")

chartSeries(prices, theme = chartTheme("white", bg.col = "white"))

tail(as.data.frame(prices), 10)



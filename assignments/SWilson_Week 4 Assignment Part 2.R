setwd("C:/Users/Stewart/Documents/GitHub/dsc520")
library(readxl)
library(plyr)
library(ggplot2)
library(pastecs)
housing <- read_excel("data/week-7-housing.xlsx")
apply(housing[, "Sale Price"], 2, mean)
aggregate(`Sale Price` ~ `zip5`, housing,  mean)
# determines avg house price by zip code
avg.by.zip <- aggregate(`Sale Price` ~ `zip5`, housing,  mean)
# makes additional column of sq_m_lot which converts sq ft to sq m
ddply(housing, .variables="zip5", mutate, sq_m_lot = sq_ft_lot * 0.09290)
housing_hist_price <- ggplot(housing, aes(x=`Sale Price`)) + geom_histogram(aes(y=..density..))
housing_hist_price
housing_hist_price + stat_function(fun = dnorm, args = list(mean = mean(housing$`Sale Price`, na.rm = TRUE), sd = sd(housing$`Sale Price`, na.rm = TRUE)), colour = "black", size = 1)
housing_hist_size = ggplot(housing, aes(x=sq_ft_lot)) + geom_histogram(aes(y=..density..))
housing_hist_size + stat_function(fun=dnorm, args = list(mean=mean(housing$sq_ft_lot, na.rm=TRUE), sd=sd(housing$sq_ft_lot, na.rm=TRUE)), colour="black")
box <- ggplot(housing, aes(x=`Sale Price`, y=sq_ft_lot)) + geom_boxplot()
box
# box plot reveals many outliers of extremely high square footage with high prices. This could explain the skewness of the distributions
# though it does seem to match the idea that majority of people own small houses and a small minority own very large ones
# new variable mean_zip that is the mean sale price by zip code
mean_zip <- ddply(housing, .variables="zip5", mutate, mean_zip = mean(`Sale Price`))
mean_zip
# new variable that converts the price into pounds
price_pounds <- ddply(housing, .variables ="zip5", mutate, price_pounds = `Sale Price` * .77)
price_pounds
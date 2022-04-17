library(readxl)
library(dplyr)
library(purrr)
library(stringr)
housing <- read_excel('week-7-housing.xlsx')
head(housing)
# calculates mean sale price per zip code
housing %>% 
  group_by(zip5) %>% 
  summarize(AvgPrice=mean(`Sale Price`))
str(housing)
# calculates price per sq foot
housing %>% mutate(`Sale Price` / sq_ft_lot)
# sorts building grade by year built 
housing %>% select(building_grade, year_built) %>% arrange(desc(year_built))
# assigns mean to variable
AvgPrice <- housing %>% summarize(mean(`Sale Price`))
# Shows houses with price > mean arranged by zip and descending price
housing %>% filter(`Sale Price` > AvgPrice) %>% arrange(zip5) %>% select(`Sale Price`, zip5) %>% arrange(desc(`Sale Price`))
# finds median of all columns
housing %>% map(median) %>% head()
# summary of housing data frame
housing %>% map_dfr(summary)
price_size <- housing %>% mutate(`Sale Price` / sq_ft_lot)
# adds new columns of price per size
housing <- cbind(housing, price_size)
# creates data frame to easily look at head and tail at same time
head_housing <- head(housing)
tail_housing <- tail(housing)
head_plus_tail <- rbind(head_housing, tail_housing)
head_plus_tail
# splits date sold into just years
year_sold <- str_split(housing$year_built, pattern="^-")
year_sold
# puts individual years all in one character
years_together <- paste(year_sold)
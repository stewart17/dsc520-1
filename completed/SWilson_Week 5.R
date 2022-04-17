library(readxl)
library(dplyr)
housing <- read_excel('week-7-housing.xlsx')
head(housing)
housing %>% 
  group_by(zip5) %>% 
  summarize(AvgPrice=mean(`Sale Price`))
str(housing)
housing %>% mutate(`Sale Price` / sq_ft_lot)
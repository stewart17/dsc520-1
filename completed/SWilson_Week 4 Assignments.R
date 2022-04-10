# 4.2 Exercise
# Stewart Wilson
# Week 4

# PART 1 - SCORES


# Q: What are the observational units in this study?
## A: The observational units in this study are the 2 sections, Sports and Regular.


# Q: Identify the variables mentioned in the narrative paragraph 
# and determine which are categorical and quantitative?
## A: The variables are: Section (Categorical) and Score (Quantitative),


# Q: Comparing and contrasting the point distributions between the two section, 
# looking at both tendency and consistency: Can you say that one section tended 
# to score more points than the other? Justify and explain your answer.
## A: Between the 2 sections, the regular sections had a more normal distribution
## and the Sports sections had a negative skew. Because the Sports section is 
## not a normal distribution it is impossible to truly compare the two. However,
## it would appear that the regular sections tended to score higher overall, though
## the highest scores were present in the Sports sections.



# Q: Did every student in one section score more points than every student 
# in the other section? If not, explain what a statistical tendency means in this context.
##A: Not every student in one section scored more points than every student in the other section
## This means that a statistical tendency is about the overal distribution of scores
## and comparing the distribution between the two sections.


# Q: What could be one additional variable that was not mentioned in the narrative 
# that could be influencing the point distributions between the two sections?
##A: An additional variable not mentioned in the narrative is the percentage of students
## in the sports sections who were interested in sports. If the section was not
## actually full of sports students, it would explain the negative skew, since
## all the material was taught from a sports perspective.

library(ggplot2)
setwd("C:/Users/Stewart/Documents/GitHub/dsc520")
scores <- read.csv("data/scores.csv")
scores_reg <- subset(scores, scores$Section=="Regular")
scores_sport <- subset(scores, scores$Section=="Sports")
plot(scores_sport$Score, scores_reg$Count, col='red', pch=19, main="Student Performance: Sports Sections vs Regular Sections", xlab="Score", ylab="Count")
points(scores_reg$Score, scores_sport$Count, col='blue', pch=19)


# PART 2- HOUSING
library(readxl)
library(plyr)
library(ggplot2)
library(pastecs)
setwd("C:/Users/Stewart/Documents/GitHub/dsc520")
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



students <- read.csv("data/student-survey.csv")
head(students)
cov(students$TimeReading, students$TimeTV)
# -----------------------------------------
# covariance is used to see the relationship between the variances of any
# two variables. A positive covariance indicates that the two variables move
# in similar directions while a negative covariance indicates they move
# in opposite directions. When looking at Time Reading vs Time Watching Tv
# there is a negative covariance between the two, meaning that as the latter
# increases, the former decreases. It does not tell us anything about the
# strength of that relationship
# ------------------------------------------
# It seems that Time Reading is measured in hours, while Time Tv is minutes
# Happiness is on a scale from 0  to 100 and Gender is a binary choice, with
# 0 indicating one gender and 1 another.
# Covariance is heavily affected by different units of measurements. If they
# are not the same, then it is hard to tell how big the covariance really is
# nor can we compare covariances between various variables. In this case,
# we can easily amend the problem by converting TimeReading into minutes.
# -------------------------------------------
library(dplyr)
students <- students %>% mutate(TimeReadingMin= TimeReading * 60)
cov(students$TimeReadingMin, students$TimeTV)

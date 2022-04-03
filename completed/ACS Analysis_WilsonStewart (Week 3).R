library(ggplot2)
library(qqplotr)
library('pastecs')
setwd("C:/Users/Stewart/Documents/GitHub/dsc520")
comm_surv <- read.csv("data/acs-14-1yr-s0201.csv")
class(comm_surv)
str(comm_surv)
nrow(comm_surv)
ncol(comm_surv)
surv_hist <-ggplot(comm_surv, aes(x=HSDegree)) + geom_histogram(binwidth = 5) + ggtitle("High School Degree") + xlab("HS Degree (%)") + ylab("Number of Counties")
surv_hist
surv_hist_dense <- ggplot(comm_surv, aes(x=HSDegree)) + geom_histogram(aes(y = ..density..), binwidth = 5) + ggtitle("High School Degree") + xlab("HS Degree (%)") + ylab("Number of Counties")
surv_hist_norm <- surv_hist_dense + stat_function(fun = dnorm, args = list(mean= mean(comm_surv$HSDegree, na.rm = TRUE), sd = sd(comm_surv$HSDegree, na.rm = TRUE)), colour = "black", size = 3)
surv_hist_norm
surv_prob <- ggplot(comm_surv, mapping = aes(sample = HSDegree)) + stat_qq_point(size = 2)
surv_prob
stat.desc(comm_surv$HSDegree, norm=TRUE)
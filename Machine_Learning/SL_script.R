library(ISLR)
data("Auto")

pairs(Auto)
pairs(~mpg+displacement+horsepower+weight+acceleration, Auto)

attach(Auto)
cylinders <- as.character(cylinders)
summary(cylinders)
table(cylinders)

p <- c(1,2,3,4)
mat <- matrix()

library(ISLR) #loading package and loading auto data
data("Auto")
library(MASS)
data("Boston")

View(Boston)
?Boston

names(Boston)

lm.fit<-lm(medv~lstat,Boston)
class(lm.fit)

summary(lm.fit)

confint(lm.fit)

predict(lm.fit, data.frame(lstat=c(5,10,15)),
        interval="confidence")

predict(lm.fit, data.frame(lstat=c(5,10,15)),
        interval="prediction")


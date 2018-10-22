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

attach(Boston)
plot(lstat,medv)
abline(lm.fit,lwd=3,col="red")

par(mfrow=c(2,2),mar=c(3,3,2,3))
plot(lm.fit)

par(mfrow=c(1,1))
plot(predict(lm.fit),rstudent(lm.fit))

plot(hatvalues(lm.fit)) #leverage
which.max(hatvalues(lm.fit))

lm.fit <- lm(medv~lstat+age)
summary(lm.fit)

lm.fit1<-lm(medv~., data=Boston) #all
summary(lm.fit1)

lm.fit2<-lm(medv~.-age, data = Boston) #except age
summary(lm.fit2)

lm.fit3 <- lm(medv~lstat*age, data = Boston)
summary(lm.fit3)

install.packages("olsrr")
library(olsrr)

full<-lm(medv~., data = Boston)
k<-ols_step_best_subset(full)
k
plot(k)

k<-ols_step_both_p(full)
k
plot(k)

lm.fit<-lm(medv~lstat+age,data = Boston)
par(mfrow=c(2,2))
plot(lm.fit)

lm.fit2<-lm(medv~lstat+I(lstat^2)+age,data=Boston)
summary(lm.fit2)

plot(lm.fit2)

anova(lm.fit,lm.fit2) #which is the best fit model

lm.fit3<-lm(medv~poly(lstat,5)+age,data=Boston)
summary(lm.fit3)

lm.fit4<-lm(medv~log(lstat)+age,data=Boston)
summary(lm.fit4)

data(Carseats)
View(Carseats)
?Carseats

lm.fit<-lm(Sales~Income+Advertising+Price+Age+ShelveLoc,data=Carseats)
summary(lm.fit)
contrasts(Carseats$ShelveLoc) #to know baseline

library(car)

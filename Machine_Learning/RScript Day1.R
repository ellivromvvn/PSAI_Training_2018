x <- c(1,3,2,5)
x
x = c(1,3,2,5)
x

y = c(1,4,3)
y


x <- 1
y <- 2.5
class(x)
class(y)
z <- x+y
z
class(z)

m <- x > y #Is x larger than y?
n <- x < y #iS x smaller than y?
m
n
class(m)

a <- "1"
a
b <- "2.5"
a+b
class(a)

a1 <- as.numeric(a)
class(a1)

o <- c(1,2,5.3,6,-2,4) #numeric vector
p <- c("one","two","three","four","five","six") #character vector
q <- c(TRUE,TRUE,FALSE,TRUE,FALSE,TRUE) #logical vector
o;p;q

o[q] #logical vector can be used to extract vector components
names(o)<-p
o["three"]

ls()

x=matrix(data=c(1,2,3,4),nrow=2,ncol=2,byrow=TRUE)
x
class(x)



set.seed(1303)
x=rnorm(50)
y=x+rnorm(50,mean=50,sd=.1)
cor(x,y)

set.seed(3)
y=rnorm(100)
mean(y)
var(y)
sqrt(var(y))
sd(y)


setwd("C:/Users/Stephen Jun Villejo/Documents/Rexamples")



x=rnorm(100)
y=rnorm(100)
plot(x,y,xlab="Var1",ylab="var2",
     main="Scatterplot of Var1 vs Var2")

pdf("SamplePlot.pdf")
plot(x,y,col="navyblue")
dev.off()

jpeg("SamplePlot.jpeg")
plot(x,y,col="navyblue",main="title")
dev.off()


seq(1,10)
seq(0,1,length=10)
seq(1:10)


A=matrix(1:16,4,4)
A[c(1,3),c(2,4)]
A[1:3,2:4]
A[1:2,]
A[1,]
A[,4]



install.packages("ISLR")
library(ISLR)
data(Auto)

write.csv(Auto,file="Auto Dataset.csv")

data<-read.csv("Auto Dataset.csv")
head(data)
dim(data)
names(data)

plot(data$cylinders,data$mpg,xlab="cylinders"
  ,ylab="mpg",main="Scatterplot between cylinders and mpg")
attach(data)
plot(cylinders,mpg)
cylinders=as.factor(cylinders)

plot(cylinders,mpg)
plot(cylinders,mpg,col="red")
plot(cylinders,mpg,col="red",varwidth=T)
plot(cylinders,mpg,col="red",varwidth=T,
    xlab="cylinders",ylab="MPG")
hist(mpg)
hist(mpg,col=2,breaks=15)

pairs(Auto)
pairs(~mpg+displacement+horsepower+weight+acceleration,
        Auto)

summary(data) 

class(data$cylinders)



p <- c(1,2,3,4)
mat <- matrix(1:16,4,4)
num <- 100

l <- list(vector=p, matrix=mat,data=Auto,
          scalar=num)
names(l)
l$vector
l$mat
dim(l$Auto)

str(l)

library(MASS)
data(Boston)
View(Boston)
names(Boston)


lm.fit=lm(medv~lstat,Boston)
class(lm.fit)
summary(lm.fit)
names(lm.fit)
lm.fit$coefficients
lm.fit$residuals

confint(lm.fit)

predict(lm.fit,data.frame(lstat=(c(5,10,15))),
        interval="confidence")
predict(lm.fit,data.frame(lstat=(c(5,10,15))),
        interval="prediction")
attach(Boston)
plot(lstat,medv)
abline(lm.fit,lwd=3,col="red")

par(mfrow=c(2,2))
plot(lm.fit)

par(mfrow=c(1,1))
plot(predict(lm.fit),residuals(lm.fit))
plot(predict(lm.fit),rstudent(lm.fit))

plot(hatvalues(lm.fit))
which.max(hatvalues(lm.fit))


lm.fit <- lm(medv~lstat+age)
summary(lm.fit)

lm.fit1<-lm(medv~.,data=Boston)
summary(lm.fit1)


lm.fit2=lm(medv~.-age,data=Boston)
summary(lm.fit2)

lm.fit3=lm(medv~lstat*age,data=Boston)
summary(lm.fit3)
lm.fit3=lm(medv~lstat+age+lstat:age,data=Boston)
summary(lm.fit3)

library(ISLR)
library(MASS)
data(Boston)
install.packages("olsrr")
library(olsrr)
full<-lm(medv~crim+indus+chas+rm+tax,data=Boston)

k<-ols_step_all_possible(full)
k<-ols_step_best_subset(full)
k
plot(k)

k<-ols_step_forward_p(full)
plot(k)

full<-lm(medv~.,data=Boston)
k<-ols_step_backward_p(full)
plot(k)


k<-ols_step_both_p(full)
plot(k)





lm.fit<-lm(medv~lstat+age,data=Boston)
par(mfrow=c(2,2))
plot(lm.fit)

lm.fit2=lm(medv~lstat+I(lstat^2)+age,data=Boston)
summary(lm.fit2)
plot(lm.fit2)

anova(lm.fit,lm.fit2)

lm.fit3=lm(medv~poly(lstat,5)+age,data=Boston)
summary(lm.fit3)
anova(lm.fit2,lm.fit3)
plot(lm.fit3)

lm.fit4=lm(medv~log(lstat)+age,data=Boston)
summary(lm.fit4)
plot(lm.fit4)

library(ISLR)
library(MASS)
library(car)
data(Carseats)
View(Carseats)

lm.fit<-lm(Sales~Income+Advertising+Price+Age+ShelveLoc
          ,data=Carseats)
summary(lm.fit)
contrasts(Carseats$ShelveLoc)

lm.fit=lm(Sales~.,data=Carseats)
vif(lm.fit)






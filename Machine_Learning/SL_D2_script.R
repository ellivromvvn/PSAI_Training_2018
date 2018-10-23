##logit regression

library(ISLR)

data(Default)
attach(Default)

plot(Default$balance,Default$income,
     col=ifelse(Default$default=="Yes",
                "darkorange","gray"))
legend(2400,70000,col=c("darkorange","gray"),c("yes","no"),pch=c(2,2),bty="o")

par(mfrow=c(1,2))
plot(Default$default,Default$balance,col="red",varwidth=F,
     horizontal=F,xlab="Default",ylab="Balance")

plot(Default$default,Default$income,col="red",varwidth=F,
     horizontal=F,xlab="Default",ylab="Income")

glm.fit<-glm(default~.,data=Default,
             family = binomial)

summary(glm.fit)
coef(glm.fit)

#prediction
glm.probs<-predict(glm.fit,type="response")

glm.probs[1:10]

par(mfrow=c(1,1))
plot(glm.probs)

glm.pred<-rep("No",10000)
glm.pred[glm.probs>=0.5]<-"Yes"
table(glm.pred,Default$default)

#correct classification rate
mean(glm.pred==Default$default)

install.packages("caTools")
library(caTools)

#training set and test set
set.seed(101)
sample<-sample.split(Default,SplitRatio=0.80)

train<-subset(Default,sample==T)
test<-subset(Default,sample==F)

glm.fit<-glm(default~.,data=train,family = binomial)
summary(glm.fit)
glm.probs<-predict(glm.fit,test,type="response")
glm.pred<-rep("No",2500)
glm.pred[glm.probs>=0.5]<-"Yes"

table(glm.pred,test$default)
mean(glm.pred==test$default)

#Classification and Regression Trees

install.packages("tree")
library(tree)
data("Carseats")
summary(Carseats$Sales)
High<-ifelse(Carseats$Sales<=8,"No","Yes")
Carseats<-data.frame(Carseats,High)
names(Carseats)

## maximum tree
tree.carseats<-tree(High~.-Sales,Carseats)
summary(tree.carseats)
plot(tree.carseats)
text(tree.carseats,pretty = 0)

##Training and test sets
set.seed(1)
train<-sample(1:nrow(Carseats),200)
Carseats.test<-Carseats[-train,]
High.test<-High[-train]

##maximal tree
tree.carseats<-tree(High~.-Sales,Carseats,subset=train)
tree.pred<-predict(tree.carseats,Carseats.test,type="class")
table(tree.pred,High.test)

#test error rate
(98+56)/200

## Pruning

set.seed(3)
cv.carseats<-cv.tree(tree.carseats,FUN=prune.misclass)

names(cv.carseats)
cv.carseats

par(mfrow=c(1,2))
plot(cv.carseats$size,cv.carseats$dev,type="b")
plot(cv.carseats$k,cv.carseats$dev,type="b") #k is cost complexity parameter

prune.carseats<-prune.misclass(tree.carseats,best=7)

par(mfrow=c(1,1))
plot(prune.carseats)
text(prune.carseats,pretty = 0)

#testing on the test set (testing the performance)
tree.pred<-predict(prune.carseats,Carseats.test,
                   type="class")

table(tree.pred,High.test)
(96+54)/200

#try best=15

prune.carseats<-prune.misclass(tree.carseats,best=15)

par(mfrow=c(1,1))
plot(prune.carseats)
text(prune.carseats,pretty = 0)

#testing on the test set (testing the performance)
tree.pred<-predict(prune.carseats,Carseats.test,
                   type="class")

table(tree.pred,High.test)
(98+56)/200

## Regression Trees
library(MASS)

set.seed(1)
train<-sample(1:nrow(Boston),nrow(Boston)/2)
tree.boston<-tree(medv~.,data=Boston,subset=train)
summary(tree.boston)
plot(tree.boston)
text(tree.boston,pretty = 0)

##prune
cv.boston<-cv.tree(tree.boston)
cv.boston
prune.boston<-prune.tree(tree.boston,best=4)
plot(prune.boston)
text(prune.boston,pretty=0)

#error rate
yhat<-predict(prune.boston,newdata = Boston[-train,])
boston.test<-Boston[-train,"medv"]
mean((yhat-boston.test)^2) #MSE
sqrt(mean((yhat-boston.test)^2)) ##RMSE
#the deviation of actual values is the RMSE

plot(yhat, boston.test)

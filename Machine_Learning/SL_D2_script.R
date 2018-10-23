##logit regression

library(ISLR)

data(Default)
attach(Default)

plot(Default$balance,Default$income,
     col=ifelse(Default$default=="Yes",
                "darkorange","gray"))
legend(2400,70000,col=c("darkorange","gray"),c("yes","no"),
       pch=c(2,2),bty="o")

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

##classification tree

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
plot(cv.carseats$k,cv.carseats$dev,type="b") 
#k is cost complexity parameter

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

##Bagging and RandomForest

install.packages("randomForest")
library(randomForest)

##Bagging

data(Boston)
set.seed(1)
bag.boston<-randomForest(medv~.,data=Boston, 
                         subset=train,mtry=13,
                         importance=T)

yhat.bag<-predict(bag.boston,newdata = Boston[-train,])
mean((yhat.bag-boston.test)^2)
sqrt(mean((yhat.bag-boston.test)^2))     

#adding ntree=25
bag.boston<-randomForest(medv~.,data=Boston, 
                         subset=train,mtry=13,
                         importance=T,ntree=25)

yhat.bag<-predict(bag.boston,newdata = Boston[-train,])
mean((yhat.bag-boston.test)^2)
sqrt(mean((yhat.bag-boston.test)^2))

##Random Forest

rf.boston<-randomForest(medv~.,data=Boston, 
                         subset=train,mtry=4,
                         importance=T) 
#mtry is 4 because sqrt(10) predictors

yhat.rf<-predict(rf.boston,newdata = Boston[-train,])
mean((yhat.rf-boston.test)^2)
sqrt(mean((yhat.rf-boston.test)^2))

importance(rf.boston) 
#note the highest %IncMSE (important variable)
varImpPlot(rf.boston)


data(Smarket) #ISLR
?Smarket

#Exercise Carseats
# Bagging
# load randomForest package

set.seed(1)
train<-sample(1:nrow(Carseats),200)
Carseats.test<-Carseats[-train,]
High.test<-High[-train]

set.seed(1)
bag.carseats<-randomForest(High~.-Sales,data=Carseats, 
                         subset=train,mtry=10,
                         importance=T)

yhat.bag<-predict(bag.carseats,newdata = Carseats[-train,])
table(yhat.bag,High.test)
(103+61)/200

##Random Forest
set.seed(1)
rf.carseats<-randomForest(High~.-Sales,data=Carseats, 
                        subset=train,mtry=4,
                        importance=T,ntree=1000)

yhat.rf<-predict(rf.carseats,newdata = Carseats[-train,])
table(yhat.rf,High.test)
(104+59)/200
importance(rf.carseats) 
#note the highest %IncMSE (important variable)
varImpPlot(rf.carseats)
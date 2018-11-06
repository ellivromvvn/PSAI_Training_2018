install.packages("tree")
library(tree)
library(ISLR)
data(Carseats)
summary(Carseats$Sales)
High=ifelse(Sales<=8,"No","Yes")
Carseats=data.frame(Carseats,High)
names(Carseats)
View(Carseats)

tree.carseats=tree(High~.-Sales,Carseats)
summary(tree.carseats)
plot(tree.carseats)
text(tree.carseats,pretty=0)

set.seed(1)
train=sample(1:nrow(Carseats),200)
Carseats.test=Carseats[-train,]
High.test=High[-train]

tree.carseats=tree(High~.-Sales,Carseats,subset=train)
tree.pred=predict(tree.carseats,Carseats.test,
                  type="class")
table(tree.pred,High.test)
(98+56)/200

set.seed(3)
cv.carseats=cv.tree(tree.carseats,FUN=prune.misclass)
names(cv.carseats)

par(mfrow=c(1,2))
plot(cv.carseats$size,cv.carseats$dev,type="b")
plot(cv.carseats$k,cv.carseats$dev,type="b")

prune.carseats=prune.misclass(tree.carseats,best=7)
par(mfrow=c(1,1))
plot(prune.carseats)
text(prune.carseats,pretty=0)

tree.pred=predict(prune.carseats,Carseats.test,type="class")
table(tree.pred,High.test)
(96+54)/200


prune.carseats=prune.misclass(tree.carseats,best=15)
par(mfrow=c(1,1))
plot(prune.carseats)
text(prune.carseats,pretty=0)

tree.pred=predict(prune.carseats,Carseats.test,type="class")
table(tree.pred,High.test)
(98+56)/200

#bagging
set.seed(1)
bag.carseats=randomForest(High~.-Sales,data=Carseats,
                          subset=train,mtry=10,importance=TRUE)
yhat.bag=predict(bag.carseats,newdata=Carseats[-train,])
table(yhat.bag,High.test)
(103+61)/200

#randomforest
set.seed(1)
rf.carseats=randomForest(High~.-Sales,data=Carseats,
                         subset=train,mtry=4,importance=TRUE,ntree=10000)
yhat.rf=predict(rf.carseats,newdata=Carseats[-train,])
table(yhat.rf,High.test)
(104+59)/200

varImpPlot(rf.carseats)



library(MASS)
set.seed(1)
train=sample(1:nrow(Boston),nrow(Boston)/2)
tree.boston=tree(medv~.,data=Boston,subset=train)
summary(tree.boston)
plot(tree.boston)
text(tree.boston,pretty=0)

cv.boston=cv.tree(tree.boston)
names(cv.boston)
cv.boston

prune.boston=prune.tree(tree.boston,best=4)
plot(prune.boston)
text(prune.boston,pretty=0)

yhat=predict(prune.boston,newdata=Boston[-train,])
boston.test=Boston[-train,"medv"]
mean((yhat-boston.test)^2)
sqrt(mean((yhat-boston.test)^2))

plot(yhat,boston.test)


install.packages("randomForest")
library(randomForest)
rfNews()

set.seed(1)
bag.boston=randomForest(medv~.,data=Boston,
              subset=train,mtry=13,importance=TRUE)
yhat.bag=predict(bag.boston,newdata=Boston[-train,])
mean((yhat.bag-boston.test)^2)
sqrt(mean((yhat.bag-boston.test)^2))


bag.boston=randomForest(medv~.,data=Boston,
        subset=train,mtry=13,importance=TRUE,ntree=25)
yhat.bag=predict(bag.boston,newdata=Boston[-train,])
mean((yhat.bag-boston.test)^2)
sqrt(mean((yhat.bag-boston.test)^2))

rf.boston=randomForest(medv~.,data=Boston,
       subset=train,mtry=4,importance=TRUE)
yhat.rf=predict(rf.boston,newdata=Boston[-train,])
mean((yhat.rf-boston.test)^2)
sqrt(mean((yhat.rf-boston.test)^2))

importance(rf.boston)
varImpPlot(rf.boston)



library(ISLR)
data("Smarket")

set.seed(101)





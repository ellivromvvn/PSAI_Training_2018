##logit regression

library(ISLR)

data(Default)
attach(Default)

plot(Default$balance,Default$income,
     col=ifelse(Default$default=="yes",
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

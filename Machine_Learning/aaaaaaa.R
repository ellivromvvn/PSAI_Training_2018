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

#Set the working directory
setwd("F:/Profession/PSAi/Datasets")

#Load the necessary packages
library("zoo")       #Date manipulation package
library("mFilter")   #Time series filter
library("ggplot2")   #Charts
library("smooth")    #Smoothing
library("forecast")  #Forecasts
library("stats")     #For seasonal subseries plots

#Import Data and Manage Date
inflation <- read.table("inflation.txt",header = T)
head(inflation) #for table preview/checking

inflation$month <- gsub("M","-",inflation$month)
month <- as.yearmon(inflation$month, format="%Y-%m") #zoo package
inflation <- cbind(month,inflation["inflation"])
head(inflation)

#Creating a line graph using the plot function
plot(inflation)
plot(inflation, type="o")
plot(inflation, type="l",col="blue",xlab="",ylab="Inflation Rate",
                main="Inflation Rate \n(Jan 2013 - Sep 2018)")
#The "\n" inserts a line break in the plot title

#Creating a line graph using the ggplot package (INFLATION DATA)
ggplot(data=inflation, aes(x=month)) + 
  geom_line(aes(y=inflation),col="blue") + 
  labs(title="Inflation Rate", subtitle = "Jan 2013 - Sep 2018", x="", y="Inflation Rate", 
       colour="",caption = "Source: Philippine Statistics Authority") +
  theme(plot.title = element_text(hjust = 0.5),plot.subtitle = element_text(hjust = 0.5))

#rainfall data (IMPORT AND LINE GRAPH)
rainfall <- read.table("rainfall.txt",header = T)
head(rainfall) #for table preview/checking

rainfall$month <- gsub("M","-",rainfall$month)
month <- as.yearmon(rainfall$month, format="%Y-%m")
rainfall <- cbind(month,rainfall["ave_rain"],rainfall["dengue"])
head(rainfall)

is.data.frame(rainfall)
ggplot(data=rainfall, aes(x=month,group = 1)) + 
  geom_line(aes(y=ave_rain,colour="Average Rain")) + 
  geom_line(aes(y=dengue*1/1000,colour="Reported Dengue Cases")) + 
  labs(title="Reported Dengue Cases and Average Rainfall in the Philippines", 
       subtitle = "Jan 2009 - Jul 2013", x="", y="Average Rainfall", colour="") +
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        legend.position = c(.3, .95)) +
  scale_y_continuous(sec.axis = sec_axis(~.*1000/1, name = "Reported Dengue Cases"))


#Rainfall data (for seasonal plots)
rain <- read.table("rain.txt",header = T)
rain <- ts(rain,frequency=12,start=c(2009,1),end=c(2013,7))
head(rain) #for table preview/checking

plot(rain,col="maroon",
     main="Average Rainfall in the Philippines: 2009-2013",
     xlab="",
     ylab="Average Monthly Rainfall")
monthplot(rain,labels = month.abb,col="maroon",
          main="Seasonal Plots of Rainfall in the Philippines: 2009-2013",
          ylab="Average Monthly Rainfall")

#CPI data (IMPORT AND LINE GRAPH)
cpi <- read.table("cpi.txt",header = T)
head(cpi) #for table preview/checking

cpi$month <- gsub("M","-",cpi$month)
month <- as.yearmon(cpi$month, format="%Y-%m")
cpi <- cbind(month,cpi["cpi"])
head(cpi)

plot(cpi, type="l",col="red",xlab="", ylab="CPI",
     main="Consumer Price Index in the Philippines
           (1994-2016)")

#RGDP data (IMPORT AND LINE GRAPH)
rgdp <- read.table("rgdp.txt",header = T)
head(rgdp) #for table preview/checking

quarter <- as.yearqtr(rgdp$quarter,format="%Y Q%q")
rgdp <- cbind(quarter,rgdp["rgdp"])
head(rgdp)

plot(rgdp, type="l",col="red",xlab="", ylab="Real GDP (in million Pesos)",
     main="Real Gross Domestic Product of the PHilippines
           (1998 Q1 -2018 Q2)")

#Hodrick-Prescott Filter
inflation.hp <- hpfilter(inflation$inflation, freq=14400, type="lambda")
#for freq values: monthly-14400, quarterly-1600, annual-100 
plot(inflation.hp)

inflation <- cbind(inflation,inflation.hp$trend)
head(inflation)
colnames(inflation)[3] <- "hp_trend"
head(inflation)

#ggplot input: Dataframe
is.data.frame(inflation)
ggplot(data=inflation, aes(x=month)) + 
  geom_line(aes(y=inflation, colour="Inflation Rate")) + 
  geom_line(aes(y=hp_trend, colour="HP Trend")) +
  labs(x="Month", y="Inflation Rate", colour="") +
  theme(legend.position="top") +
  scale_colour_manual(values=c("blue","red"))


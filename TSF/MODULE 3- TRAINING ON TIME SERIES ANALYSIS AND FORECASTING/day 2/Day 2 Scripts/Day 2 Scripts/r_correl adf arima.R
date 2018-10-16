#Load Packages
library("tseries")  # Unit Root Tests
library("forecast") # For auto.arima
library("x13binary") # Deseasonalization
library("seasonalview") # Deseasonalization

#Set Working Directory
setwd("F:/Profession/PSAi/Datasets")

#Performing an ADF test on Peso-Dollar Excahange data
pder <- read.table("pder.txt", header=T)
head(pder)

pder.ts <- ts(pder$pder,frequency=12,start=c(1980,1))
head(pder.ts)

adf.test(pder.ts, alternative="stationary")
adf.test(diff(pder.ts), alternative="stationary")

plot(pder.ts)
plot(diff(pder.ts))

#CPI Data
cpi <- read.table("cpi.txt", header=T)
head(cpi)

cpi.ts <- ts(cpi$cpi,frequency=12,start=c(1994,1))
head(pder.ts)

adf.test(cpi.ts, alternative="stationary")
adf.test(diff(cpi.ts), alternative="stationary")

#Visualizing its dependence structure
plot(cpi.ts)
acf(cpi.ts)
pacf(cpi.ts)

plot(diff(cpi.ts))
acf(diff(cpi.ts))
pacf(diff(cpi.ts))

plot(rain.ts)
acf(rain.ts)
pacf(rain.ts)

#Inflation data
inflation <- read.table("inflation.txt", header=T)
head(inflation)

#Create a time series data from the existing dataframe
inf.ts <- ts(inflation$inflation,frequency=12,start=c(2013,1))
head(inf.ts)

adf.test(inf.ts, alternative="stationary")
adf.test(diff(inf.ts), alternative="stationary")
adf.test(diff(log(inf.ts)), alternative="stationary")


#Import Data and Manage Date
export <- read.table("export.txt", header=T)
head(export)

#Create a time series data from the existing dataframe
export.ts <- ts(export$export,frequency=12,start=c(1991,1))

adf.test(export.ts, alternative="stationary")
adf.test(diff(export.ts), alternative="stationary")
adf.test(diff(log(export.ts)), alternative="stationary")

acf(diff(log(export.ts)))
pacf(diff(log(export.ts)))

plot(export.ts)
plot(diff(export.ts))
plot(diff(log(export.ts)))

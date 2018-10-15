#Load Packages
library("zoo")    #Date manipulation package
library("smooth") #For Exponential Smooting

#Set Working Directory
setwd("F:/Profession/PSAi/Datasets")

#Import Data and Manage Date
export <- read.table("export.txt", header=T)
  head(export)

export$month <- gsub("M","-",export$month)
rtime <- as.yearmon(export$month, format="%Y-%m")
export <- cbind(rtime,export["export"])
  head(export)

export.ts <- ts(export$export,frequency=12,start=c(1991,1))
  head(export.ts)
  
#Exponential Smoothing Using the smooth Package
export.ses  <- es(export.ts,model="ANN",h=12,holdout=FALSE,intervals="parametric",level=0.95,cfType="MSE")
export.des  <- es(export.ts,model="AAdN",h=12,holdout=FALSE,intervals="parametric",level=0.95,cfType="MSE")
export.hwn  <- es(export.ts,model="AAN",h=12,holdout=FALSE,intervals="parametric",level=0.95,cfType="MSE")
export.hwa  <- es(export.ts,model="AAA",h=12,holdout=FALSE,intervals="parametric",level=0.95,cfType="MSE")
export.hwm  <- es(export.ts,model="AAM",h=12,holdout=FALSE,intervals="parametric",level=0.95,cfType="MSE")
export.auto <- es(export.ts,model="ZZZ",h=12,holdout=FALSE,intervals="parametric",level=0.95,cfType="MSE")

#ANN  means Additive errors, No trend, No seasonality (SES)
#AAdN means Additive errors, Additive (dampled) trend, No seasonality (DES)
#AAN  means Additive errors, Additive trend, No seasonality (Holt-Winters no seasonality)
#AAA  means Additive errors, Additive trend, Additive seasonality (HW with additive seasonality)
#AAM  means Additive errors, Additive trend, Multiplicative seasonality (HW with multiplicative seasonality)
#ZZZ  means all components are (Z) estimated 

#CHOOSE LOWEST MAPE
MAPE(export.ts,export.ses$fitted)
MAPE(export.ts,export.des$fitted)
MAPE(export.ts,export.hwn$fitted)
MAPE(export.ts,export.hwa$fitted)
MAPE(export.ts,export.hwm$fitted)
MAPE(export.ts,export.auto$fitted)

#Forecast h steps using model with lowest MAPE
forecast(export.auto,h=24)
plot(forecast(export.auto,h=24))

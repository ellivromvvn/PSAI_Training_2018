
<!-- rnb-text-begin -->

---
title: "TSF"
output: html_notebook
---

# Overview
- concepts in ts
- descriptive analysis ts
- exponential smoothing
- ARIMA
- rstudio

# UV TSA
- Exponential Smoothing
- ARIMA
- ARCH Models

# MV TSA
- Vector Autoregressive Models
- Error Correction Models
- Cointegration

Load the necessary packages


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxubGlicmFyeShcInpvb1wiKSAgICAgICAjRGF0ZSBtYW5pcHVsYXRpb24gcGFja2FnZVxuYGBgIn0= -->

```r
library("zoo")       #Date manipulation package
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiXG5BdHRhY2hpbmcgcGFja2FnZTog46S847ixem9v46S847iyXG5cblRoZSBmb2xsb3dpbmcgb2JqZWN0cyBhcmUgbWFza2VkIGZyb20g46S847ixcGFja2FnZTpiYXNl46S847iyOlxuXG4gICAgYXMuRGF0ZSwgYXMuRGF0ZS5udW1lcmljXG4ifQ== -->

```

Attaching package: 㤼㸱zoo㤼㸲

The following objects are masked from 㤼㸱package:base㤼㸲:

    as.Date, as.Date.numeric
```



<!-- rnb-output-end -->

<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxubGlicmFyeShcIm1GaWx0ZXJcIikgICAjVGltZSBzZXJpZXMgZmlsdGVyXG5gYGAifQ== -->

```r
library("mFilter")   #Time series filter
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiXG4gICAg46S847ixbUZpbHRlcuOkvOO4siB2ZXJzaW9uOiAwLjEtNFxuXG4gICAg46S847ixbUZpbHRlcuOkvOO4siBpcyBhIHBhY2thZ2UgZm9yIHRpbWUgc2VyaWVzIGZpbHRlcmluZ1xuXG4gICAgU2VlIOOkvOO4sWxpYnJhcnkoaGVscD1cIm1GaWx0ZXJcIinjpLzjuLIgZm9yIGRldGFpbHNcblxuICAgIEF1dGhvcjogTWVobWV0IEJhbGNpbGFyLCBtYmFsY2lsYXJAeWFob28uY29tXG4ifQ== -->

```

    㤼㸱mFilter㤼㸲 version: 0.1-4

    㤼㸱mFilter㤼㸲 is a package for time series filtering

    See 㤼㸱library(help="mFilter")㤼㸲 for details

    Author: Mehmet Balcilar, mbalcilar@yahoo.com
```



<!-- rnb-output-end -->

<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxubGlicmFyeShcImdncGxvdDJcIikgICAjQ2hhcnRzXG5saWJyYXJ5KFwic21vb3RoXCIpICAgICNTbW9vdGhpbmdcbmBgYCJ9 -->

```r
library("ggplot2")   #Charts
library("smooth")    #Smoothing
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiTG9hZGluZyByZXF1aXJlZCBwYWNrYWdlOiBncmV5Ym94XG5QYWNrYWdlIFwiZ3JleWJveFwiLCB2MC4zLjEgbG9hZGVkLlxuVGhpcyBpcyBwYWNrYWdlIFwic21vb3RoXCIsIHYyLjQuNlxuXG5BdHRhY2hpbmcgcGFja2FnZTog46S847ixc21vb3Ro46S847iyXG5cblRoZSBmb2xsb3dpbmcgb2JqZWN0IGlzIG1hc2tlZCBmcm9tIOOkvOO4sXBhY2thZ2U6Z3JleWJveOOkvOO4sjpcblxuICAgIGdyYXBobWFrZXJcbiJ9 -->

```
Loading required package: greybox
Package "greybox", v0.3.1 loaded.
This is package "smooth", v2.4.6

Attaching package: 㤼㸱smooth㤼㸲

The following object is masked from 㤼㸱package:greybox㤼㸲:

    graphmaker
```



<!-- rnb-output-end -->

<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxubGlicmFyeShcImZvcmVjYXN0XCIpICAjRm9yZWNhc3RzXG5saWJyYXJ5KFwic3RhdHNcIikgICAgICNGb3Igc2Vhc29uYWwgc3Vic2VyaWVzIHBsb3RzXG5gYGAifQ== -->

```r
library("forecast")  #Forecasts
library("stats")     #For seasonal subseries plots
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


Import Data and Manage Date


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuaW5mbGF0aW9uIDwtIHJlYWQudGFibGUoXCJ+L1IvUFNBSV9UcmFpbmluZ18yMDE4L1RTRi9EYXRhc2V0cy9pbmZsYXRpb24udHh0XCIsaGVhZGVyID0gVClcbmhlYWQoaW5mbGF0aW9uKSAjZm9yIHRhYmxlIHByZXZpZXcvY2hlY2tpbmdcbmBgYCJ9 -->

```r
inflation <- read.table("~/R/PSAI_Training_2018/TSF/Datasets/inflation.txt",header = T)
head(inflation) #for table preview/checking
```

<!-- rnb-source-end -->

<!-- rnb-frame-begin eyJtZXRhZGF0YSI6eyJjbGFzc2VzIjpbImRhdGEuZnJhbWUiXSwibmNvbCI6MiwibnJvdyI6Nn0sInJkZiI6Ikg0c0lBQUFBQUFBQUJsM1V5MDdqTUJTQVlTZHBXclhTQUJMUDBhb1gzMmJYQlN6WnNHSWJTZ3JWQkFlbFlXYVd2TWJNd3dKMkVpUCtXbkxqY3hMbmZHNmtjM3QxdDU3ZHpZUVFxY2p5UktTWlg0NVMvNU9Ja1ppRzYxOGhzc3Z1QVpIOThOZHhkN09MUmZlMG4zbWZ4OFp4VmY0dXE2TmZYZmg1UFdRbjYrVnFjN05jTVZ3ejNEQ1VEQlZEemRBd3RBeC9JbHd0R1ZLMStxNlNORXVhSmMyU1prbXpwRm5TTEdtV05FdWFKYzJTWmtXem9sblJyR2hXTkN1YUZjMktaa1d6b2xuUnJHaldOR3VhTmMyYVprMnpwbG5UckduV05HdWFOYzJhWmtPem9kblFiR2cyTkJ1YURjMkdaa096b2RuUWJHaTJORnVhTGMyV1prdXpwZG5TYkdtMndjeEdrZStxNGhqN3hGZjMyQmU3dG03ODZ0M1BzNURaanZmZDJFNDIzZGptLzhMNHYwMkdhenJjRHgycEd5emppdWN5bGtsajhybDI3ZE1RVEE5dVh4WHRvWFluVzZkTi9XY1J0NGNlbUw3MUJZYWVsMzJjNkdjUFJWc3M5bzNmMHA4QXI1dlVMNkdJZjFsNk9UVFA3NXVUNWlSeC91cEM4WWY1N3VuVi9acXJVRUQwVFRnWlFFbVArVnFuZmNsUmhPWHhieTNkNDhHVjhmUlZjVjlXUTNEbUQ5bWRjZkhTSEZ3YlQrS3p4MFZidDBWOGJyYXJxNWpwdjg3N0o3NUNuUFJHQmdBQSJ9 -->

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":[""],"name":["_rn_"],"type":[""],"align":["left"]},{"label":["month"],"name":[1],"type":["fctr"],"align":["left"]},{"label":["inflation"],"name":[2],"type":["dbl"],"align":["right"]}],"data":[{"1":"2013M01","2":"2.8","_rn_":"1"},{"1":"2013M02","2":"2.9","_rn_":"2"},{"1":"2013M03","2":"2.7","_rn_":"3"},{"1":"2013M04","2":"2.2","_rn_":"4"},{"1":"2013M05","2":"2.3","_rn_":"5"},{"1":"2013M06","2":"2.5","_rn_":"6"}],"options":{"columns":{"min":{},"max":[10],"total":[2]},"rows":{"min":[10],"max":[10],"total":[6]},"pages":{}}}
  </script>
</div>

<!-- rnb-frame-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->



<!-- rnb-text-end -->


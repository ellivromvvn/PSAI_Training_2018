
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


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuaW5mbGF0aW9uIDwtIHJlYWQudGFibGUoXCJpbmZsYXRpb24udHh0XCIsaGVhZGVyID0gVClcbmhlYWQoaW5mbGF0aW9uKSAjZm9yIHRhYmxlIHByZXZpZXcvY2hlY2tpbmdcbmBgYCJ9 -->

```r
inflation <- read.table("inflation.txt",header = T)
head(inflation) #for table preview/checking
```

<!-- rnb-source-end -->

<!-- rnb-frame-begin eyJtZXRhZGF0YSI6eyJjbGFzc2VzIjpbImRhdGEuZnJhbWUiXSwibmNvbCI6MiwibnJvdyI6Nn0sInJkZiI6Ikg0c0lBQUFBQUFBQUJsM1V6MitiTUJUQWNRTWhVU0t0cTlTL0kxRkkvS3UzSExyakxqMzF5bEt5UnFPbUluVHJjZjlHKzhkMnN3RlgvY2FTZzk4RDh6NE8wcnU5dWRzczdoWkNpRlJrZVNMU3pDOG5xZjlKeEVUTXcvVkZpT3lxZjBCa1gveDEydC9zWTlFLzdXYys1TEZ4V2xlL3EvcmtWNWQrZmh1enM4MjYySDVmRnd3M0RMY01KVVBGVURNMERDM0RhNFRGbWlGVnhXZVZwRm5TTEdtV05FdWFKYzJTWmttenBGblNMR21XTkN1YUZjMktaa1d6b2xuUnJHaFdOQ3VhRmMyS1prV3pwbG5UckduV05HdWFOYzJhWmsyenBsblRyR25XTkJ1YURjMkdaa096b2RuUWJHZzJOQnVhRGMyR1prT3pwZG5TYkdtMk5GdWFMYzJXWmt1ekRXWTJpbnhmbDZmWUp6NjZ4NkhjZDAzclYrOStYb1RNYm5yb3gyNjI3Y2N1ZnczamJaZU0xM1M4SHpwU1AxakdsWTlWTEpQRzVHUGp1b2N4bUIvZG9TNjdZK1BPdHM3YjVzOHFiZzg5TVAwN0ZCaDdYdmJ2VEwrNEw3dHlkV2o5bHVFRWVOMnNlUXBGL012U3E3RjVmdDZjdEdlSnI4OHVGTDlmN2grZTNhOWxFUXFJb1Frbkl5Z1pNQi9yZENnNWliQTgvcTJWKzNsMFZUeDlYZjZvNmpHNDhJZnN6N2g2YW8rdWl5ZngyZE9xYTdveVByZllOM1hNREYvbi9UOTN6SldpUmdZQUFBPT0ifQ== -->

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":[""],"name":["_rn_"],"type":[""],"align":["left"]},{"label":["month"],"name":[1],"type":["fctr"],"align":["left"]},{"label":["inflation"],"name":[2],"type":["dbl"],"align":["right"]}],"data":[{"1":"2013M01","2":"2.8","_rn_":"1"},{"1":"2013M02","2":"2.9","_rn_":"2"},{"1":"2013M03","2":"2.7","_rn_":"3"},{"1":"2013M04","2":"2.2","_rn_":"4"},{"1":"2013M05","2":"2.3","_rn_":"5"},{"1":"2013M06","2":"2.5","_rn_":"6"}],"options":{"columns":{"min":{},"max":[10],"total":[2]},"rows":{"min":[10],"max":[10],"total":[6]},"pages":{}}}
  </script>
</div>

<!-- rnb-frame-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->



<!-- rnb-text-end -->


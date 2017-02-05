Anomaly Detection in a Server
========================================================
author: Don
date: Feb 5, 2017
autosize: true

Introduction
========================================================

Tools like collectD and statsD can collect server metrics and ship  
to various sinks like graphite, influxDB, elasticsearch and  
allow visuazliation in dashboards like kibana and splunk.  

These metrics could be 

- CPU load
- Network I/O
- Memory Usage
- Login Attempts
- Disk Read/Writes
- and many more!

I see dashboards everywhere
========================================================

While dashboards with many shiny charts & meter gauges look nice  
and are crucial for problem diagnosis - staring at one all day is  
not ideal unless you are a manager type ;)  

Also, setting alerts for thresholds can get messy and multiply in  
number with each passing day - very difficult to account for all combinations.  

So how do we monitor anomalous activities without explictly setting  
thresholds?

Gaussian Way
========================================================
One solution is to identify critical metrics and build an anomaly
detection which assigns probabilities for new events.

to demonstrate this, we will:

- generate synthetic gaussian metrics for cpu utilization,  
memory used and network out
- calculate mean, sd for each feature
- for each new data point (cpu_util, mem_used, network_out)  
calculate the probability of such event  
(assume gaussanility and independence)
- flag for anomaly if probability is below a threshold  

Generating synthetic gaussian metrics
========================================================

```r
library(dplyr)
set.seed(123)
trainData <- data.frame(cpu_util = rnorm(100, 2, 2),
                        mem_used = rnorm(100, 4, 2),
                        network_out = rnorm(100, 6, 2))

mean_cpu_util <- mean(trainData$cpu_util)
sd_cpu_util <- sd(trainData$cpu_util)
mean_mem_used <- mean(trainData$mem_used)
sd_mem_used <- sd(trainData$mem_used)
mean_network_out <- mean(trainData$network_out)
sd_network_out <- sd(trainData$network_out)
```

Contd.
========================================================

```r
predictAnomaly <- function(dataset) { 
    gauss <- function(x, u, sigma) {
        1 / sqrt(2 * pi * sigma^2) * exp(-((x - u)^2 / (2 * sigma^2)))
    }
    p <- c()
    for (i in 1:nrow(dataset)) {
        sample <- dataset[i, ]
        p <- c(p, gauss(sample$cpu_util, mean_cpu_util, sd_cpu_util) *
                   gauss(sample$mem_used, mean_mem_used, sd_mem_used) *
                   gauss(sample$network_out, mean_network_out, sd_network_out))
    }
    p
}
```

Train and Test Prediction
========================================================
The way we generate the test data with higher standard errors,  
allows us to detect more anomalies there than in the training data.


```r
testData <- data.frame(cpu_util = rnorm(100, 2, 3),
                        mem_used = rnorm(100, 4, 2.5),
                        network_out = rnorm(100, 6, 3))

trainPred <- predictAnomaly(trainData) < 8.99e-05
mean(trainPred)
```

```
[1] 0.01
```

```r
testPred <- predictAnomaly(testData) < 8.99e-05
mean(testPred)
```

```
[1] 0.24
```

I'm a Visual Learner 
========================================================
Fair enough! Red points = bad events!



<iframe src="demo.html" style="position:absolute;height:100%;width:100%"></iframe>

Take Aways
========================================================

- Extending this to use real data isn't very difficult but  
take care in selecting features and data points indicative of  
normal operations (exclude anomalies)
- multi-variate gaussian solution can take advantage of the  
inherent correlation of some of these metrics but is computationally
tasking
- data not gaussian should be transformed to be one
- with time what is considered "normal" may change and this requires  
model recalculation
- don't throw away the existing dashboard

References:  
Building Anomaly Detection System <https://www.coursera.org/learn/machine-learning>
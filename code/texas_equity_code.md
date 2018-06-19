---
title: "Texas Equity Metrics"
author: "Dashiell Young-Saver, Jared Knowles"
date: "Jun 30, 2018"
output: 
  html_document:
    theme: simplex
    css: ../docs/styles.css
    highlight: NULL
    keep_md: true
    toc: true
    toc_depth: 3
    toc_float: true
    number_sections: false
---

# Creating Equity Metrics
*Using Texas state testing data files*
*Programmed in R*

## Getting Started



<div class="navbar navbar-default navbar-fixed-top" id="logo">
<div class="container">
<img src="../img/open_sdp_logo_red.png" style="display: block; margin: 0 auto; height: 115px;">
</div>
</div>

### Objective

In this guide, you will be able to use standard statistics and data visuals to investigate equity in student testing outcomes along lines of race, income, gender, learning differences, English proficiency, and migrancy status.

### Using this Guide

This guide utilizes mock data from Texas's standardized exams (STAAR test, grades 3-8). Therefore, Texas districts can use this code to directly analyze the testing data files they have received from the Texas Education Agency. However, the code can be adapted to any other state or district context in which student testing outcomes are analyzed. 

Once you have identified analyses that you want to try to replicate or modify, click the 
"Download" buttons to download R code and sample data. You can make changes to the 
charts using the code and sample data, or modify the code to work with your own data. If 
you are familiar with Github, you can click "Go to Repository" and clone the entire repository to your own computer. 

Go to the Participate page to read about more ways to engage with the OpenSDP community or reach out for assistance in adapting this code for your specific context.

### About the Data

The data used in this guide was synthetically generated, and it was formatted to match the Texas Education Agency's state test file formats (Texas's file formats can be found here: https://tea.texas.gov/student.assessment/datafileformats). The data has one record per student. Out of the hundreds of features reported for each student by the Texas Education Agency, we used (and retained) the following features in our analysis: student grade level (3-8), school code, student ID, gender, race-ethnicity, economic disadvantage level, Limited English Proficiency level, and scale scores in reading, math, and writing (for the STAAR state test). We also used indicators of whether or not the student attended a Title 1 school, was a migrant, and was enrolled in special education. Here is a key of the features and their variable names in our simulated dataset:

The Texas Education Agency data files have hundreds of features attached to each student record. Coding our analyses with all of these features could get unwieldy, so the best practice is to select the key features we will need for our analyses. If you would like to directly use your own data with the code from this guide, it is best to delete unecessary features and change the headers to the feature names we chose. Below is a legend to the features we chose and how we named them. A more detailed data definition guide can be found in the `man` folder on the Github repository:

| Feature name    | Feature Description                                 |
|:-----------     |:------------------                                  |
| `grade_level`   | Grade level of exam student took (3-8)              |
| `school_code`   | School ID number                                    |
| `sid`           | Student ID number                                   |
| `male`          | Student gender                                      |
| `race_ethnicity`| Student race/ethnicity                              |
| `eco_dis`       | Student level of economic disadvantage              |
| `title_1`       | Indicator if student attends Title 1 school         |
| `migrant`       | Indicator if student is a migrant                   |
| `lep`           | Level of Limited English Proficiency                |
| `iep`           | Indicator if student enrolled in special education  |
| `rdg_ss`        | Scale score for reading exam                        |
| `math_ss`       | Scale score for math exam                           |
| `wrtg_ss`       | Scale score for writing exam                        |  
| `composition`   | Score on writing composition exam                   |

#### Loading the OpenSDP Dataset and R Packages

This guide takes advantage of the OpenSDP synthetic dataset and several key R packages. The first chunk of code below loads the R packages (make sure to install first!), and the second chunk loads the dataset and provides us with variable labels.


```r
library(tidyverse) # main suite of R packages to ease data analysis
library(magrittr) # allows for some easier pipelines of data
library(tidyr) #
library(plyr)
library(dplyr)
library(FSA)
library(ggplot2) # to plot
library(scales) # to format
library(grid)
library(gridExtra) # to plot
# Read in some R functions that are convenience wrappers
source("../R/functions.R")
#pkgTest("devtools")
#pkgTest("OpenSDPsynthR")
```


```r
# // Step 1: Read in csv file of our dataset, naming it "texas.data"
texas.data <- read.csv("../data/synth_texas.csv")  

# // Step 2: View data file
View(texas.data)

# // Step 3: Create a vector of labels for feature names in our dataset 
#These labels will appear in visualizations and tables
labels <- c("Grade","School ID","Student ID","Gender", "Race-Ethnicity",
            "Econ Disadvantage Status","Title 1 Status","Migrancy Status",
            "LEP Status","Spec Ed Enrolled","Reading Score",
            "Math Score","Writing Score","Writing Comp Score")


#Pairs labels with feature names from file
names(labels) <- c("grade_level","school_code","sid","male","race_ethnicity",
                   "eco_dis","title_1","migrant",
                   "lep","iep","rdg_ss",
                   "math_ss","wrtg_ss","composition")
```





### About the Analyses

Especially in larger districts, students may have systematically differing educational outcomes in relation to their various identity markers (race, class, gender, English Language Learner status, etc.). These gaps often present themselves in standardized testing data, at the national, state, and local levels. The following analyses will assist your organization in seeing where gaps may exist and how wide they are, in order to spur and focus the conversation around why the gaps exist and what to do about them.

### Sample Restrictions

One of the most important decisions in running each analysis is defining the sample. 


```r
# Read in global variables for sample restriction
# Agency name
#agency_name <- "Agency"
```

### Giving Feedback on this Guide
 
This guide is an open-source document hosted on Github and generated using R Markdown. We welcome feedback, corrections, additions, and updates. Please visit the OpenSDP equity metrics repository to read our contributor guidelines.

## Analyses

### Descriptive Statistics

**Purpose:** Descriptive statistics give your agency a quick snapshot of current achievement gaps among students, identifying areas for further investigation and analysis.

**Required Analysis File Variables:**

- `grade_level` 
- `school_code` 
- `male`        
- `race_ethnicity` 
- `eco_dis`      
- `title_1`     
- `migrant`     
- `lep`
- `iep`
- `rdg_ss`
- `math_ss`
- `wrtg_ss`
- `composition`

**Ask Yourself**

- How do different study subpopulations in your organization perform on standardized tests? How do they compare?
- Why do these differences occur?
- What differences do you want to explore further?

**Analytic Technique:** Calculate the summary statistics for exam performance, for all 5th and 8th grade exam takers. Note: Once you set which tests and which grade levels you would like to analyze here, the code (as written) will analyze those grade levels and tests for the rest of the guide.

```r
# // Step 1: Set which tested grade levels to analyze (5th and 8th here)
grades <- c("5","8")

# // Step 2: Set which tested subjects to analyze (math and reading here)
subjects <- c("rdg_ss","math_ss")

# // Step 3: Calculate summary stats for each grade level
# Loop over grade level
for(grade in grades){
  
  data = texas.data[texas.data$grade_level == grade,] #Isolates grade level
  print(paste("grade level: ",grade))
  a <- summary(data[,subjects]) #Summary stats table for grade
  colnames(a) <- labels[subjects]  #Label table
  print(a) #Print summary table
  
} #End loop over grade level
```

```
[1] "grade level:  5"
 Reading Score    Math Score       
 Min.   :-545.4   Min.   :-2678.8  
 1st Qu.: 130.8   1st Qu.:  199.8  
 Median : 264.2   Median :  536.8  
 Mean   : 265.0   Mean   :  615.1  
 3rd Qu.: 400.3   3rd Qu.:  954.2  
 Max.   :1224.7   Max.   : 4606.0  
[1] "grade level:  8"
 Reading Score    Math Score       
 Min.   :-497.9   Min.   :-2481.2  
 1st Qu.: 177.6   1st Qu.:  270.0  
 Median : 311.9   Median :  625.5  
 Mean   : 312.4   Mean   :  710.2  
 3rd Qu.: 448.6   3rd Qu.: 1065.5  
 Max.   :1289.5   Max.   : 4821.9  
```

**Analytic Technique:** In order to give us a further sense of the distributions behind these summary statistics, we will create some visualizations of the data. Specifically, here we use box plots and histograms


```r
# // Visualization 1: Box plots
#Loop over tested subjects
for(subject in subjects){
  
  data = texas.data[texas.data$grade_level == grades,] #Isolates 5th and 8th graders
  
    #Set variables and parameters for our boxplot
    p <- ggplot(data, aes(x=as.factor(grade_level), y=data[,subject])) + 
          geom_boxplot() +
          ggtitle(paste(labels[subject], ", by Grade Level")) +
          scale_y_continuous(name=labels[subject]) +
          scale_x_discrete(name="Grade Level")
    print(p) 
    

} #End loop over tested subjects
```

<img src="../figure/E_VisualizeTotals-1.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeTotals-2.png" style="display: block; margin: auto;" />

```r
# // Comparison 2: Histograms of scores for eco_dis students
#Loop over grade levels
for(grade in grades){
  
  data = texas.data[texas.data$grade_level == grade,] #Isolates grade level
  
  #Loop over tested subject
  for(subject in subjects){ 
    #Set variables and parameters for our boxplot
    p <- ggplot(data, aes(x=data[,subject])) + 
          ggtitle(paste("Grade: ",grade,", ",labels[subject], " (all students)"))+
          geom_histogram(alpha = 0.5, binwidth = 50, fill = "dodgerblue", color = "dodgerblue") + 
          scale_x_continuous(name=paste(labels[subject])) 
    print(p) 
    
  } #End loop over tested subject
} #End loop over grade level
```

<img src="../figure/E_VisualizeTotals-3.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeTotals-4.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeTotals-5.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeTotals-6.png" style="display: block; margin: auto;" />

**Analytic Technique:** Now that we have some measures for the performance on exams among all of our students, we can create those same measures for our various subpopulations of students. We will start by comparing descriptive statistics among different student demographic populations (income, race, and gender).


```r
# // Step 1: Initialize Demographics to Analyze
#Vector with features we want to analyze: Econ Disadvantage, Race Ethnicity, Gender
dems <- c("eco_dis","race_ethnicity","male")

# // Comparisons: Generating summary stats for Eco Dis, Race Ethnicity, and Gender
#Loop over grade levels
for(grade in grades){
  
  data = texas.data[texas.data$grade_level == grade,] #Isolates grade level
  
  #Loop over tested subject
  for(subject in subjects){
    
    print(paste("Grade: ",grade,", ",labels[subject])) #Print subject and grade level
    
    #Loop over demographic features
    for(dem in dems){
      
      a<-Summarize(data[,subject] ~ data[,dem]) #Makes comparison table
      colnames(a)[1] <- labels[dem] #Labels comparison table
      print(a) #Prints comparison table
      
    } #End loop over demogrpahic features
    
  } #End loop over tested subject
  
} #End loop over grade level
```

```
[1] "Grade:  5 ,  Reading Score"
  Econ Disadvantage Status     n     mean       sd    min  Q1 median    Q3  max
1                        0 31650 266.0917 201.5706 -534.0 132  264.4 401.9 1135
2                        1 18537 263.0128 201.2255 -545.4 128  264.1 397.4 1225
                             Race-Ethnicity     n     mean       sd     min
1          American Indian or Alaska Native   354 257.5892 196.4762 -465.70
2                                     Asian  2451 278.8205 208.7169 -460.30
3                 Black or African American  6199 259.3710 203.0171 -545.40
4        Demographic Race Two or More Races  1066 269.0954 198.2896 -365.30
5              Hispanic or Latino Ethnicity  8272 267.0831 201.8443 -456.00
6 Native Hawaiian or Other Pacific Islander    72 317.6098 188.0882  -16.59
7                                     White 31773 264.2438 200.5958 -534.00
     Q1 median    Q3    max
1 111.3  258.3 381.3  830.3
2 139.5  277.1 421.6  945.5
3 121.1  258.2 397.5 1129.0
4 132.0  269.1 406.2 1225.0
5 133.4  268.1 400.1  987.1
6 183.7  294.6 416.9  800.0
7 130.9  263.2 398.9 1170.0
  Gender     n     mean       sd    min    Q1 median    Q3  max
1 Female 24344 265.7453 201.0299 -534.0 131.5  264.9 401.2 1170
2   Male 25843 264.2095 201.8396 -545.4 129.8  263.5 399.0 1225
[1] "Grade:  5 ,  Math Score"
  Econ Disadvantage Status     n     mean       sd   min    Q1 median    Q3
1                        0 31650 617.1197 604.9358 -1866 199.8  538.7 958.8
2                        1 18537 611.7395 596.4073 -2679 200.0  533.4 945.4
   max
1 4445
2 4606
                             Race-Ethnicity     n     mean       sd     min
1          American Indian or Alaska Native   354 585.6512 565.5531 -1340.0
2                                     Asian  2451 649.2518 620.1701 -1236.0
3                 Black or African American  6199 603.5025 599.2157 -2679.0
4        Demographic Race Two or More Races  1066 619.4379 587.7379 -1062.0
5              Hispanic or Latino Ethnicity  8272 616.0075 598.8102 -1895.0
6 Native Hawaiian or Other Pacific Islander    72 730.2251 582.7930  -153.2
7                                     White 31773 614.4649 602.4646 -2010.0
     Q1 median     Q3  max
1 199.8  492.5  927.0 2627
2 229.2  564.2  986.6 3762
3 185.0  523.7  952.3 3888
4 213.3  532.1  941.7 3044
5 208.6  538.5  950.0 4272
6 325.1  624.0 1005.0 2364
7 197.8  536.6  953.5 4606
  Gender     n     mean       sd   min    Q1 median    Q3  max
1 Female 24344 613.5182 600.0064 -2010 198.9  536.2 949.7 4606
2   Male 25843 616.6530 603.4913 -2679 200.9  537.5 958.9 4445
[1] "Grade:  8 ,  Reading Score"
  Econ Disadvantage Status     n     mean       sd    min    Q1 median    Q3
1                        0 32290 314.0757 202.4790 -497.1 179.0  313.0 449.8
2                        1 17898 309.4325 202.0173 -497.9 174.9  309.9 446.0
   max
1 1159
2 1290
                             Race-Ethnicity     n     mean       sd     min
1          American Indian or Alaska Native   356 305.9883 196.8412 -433.20
2                                     Asian  2449 325.1233 209.1188 -412.80
3                 Black or African American  6196 307.0588 203.6341 -497.90
4        Demographic Race Two or More Races  1065 315.8640 198.8154 -300.60
5              Hispanic or Latino Ethnicity  8263 314.1816 202.8339 -415.50
6 Native Hawaiian or Other Pacific Islander    72 363.1799 188.3806   31.07
7                                     White 31787 311.8698 201.5648 -497.10
     Q1 median    Q3    max
1 167.7  303.6 421.3  855.8
2 186.0  322.4 467.8  987.9
3 167.9  309.3 445.6 1169.0
4 183.5  318.6 453.7 1290.0
5 180.4  314.7 448.8 1019.0
6 238.9  335.3 470.5  843.6
7 177.7  310.4 447.8 1195.0
  Gender     n     mean       sd    min    Q1 median    Q3  max
1 Female 24356 313.2493 201.9476 -497.1 178.4    313 449.5 1192
2   Male 25832 311.6378 202.6803 -497.9 176.6    311 447.5 1290
[1] "Grade:  8 ,  Math Score"
  Econ Disadvantage Status     n     mean       sd   min    Q1 median   Q3  max
1                        0 32290 714.8031 630.5780 -1788 270.2  628.3 1072 4655
2                        1 17898 702.0119 615.9986 -2481 269.9  620.9 1054 4822
                             Race-Ethnicity     n     mean       sd     min
1          American Indian or Alaska Native   356 681.7163 588.2992 -1280.0
2                                     Asian  2449 741.7295 643.0427 -1146.0
3                 Black or African American  6196 700.6656 622.4377 -2481.0
4        Demographic Race Two or More Races  1065 713.2967 612.2081  -883.1
5              Hispanic or Latino Ethnicity  8263 709.7394 622.1026 -1701.0
6 Native Hawaiian or Other Pacific Islander    72 822.6888 611.4625  -174.3
7                                     White 31787 709.7751 626.3405 -1788.0
     Q1 median   Q3  max
1 265.9  585.5 1060 2705
2 303.5  654.7 1095 3987
3 256.1  613.2 1067 4125
4 283.0  634.2 1062 3179
5 276.3  630.3 1053 4517
6 410.5  736.5 1143 2513
7 268.0  625.0 1065 4822
  Gender     n     mean       sd   min    Q1 median   Q3  max
1 Female 24356 708.1860 623.8962 -1788 269.2  624.7 1060 4822
2   Male 25832 712.1797 626.9010 -2481 271.0  625.9 1071 4655
```

**Analytic Technique:** In addition to these raw numbers, it will help to visualize these comparisons, to give us a sense of scale and shape in these gaps. To do so, we will use both box plots and histograms.


```r
# // Step 1: Initialize a set of distinguishable colors for graphics
colors <- c("red","dodgerblue3","green","coral","violet","burlywood2","grey68")

# // Comparison: Box plots and histograms of scores for Econ Disadvantage, Race, and Gender
#Loop over grade levels
for(grade in grades){
  
  data = texas.data[texas.data$grade_level == grade,] #Isolates grade level
  
  #Loop over tested subject
  for(subject in subjects){
    
    #Loop over demographic features
    for(dem in dems){
      
        #Set variables and parameters for our boxplot
        bp <- ggplot(data, aes(x=as.factor(data[,dem]), y=data[,subject])) + 
              geom_boxplot() +
              ggtitle(paste("Grade: ",grade,", ", labels[subject],", by ",labels[dem])) +
              scale_y_continuous(name=labels[subject]) +
              scale_x_discrete(name=labels[dem])
        print(bp) #Print box plot
        
        #Set variables and parameters for our histogram
        h <- ggplot(data, aes(x=data[,subject], fill = as.factor(data[,dem]))) + 
              ggtitle(paste("Grade: ",grade,", ", labels[subject],", by ",labels[dem]))+
              geom_histogram(alpha = 0.5, binwidth = 50) + 
              scale_fill_manual(name=labels[dem],
                                values=colors[1:length(levels(as.factor(data[,dem])))])+
              scale_x_continuous(name=paste(labels[subject], ", Grade", grade)) 
        print(h) #Print histogram
      
    }#End loop over demographic features
    
  } #End loop over tested subject
  
} #End loop over grade level
```

<img src="../figure/E_VisualizeEcoDis-1.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeEcoDis-2.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeEcoDis-3.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeEcoDis-4.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeEcoDis-5.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeEcoDis-6.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeEcoDis-7.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeEcoDis-8.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeEcoDis-9.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeEcoDis-10.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeEcoDis-11.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeEcoDis-12.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeEcoDis-13.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeEcoDis-14.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeEcoDis-15.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeEcoDis-16.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeEcoDis-17.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeEcoDis-18.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeEcoDis-19.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeEcoDis-20.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeEcoDis-21.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeEcoDis-22.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeEcoDis-23.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeEcoDis-24.png" style="display: block; margin: auto;" />


**Analytic Technique:** Next we will extend these comparisons to different student status populations, in relation to special education, migrancy status, and LEP status. It's the same code, but now we just change our demographic indicators to the new ones we'd like to analyze (how convenient!). We start with the descriptive statistics in this first chunk, then move to visualizations in the next chunk.


```r
# // Step 1: Initialize Demographics to Analyze
#Vector with features we want to analyze: Special Education, Migrancy, and LEP Status
##NOTE MIGRANCY DATA JUST 'NAs' SO NOT INCLUDED YET IN ANALYSIS##
dems <- c("iep","lep")

# // Comparisons: Generating summary stats for Spec Ed, Migrancy, and LEP
#Loop over grade levels
for(grade in grades){
  
  data = texas.data[texas.data$grade_level == grade,] #Isolates grade level
  
  #Loop over tested subject
  for(subject in subjects){
    
    print(paste("Grade: ",grade,", ",labels[subject])) #Print subject and grade level
    
    #Loop over demographic features
    for(dem in dems){
      
      a<-Summarize(data[,subject] ~ data[,dem]) #Makes comparison table
      colnames(a)[1] <- labels[dem] #Labels comparison table
      print(a) #Prints comparison table
      
    } #End loop over demogrpahic features
    
  } #End loop over tested subject
  
} #End loop over grade level
```

```
[1] "Grade:  5 ,  Reading Score"
  Spec Ed Enrolled     n     mean       sd    min    Q1 median    Q3  max
1                0 41035 265.3136 201.1999 -534.0 131.4  264.9 400.6 1225
2                1  9152 263.3444 202.5527 -545.4 127.5  262.1 398.8 1017
  LEP Status     n     mean       sd    min    Q1 median    Q3  max
1          0 46610 264.9881 201.4374 -545.4 130.9  264.2 400.3 1225
2          1  3577 264.5164 201.5948 -529.7 127.6  264.4 400.2 1170
[1] "Grade:  5 ,  Math Score"
  Spec Ed Enrolled     n     mean       sd   min    Q1 median    Q3  max
1                0 41035 615.2123 600.9117 -2010 200.2  536.8 954.4 4606
2                1  9152 614.7744 605.7967 -2679 197.2  537.4 953.0 3762
  LEP Status     n     mean       sd   min    Q1 median    Q3  max
1          0 46610 615.0614 601.9573 -2679 199.8  537.4 953.9 4606
2          1  3577 616.0583 599.8229 -1289 200.3  527.7 958.8 3467
[1] "Grade:  8 ,  Reading Score"
  Spec Ed Enrolled     n     mean       sd    min    Q1 median    Q3  max
1                0 39161 312.6652 202.0395 -497.1 178.3  312.1 448.4 1290
2                1 11027 311.5484 203.3411 -497.9 175.5  311.1 449.3 1073
  LEP Status     n     mean       sd    min    Q1 median    Q3  max
1          0 46066 312.1641 202.2760 -497.9 177.5  311.6 448.2 1290
2          1  4122 315.2784 202.8703 -438.6 179.8  315.5 454.4 1192
[1] "Grade:  8 ,  Math Score"
  Spec Ed Enrolled     n     mean       sd   min    Q1 median   Q3  max
1                0 39161 709.7893 624.3217 -1788 269.4  624.9 1066 4822
2                1 11027 711.8476 629.4282 -2481 272.0  627.8 1064 4517
  LEP Status     n     mean       sd   min    Q1 median   Q3  max
1          0 46066 709.8335 625.5590 -2481 269.0  625.9 1065 4822
2          1  4122 714.8019 624.1848 -1129 280.7  621.1 1073 4517
```

Now for visualizations:


```r
# // Comparison: Box plots and histograms of scores for Special Education, Migrancy, and LEP Status
#Loop over grade levels
for(grade in grades){
  
  data = texas.data[texas.data$grade_level == grade,] #Isolates grade level
  
  #Loop over tested subject
  for(subject in subjects){
    
    #Loop over demographic features
    for(dem in dems){
      
        #Set variables and parameters for our boxplot
        bp <- ggplot(data, aes(x=as.factor(data[,dem]), y=data[,subject])) + 
              geom_boxplot() +
              ggtitle(paste("Grade: ",grade,", ", labels[subject],", by ",labels[dem])) +
              scale_y_continuous(name=labels[subject]) +
              scale_x_discrete(name=labels[dem])
        print(bp) #Print box plot
        
        #Set variables and parameters for our histogram
        h <- ggplot(data, aes(x=data[,subject], fill = as.factor(data[,dem]))) + 
              ggtitle(paste("Grade: ",grade,", ", labels[subject],", by ",labels[dem]))+
              geom_histogram(alpha = 0.5, binwidth = 50) + 
              scale_fill_manual(name=labels[dem],
                                values=colors[1:length(levels(as.factor(data[,dem])))])+
              scale_x_continuous(name=paste(labels[subject], ", Grade", grade)) 
        print(h) #Print histogram
      
    }#End loop over demographic features
    
  } #End loop over tested subject
  
} #End loop over grade level
```

<img src="../figure/E_VisualizeStatus-1.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeStatus-2.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeStatus-3.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeStatus-4.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeStatus-5.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeStatus-6.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeStatus-7.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeStatus-8.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeStatus-9.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeStatus-10.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeStatus-11.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeStatus-12.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeStatus-13.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeStatus-14.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeStatus-15.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeStatus-16.png" style="display: block; margin: auto;" />

**Analytic Technique:** Often, it can be helpful to look at the intersections of the demographic data we pulled. In particular, exploring possible gaps among combinations of race, socioeconomic status, gender, and student label status (LEP, Spec Ed, Migrancy, etc.) can elucidate further achievement gaps in the data. Here, we will explore two intersections: race-ethnicity and gender as well as socioeconomic status and special education enrollment.

We start with descriptive statistics:


```r
# // Analysis 1: Comparing within groups--Gender gaps within race

#Set the feature you would like to compare within
group.by <- "race_ethnicity"

#Set the feature you are comparing
compare.by <- "male"

# Loop over grade levels
for(grade in grades){
  
  data = texas.data[texas.data$grade_level == grade,] #Isolates grade level
  res <- levels(as.factor(data[,group.by])) #All the different race-ethnicities we will explore
  
  #Loop over tested subject
  for(subject in subjects){
    
    print(paste("Grade: ",grade,", ",labels[subject])) #Print subject and grade level
    
    #Loop over race-ethnicities
    for(re in res){
      
      #Isolates observations from particular race-ethnicity
      data.res <- data[data[,group.by]==re,]
      
      #Makes comparison table across genders within each race-ethnicity group
      a<-Summarize(data.res[,subject] ~ data.res[,compare.by]) #Makes comparison table
      colnames(a)[1] <- labels[compare.by]
      print(paste(labels[group.by],": ",re))
      print(a) #Prints comparison table
      
    } #End loop over race-ethnicities
    
    cat("\n\n") #spacer line
    
  } #End loop over tested subject
  
} #End loop over grade level
```

```
[1] "Grade:  5 ,  Reading Score"
[1] "Race-Ethnicity :  American Indian or Alaska Native"
  Gender   n     mean       sd    min    Q1 median    Q3   max
1 Female 173 264.9333 205.4628 -465.7 123.5  253.4 392.4 759.9
2   Male 181 250.5697 187.7883 -160.7 107.8  262.8 364.3 830.3
[1] "Race-Ethnicity :  Asian"
  Gender    n     mean       sd    min    Q1 median    Q3   max
1 Female 1205 276.5619 207.3077 -378.2 136.7  274.4 414.7 849.9
2   Male 1246 281.0048 210.1308 -460.3 143.0  278.5 426.7 945.5
[1] "Race-Ethnicity :  Black or African American"
  Gender    n     mean       sd    min    Q1 median    Q3  max
1 Female 2962 261.8883 203.0079 -447.2 124.7  262.4 399.5 1017
2   Male 3237 257.0675 203.0296 -545.4 117.4  255.6 395.6 1129
[1] "Race-Ethnicity :  Demographic Race Two or More Races"
  Gender   n     mean       sd    min    Q1 median    Q3    max
1 Female 519 277.0407 199.8005 -285.8 134.8  279.0 416.6  877.6
2   Male 547 261.5569 196.7313 -365.3 132.1  262.3 393.3 1225.0
[1] "Race-Ethnicity :  Hispanic or Latino Ethnicity"
  Gender    n     mean       sd    min    Q1 median    Q3   max
1 Female 3990 266.6916 199.8802 -443.3 136.1  266.5 399.2 913.5
2   Male 4282 267.4480 203.6800 -456.0 131.0  269.4 400.2 987.1
[1] "Race-Ethnicity :  Native Hawaiian or Other Pacific Islander"
  Gender  n     mean       sd     min    Q1 median    Q3   max
1 Female 36 319.5892 195.1809 -16.590 218.6  262.1 425.1 800.0
2   Male 36 315.6305 183.4705  -4.068 180.0  313.5 413.1 675.8
[1] "Race-Ethnicity :  White"
  Gender     n     mean       sd    min    Q1 median    Q3  max
1 Female 15459 264.9015 200.4312 -534.0 130.9  264.1 400.5 1170
2   Male 16314 263.6206 200.7558 -508.6 131.0  262.3 397.6 1135


[1] "Grade:  5 ,  Math Score"
[1] "Race-Ethnicity :  American Indian or Alaska Native"
  Gender   n     mean       sd     min    Q1 median    Q3  max
1 Female 173 573.5019 550.3889 -1340.0 199.6  484.3 906.3 2349
2   Male 181 597.2636 580.9648  -641.2 200.5  514.8 964.5 2627
[1] "Race-Ethnicity :  Asian"
  Gender    n     mean       sd   min    Q1 median    Q3  max
1 Female 1205 646.1932 613.3926 -1055 226.9  569.5 981.1 3281
2   Male 1246 652.2097 626.8868 -1236 230.2  560.7 987.2 3762
[1] "Race-Ethnicity :  Black or African American"
  Gender    n     mean       sd   min    Q1 median    Q3  max
1 Female 2962 611.2126 602.8132 -1482 189.0  529.9 953.6 3201
2   Male 3237 596.4474 595.9106 -2679 179.2  516.0 949.5 3888
[1] "Race-Ethnicity :  Demographic Race Two or More Races"
  Gender   n     mean       sd   min    Q1 median    Q3  max
1 Female 519 645.8481 611.5013 -1062 212.2  552.4 980.2 2780
2   Male 547 594.3796 563.6841 -1039 217.3  515.6 907.5 3044
[1] "Race-Ethnicity :  Hispanic or Latino Ethnicity"
  Gender    n     mean       sd   min    Q1 median    Q3  max
1 Female 3990 610.8442 590.4863 -1551 210.4  536.8 938.4 4200
2   Male 4282 620.8186 606.4930 -1895 207.8  540.2 961.5 4272
[1] "Race-Ethnicity :  Native Hawaiian or Other Pacific Islander"
  Gender  n     mean       sd     min    Q1 median     Q3  max
1 Female 36 650.3791 491.1650 -153.20 333.3  580.7  931.7 2103
2   Male 36 810.0711 659.2735  -37.93 317.3  689.6 1135.0 2364
[1] "Race-Ethnicity :  White"
  Gender     n     mean       sd   min    Q1 median    Q3  max
1 Female 15459 611.3798 601.2078 -2010 194.6  534.0 946.2 4606
2   Male 16314 617.3883 603.6569 -1866 201.2  539.1 958.5 4445


[1] "Grade:  8 ,  Reading Score"
[1] "Race-Ethnicity :  American Indian or Alaska Native"
  Gender   n     mean       sd    min    Q1 median    Q3   max
1 Female 174 312.1718 206.9839 -433.2 181.3  302.9 432.5 817.1
2   Male 182 300.0766 187.0128 -128.0 155.0  307.6 414.8 855.8
[1] "Race-Ethnicity :  Asian"
  Gender    n     mean       sd    min    Q1 median    Q3   max
1 Female 1208 323.0186 208.3553 -336.5 181.8  322.0 463.4 906.6
2   Male 1241 327.1720 209.9229 -412.8 191.3  322.8 471.2 987.9
[1] "Race-Ethnicity :  Black or African American"
  Gender    n     mean       sd    min    Q1 median    Q3  max
1 Female 2959 309.5911 203.9190 -413.5 170.9  313.4 447.5 1073
2   Male 3237 304.7440 203.3773 -497.9 165.6  304.8 443.5 1169
[1] "Race-Ethnicity :  Demographic Race Two or More Races"
  Gender   n     mean       sd    min    Q1 median    Q3    max
1 Female 518 324.4013 200.8833 -215.6 189.1  325.8 466.6  928.8
2   Male 547 307.7793 196.6793 -300.6 181.6  309.4 438.6 1290.0
[1] "Race-Ethnicity :  Hispanic or Latino Ethnicity"
  Gender    n     mean       sd    min    Q1 median    Q3    max
1 Female 3989 314.0410 200.8283 -385.5 182.6  313.5 448.5  981.8
2   Male 4274 314.3128 204.7115 -415.5 178.2  315.7 448.9 1019.0
[1] "Race-Ethnicity :  Native Hawaiian or Other Pacific Islander"
  Gender  n     mean       sd   min    Q1 median    Q3   max
1 Female 36 363.8570 194.6912 31.07 258.7  309.5 468.2 843.6
2   Male 36 362.5028 184.6153 39.56 231.6  359.0 470.5 727.3
[1] "Race-Ethnicity :  White"
  Gender     n     mean       sd    min    Q1 median    Q3  max
1 Female 15472 312.5030 201.3299 -497.1 177.7  311.3 448.7 1192
2   Male 16315 311.2693 201.7916 -460.5 177.8  309.8 446.8 1195


[1] "Grade:  8 ,  Math Score"
[1] "Race-Ethnicity :  American Indian or Alaska Native"
  Gender   n     mean       sd     min    Q1 median   Q3  max
1 Female 174 661.8594 573.0826 -1280.0 264.0  594.3 1022 2450
2   Male 182 700.7003 603.4549  -468.5 269.9  582.8 1092 2705
[1] "Race-Ethnicity :  Asian"
  Gender    n     mean       sd     min    Q1 median   Q3  max
1 Female 1208 739.2915 638.0390  -916.2 295.7  651.5 1093 3590
2   Male 1241 744.1027 648.1247 -1146.0 307.3  656.7 1107 3987
[1] "Race-Ethnicity :  Black or African American"
  Gender    n    mean       sd   min    Q1 median   Q3  max
1 Female 2959 708.209 627.9286 -1414 266.4  615.1 1068 3494
2   Male 3237 693.770 617.3921 -2481 246.4  609.0 1066 4125
[1] "Race-Ethnicity :  Demographic Race Two or More Races"
  Gender   n     mean       sd    min    Q1 median   Q3  max
1 Female 518 741.7711 639.5891 -876.4 280.5  643.3 1092 3003
2   Male 547 686.3318 584.4080 -883.1 289.2  624.5 1012 3179
[1] "Race-Ethnicity :  Hispanic or Latino Ethnicity"
  Gender    n     mean       sd   min    Q1 median   Q3  max
1 Female 3989 704.0126 612.5593 -1388 278.5  630.1 1044 4493
2   Male 4274 715.0843 630.9041 -1701 274.7  631.1 1065 4517
[1] "Race-Ethnicity :  Native Hawaiian or Other Pacific Islander"
  Gender  n     mean       sd     min    Q1 median   Q3  max
1 Female 36 735.8747 514.4615 -174.30 410.5  706.2 1026 2248
2   Male 36 909.5029 691.5782  -24.75 415.6  803.3 1226 2513
[1] "Race-Ethnicity :  White"
  Gender     n     mean       sd   min    Q1 median   Q3  max
1 Female 15472 706.1611 625.1439 -1788 264.5  623.0 1058 4822
2   Male 16315 713.2024 627.4732 -1646 271.4  625.9 1073 4655
```

```r
# // Analysis 2: Comparing proportions enrolled in a program
#This analysis will compare what percentage of each econ_dis category has an IEP
#First will look at proportions among all grade levels
cont.table <- with(texas.data, table(eco_dis,iep))

cont.table #Frequency table
```

```
       iep
eco_dis      0      1
      0 206264  49696
      1 114756  31306
```

```r
round(prop.table(cont.table,1)*100) #Proportion contingency table
```

```
       iep
eco_dis  0  1
      0 81 19
      1 79 21
```

```r
#Now we will look at proportions within grade levels
#Loop over grade levels
for(grade in grades){
  
  data = texas.data[texas.data$grade_level == grade,] #Isolates grade level
  
  print(paste("Grade: ",grade)) #Print grade level
  
  cont.table <- with(data, table(eco_dis,iep))
  print(cont.table) #Frequency table
  print(round(prop.table(cont.table,1)*100)) #Proportion contingency table
  
} #End loop over grade level
```

```
[1] "Grade:  5"
       iep
eco_dis     0     1
      0 26166  5484
      1 14869  3668
       iep
eco_dis  0  1
      0 83 17
      1 80 20
[1] "Grade:  8"
       iep
eco_dis     0     1
      0 25319  6971
      1 13842  4056
       iep
eco_dis  0  1
      0 78 22
      1 77 23
```

```r
# // Analysis 3: Comparing within groups--Special Ed gaps within Socioeconomic levels
#Note: same code as analysis 1, just with different set features in first lines
#Set the feature you would like to compare within
group.by <- "eco_dis"

#Set the feature you are comparing
compare.by <- "iep"

# Loop over grade levels
for(grade in grades){
  
  data = texas.data[texas.data$grade_level == grade,] #Isolates grade level
  res <- levels(as.factor(data[,group.by])) #All the different levels of economic disadvantage
  
  #Loop over tested subject
  for(subject in subjects){
    
    print(paste("Grade: ",grade,", ",labels[subject])) #Print subject and grade level
    
    #Loop over levels of econ-dis
    for(re in res){
      
      #Isolates observations from particular econ-dis level
      data.res <- data[data[,group.by]==re,]
      
      #Makes comparison table for special ed enrollemnt within econ-dis level
      a<-Summarize(data.res[,subject] ~ data.res[,compare.by]) #Makes comparison table
      colnames(a)[1] <- labels[compare.by]
      print(paste(labels[group.by],": ",re))
      print(a) #Prints comparison table
      
    } #End loop over econ-dis level
    
    cat("\n\n") #spacer line
    
  } #End loop over tested subject
  
} #End loop over grade level
```

```
[1] "Grade:  5 ,  Reading Score"
[1] "Econ Disadvantage Status :  0"
  Spec Ed Enrolled     n     mean       sd    min    Q1 median    Q3  max
1                0 26166 266.4511 200.8984 -534.0 132.3  265.3 402.1 1135
2                1  5484 264.3765 204.7574 -447.2 129.7  261.1 400.3 1017
[1] "Econ Disadvantage Status :  1"
  Spec Ed Enrolled     n     mean       sd    min    Q1 median    Q3    max
1                0 14869 263.3117 201.7206 -529.7 128.8  264.2 397.6 1225.0
2                1  3668 261.8012 199.2288 -545.4 124.7  263.0 396.3  912.3


[1] "Grade:  5 ,  Math Score"
[1] "Econ Disadvantage Status :  0"
  Spec Ed Enrolled     n     mean       sd   min    Q1 median    Q3  max
1                0 26166 617.1286 602.9950 -1866 200.6  539.6 958.8 4445
2                1  5484 617.0771 614.1672 -1637 194.4  534.7 958.9 3762
[1] "Econ Disadvantage Status :  1"
  Spec Ed Enrolled     n     mean       sd   min    Q1 median    Q3  max
1                0 14869 611.8401 597.2333 -2010 199.5  531.7 946.0 4606
2                1  3668 611.3318 593.1283 -2679 204.7  540.6 943.1 3187


[1] "Grade:  8 ,  Reading Score"
[1] "Econ Disadvantage Status :  0"
  Spec Ed Enrolled     n     mean       sd    min    Q1 median    Q3  max
1                0 25319 313.8641 201.9544 -497.1 178.9  312.8 448.9 1159
2                1  6971 314.8442 204.3856 -413.5 179.1  314.2 453.6 1073
[1] "Econ Disadvantage Status :  1"
  Spec Ed Enrolled     n     mean       sd    min    Q1 median    Q3    max
1                0 13842 310.4723 202.1839 -495.3 177.1  310.9 447.5 1290.0
2                1  4056 305.8840 201.4323 -497.9 168.8  306.9 440.3  987.9


[1] "Grade:  8 ,  Math Score"
[1] "Econ Disadvantage Status :  0"
  Spec Ed Enrolled     n     mean       sd   min    Q1 median   Q3  max
1                0 25319 712.7167 628.6020 -1788 269.1  626.4 1070 4655
2                1  6971 722.3812 637.6912 -1476 277.4  634.4 1079 3987
[1] "Econ Disadvantage Status :  1"
  Spec Ed Enrolled     n     mean       sd   min    Q1 median   Q3  max
1                0 13842 704.4347 616.4021 -1650 271.0  622.2 1060 4822
2                1  4056 693.7438 614.6234 -2481 267.6  614.4 1037 4517
```

We continue with data visuals:


```r
# // Comparison: Box plots and histograms of scores comparing gender within race-ethnicity

#Set the feature you would like to compare within
group.by <- "race_ethnicity"

#Set the feature you are comparing
compare.by <- "male"

#Loop over grade levels
for(grade in grades){
  
  data = texas.data[texas.data$grade_level == grade,] #Isolates grade level
  res <- levels(as.factor(data[,group.by])) #All the different race-ethnicities we will explore
  
  #Loop over tested subject
  for(subject in subjects){
    
    #Loop over demographic features
    for(re in res){
      
        #Isolates observations from particular race-ethnicity
        data.res <- data[data[,group.by]==re,]
      
        #Set variables and parameters for our boxplot
        bp <- ggplot(data.res, aes(x=as.factor(data.res[,compare.by]), y=data.res[,subject])) + 
              geom_boxplot() +
              ggtitle(paste("Grade: ",grade,", ", labels[subject],", ",re)) +
              scale_y_continuous(name=labels[subject]) +
              scale_x_discrete(name=labels[compare.by])
        print(bp) #Print box plot
        
        #Set variables and parameters for our histogram
        h <- ggplot(data.res, aes(x=data.res[,subject], fill = as.factor(data.res[,compare.by]))) + 
              ggtitle(paste("Grade: ",grade,", ", labels[subject],", ",re))+
              geom_histogram(alpha = 0.5, binwidth = 50) + 
              scale_fill_manual(name=labels[compare.by],
                                values=colors[1:length(levels(as.factor(data.res[,compare.by])))])+
              scale_x_continuous(name=paste(labels[subject], ", Grade", grade)) 
        print(h) #Print histogram
      
    }#End loop over race-ethnicity
    
  } #End loop over tested subject
  
} #End loop over grade level
```

<img src="../figure/E_VisualizeCombos-1.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-2.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-3.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-4.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-5.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-6.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-7.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-8.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-9.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-10.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-11.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-12.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-13.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-14.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-15.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-16.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-17.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-18.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-19.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-20.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-21.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-22.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-23.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-24.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-25.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-26.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-27.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-28.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-29.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-30.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-31.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-32.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-33.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-34.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-35.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-36.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-37.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-38.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-39.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-40.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-41.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-42.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-43.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-44.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-45.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-46.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-47.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-48.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-49.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-50.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-51.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-52.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-53.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-54.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-55.png" style="display: block; margin: auto;" /><img src="../figure/E_VisualizeCombos-56.png" style="display: block; margin: auto;" />

**Possible Next Steps or Action Plans:** Do this for more and/or different grade levels.

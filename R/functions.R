# Packages
library(tidyverse)

###Explores dataset to find widest achievement gaps
##Outputs list of 40 largest achievement gaps (computd by standardized mean difference)
#data = dataset to explore, should be wide format and have column for grade level (class: data frame)
#grade = name of tested grade column in datasets (class: character)
#outcome = name of outcome variable (usually test scores) in datasets (class: character)
#features = vector of features in dataset where testing for gaps (class: character)
#sds = dataframe containing the standard deviations for all test (class: data frame)
##Begin function
gap.test <- function(df, grade, outcome, features, sds) {
  
  #Convert features to factors
  df[,features] <- lapply(df[,features], as.character)
  df[,features] <- lapply(df[,features], as.factor)
  df[,features]
  
  #Get all grade levels for the chosen tested subject
  grades <- sds[!is.na(sds[,outcome]),grade]
  
  #Will store all calculated achievement gaps
  gaps <- vector()
  
  #Loop over grade levels
  for(gr in grades){
    
    #Break down data by grade
    dat.grade <- df[df[,grade]==gr,]
    
    #Get standard deviation for scale scores at that grade level
    sd <- sds[sds[,grade]==gr,outcome]
    
    #Loop over features
    for(feature in features){
      
      #Get levels of feature
      lvl <- levels(dat.grade[,feature])
      
      #Get matrix of all combos of levels
      com.lvl <- combn(lvl,2)
      
      #Loop over combinations
      for(i in 1:dim(com.lvl)[2]){
        
        #Get levels you will compare gaps for
        level1 <- com.lvl[1,i]
        level2 <- com.lvl[2,i]
        
        #Measure gap (in terms of standardized median difference)
        level1.data <- dat.grade[dat.grade[,feature]==level1,outcome]
        level2.data <- dat.grade[dat.grade[,feature]==level2,outcome]
        gap <- (median(level1.data) - median(level2.data))/sd
        
        #Append gap to list and name in
        gaps <- append(gaps,gap,length(gaps))
        names(gaps)[length(gaps)] <- paste(level1,"-",level2,feature,gr,outcome)
        
        
      } #End loop over combinations
      
    } #End loop over features
    
  } #End loop over grade levels
  
  #Sort gaps largest to smallest in magnitude
  sorted <- gaps[order(abs(gaps), decreasing=TRUE)]
  
  #Prints 40 largest gaps
  print(sorted[1:40])
  
}#End function

#Download data to test function with and standard deviations
texas.data<-read.csv("../data/synth_texas.csv")
standard.devs <- read.csv("../data/sd_table.csv")


#Function test
gap.test(df=texas.data,
         grade="grade_level",
         outcome="rdg_ss",
         features=c('eco_dis','lep','iep','race_ethnicity','male'),
         sds=standard.devs)


# R Function for Task 1
# Derive the mode in a stata friendly fashion
statamode <- function(x) {
  z <- table(as.vector(x))
  m <- suppressMessages(suppressWarnings(names(z)[z == max(z)]))
  if(length(m)==1){
    return(m)
  }
  return(".")
}

# distinct values function
nvals <- function(x){
  length(unique(x))
}

# Replace all missing values in a vector with a numeric 0
zeroNA <- function(x){
  x[is.na(x)] <- 0
  return(x)
}

# Cluster standard errors
get_CL_vcov <- function(model, cluster){
  # cluster is an actual vector of clusters from data passed to model
  # from: http://rforpublichealth.blogspot.com/2014/10/easy-clustered-standard-errors-in-r.html
  require(sandwich, quietly = TRUE)
  require(lmtest, quietly = TRUE)
  cluster <- as.character(cluster)
  # calculate degree of freedom adjustment
  M <- length(unique(cluster))
  N <- length(cluster)
  K <- model$rank
  dfc <- (M/(M-1))*((N-1)/(N-K))
  # calculate the uj's
  uj  <- apply(estfun(model), 2, function(x) tapply(x, cluster, sum))
  # use sandwich to get the var-covar matrix
  vcovCL <- dfc*sandwich(model, meat=crossprod(uj)/N)
  return(vcovCL)
}

# Convert SATtoACT
# x is a vector of act scores
ACTtoSAT <- function(x){
  x[is.na(x)] <- 400
  x[x  <  11] <- 400
  x[x == 11] <- 530
  x[x == 12] <- 590
  x[x == 13] <- 640
  x[x == 14] <- 690
  x[x == 15] <- 740
  x[x == 16] <- 790
  x[x == 17] <- 830
  x[x == 18] <- 870
  x[x == 19] <- 910
  x[x == 20] <- 950
  x[x == 21] <- 990
  x[x == 22] <- 1030
  x[x == 23] <- 1070
  x[x == 24] <- 1110
  x[x == 25] <- 1150
  x[x == 26] <- 1190
  x[x == 27] <- 1220
  x[x == 28] <- 1260
  x[x == 29] <- 1300
  x[x == 30] <- 1340
  x[x == 31] <- 1340
  x[x == 32] <- 1420
  x[x == 33] <- 1460
  x[x == 34] <- 1510
  x[x == 35] <- 1560
  x[x == 36] <- 1600
  return(x)
}

pkgTest <- function(x){
  if(x != "OpenSDPsynthR"){
    if (!require(x,character.only = TRUE))
    {
      install.packages(x,dep=TRUE)
      if(!require(x,character.only = TRUE)) stop("Package not found")
    }
  } else{
    if (!require(x,character.only = TRUE))
    {
      devtools::install_github("opensdp/OpenSDPsynthR")
      if(!require(x, character.only = TRUE)) stop("Package not found")
    }
  }
  
}

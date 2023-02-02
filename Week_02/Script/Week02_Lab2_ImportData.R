### This is my first script for Week 2 lab 2. I am learning how to import data and organize folders. 
### Created by: Hannah Merges
### Created on: 2023-02-02
### Last updated on: 2023-02-02 

########### Load libraries ##################
library(tidyverse)
library(here)

#### Read in data #####
#need at least 4 hashtags to get the carrot to appear for sections 
weightdata<-read_csv(here("Week_02","Data","weightdata.csv"))
##NOTE: make sure you are in your project! When opening R 

#### Data Analysis #### 
head(weightdata) ##looks at the top of 6 lines of the df 
tail(weightdata) ##looks at the bottom of 6 lines of the df 
View(weightdata) ##opens up new window to see the data and df, works undercaps also 
glimpse(weightdata) ##another way to view data types 










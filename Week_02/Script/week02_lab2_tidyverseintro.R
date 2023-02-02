### This is my first script for Week 2 lab 2. I am learning how to import data and organize folders. 
### Created by: Hannah Merges
### Created on: 2023-02-02
### Last updated on: 2023-02-02 

########### Load libraries ##################
library(tidyverse)
library(here)

#### Read in data #####
#need at least 4 hashtags to get the carrot to appear for sections 
weightdata<-read_csv(here("Desktop","Respositories","Merges","Week_02","Data","weightdata.csv"))


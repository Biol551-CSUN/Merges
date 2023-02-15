##################################
###### Class Exercise: using dpylr ##########
###### Created by: Hannah Merges ##############
###### Created on: 14-02-2023 ##############
######## Last updated: 14-02-2023 ##############

###########################
### Load libraries ###
############################
library(palmerpenguins)
library(tidyverse)
library(here)
library(praise)
library(devtools)
library(beyonce)
library(ggthemes)
library(calecopal)
library(dadjokeapi)


###########################
# install packages # 
##########################
devtools::install_github("jhollist/dadjoke")
groan()

###########################
### Notes ###
###########################

## use filter() to keep rows that satisfy your conditions 
## filter uses .data and then name of dataset 
## use two equal signs == to return exactly all the observations that meet the listed expectation 
filter(.data = penguins, sex == "female")

##test in class using filters and boolean logic to show various data: 

#1. penguins that were collected in either 2008 OR 2009 
filter(.data=penguins, year==2008|2009) #this only outputs data from 2007 :/ 
filter(.data=penguins, year=="2008"|year=="2009") ## have to separate them 
filter(.data=penguins, year %in% c("2008", "2009")) ## also works 

#2. penguins that are NOT from the island Dream 
filter(.data=penguins, 
       island!="Dream")

#3. Penguins in the spp Adelie and Gentoo 
filter(.data=penguins, species=="Adelie"%in%"Gentoo")
###another way you can do it: 
filter(.data=penguins,
       species=="Adelie"|"Gentoo")
filter(.data=penguins, species != "Chinstrap")
filter(.data=penguins, species %in% c("Adelie","Gentoo"))

##always have to tell operator what column to use after including a new function 

filtered_data <- mutate(.data=penguins, 
                        body_mass_kg=body_mass_g/1000, #body mass in kg 
                        bill_length_depth=bill_length_mm/bill_depth_mm) 

##ifelse function
filtered_data2 <- mutate(.data=penguins, 
                        after_2008 = ifelse(year>2008, "After 2008", "Before 2008"))
View(filtered_data2)
##use "casewhen" fucntion if doing more than one thing 

### Example 2: 
#1: Use mutate to create a new column to add flipper length and body mass together 
filtered_data3 <- mutate(.data=penguins, 
                         body_mass_g + flipper_length_mm)
filtered_data3
#2. Use mutate and ifelse to create a new column where body mass greater than 4000 is labeled as big and everything else is small
filtered_data4 <- mutate(.data=penguins, 
                         greater_4000 = ifelse(body_mass_g>4000, "Big", "Small"))
filtered_data4 

##if have mutliple verbs in the same dataframe: 








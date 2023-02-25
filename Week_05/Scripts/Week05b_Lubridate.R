###############################
###### ClassWork: data wrangling: lubridate ##########
###### Created by: Hannah Merges ##############
###### Created on: 2023-02-23 ##############
######## Last updated: 2023-02-23 ##############

##############################
#### Load libraries ####
###############################
library(tidyverse)
library(here)
library(lubridate)

###############################
#### Read in Data #### 
################################

##Depth data
DepthData<-read_csv(here("Week_05","Data","DepthData.csv"))
View(DepthData)

##Conductivity Data
CondData<-read_csv(here("Week_05","Data","CondData.csv"))
View(CondData)

#####################################
## Lecture, Working with the Data 
######################################
## want to know what time it is? 
now()
# gives you time on your computer 

now(tzone="EST") ##tells you any time zone 

today()

today(tzone = "GMT") ## just day no time 

am(now()) ##is it the morning 

leap_year(now()) ## is it a leap year 


### in lubridate, you NEED the dates to be CHARACTERS not factors 
## can convert order of date to whatever format you want based on m,d,y order 
ymd()
mdy()
dmy()

ymd("2021-02-24")
mdy("02/24/2021")
dmy("24/02/2021")
mdy("February 24 2021")

##if want to add times... 
ymd_hms("2021-02-24 10:22:20 PM")
mdy_hms("02/24/2021 22:22:20")
mdy_hm("February 24 2021 10:22 PM")

###bringing in different dates and times 
datetimes<-c("02/24/2021 22:22:20",
             "02/25/2021 11:21:10",
             "02/26/2021 8:01:52")
datetimes <- mdy_hms(datetimes) #convert the whole vector of times 

month(datetimes) ##month asks the question, what date is it 

month(datetimes, label = TRUE, abbr = FALSE) ## if want actual month written out, adding abbreviations spells out whole month

day(datetimes) # extract day 
wday(datetimes, label = TRUE) # extract day of week

## make sure to keep all of these singular, plural is a DIFFERENT function 
hour(datetimes)
minute(datetimes)
second(datetimes)

## if need to change date/time 
datetimes + hours(4) # this adds 4 hours
### this is where PLURAL form comes in 

### hour() extracts the hour component from a time and hours() is used to add hours to a datetime

datetimes + days(2) # this adds 2 days

### if trying to round to nearest minute 
round_date(datetimes, "minute") # round to nearest minute
round_date(datetimes, "5 mins") # round to nearest 5 minute

################## 
## Practice Exercise ### 

CondData <-read_csv(here("Week_05","Data","CondData.csv")) %>% 
  mutate(Date=mdy_hm(Date)) ##when you need to CHANGE the column 






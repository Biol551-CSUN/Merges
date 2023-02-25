###############################
###### Lab Assignment: data wrangling: lubridate ##########
###### Created by: Hannah Merges ##############
###### Created on: 2023-02-23 ##############
######## Last updated: 2023-02-25 ##############

##############################
#### Load libraries ####
###############################
library(tidyverse)
library(here)
library(lubridate)
library(praise)

###############################
#### Read in Data #### 
################################
## convert data columns in both datasets 
##Depth data
DepthData<-read_csv(here("Week_05","Data","DepthData.csv")) ##don't need to mutate b/c already in proper format 
  
##read in conductivity data and then round to the nearest 10 seconds so that it matches with depth data 
##and full join 
CondData <-read_csv(here("Week_05","Data","CondData.csv")) %>% 
  mutate(date=mdy_hms(date), ##change the column to proper format 
         date=round_date(date, "10 seconds")) ##round to 10 seconds to match depth data 
 
##join the 2 dataframes and then mutate and take averages of each variable 
joined_DepthCond <- inner_join(DepthData, CondData) %>% 
  mutate(date=round_date(date, "minute")) %>% #rounds for minute 
  group_by(date) %>% #group by the dates to then average everything 
  summarise(avg_temp=mean(Temperature), #averages for each var
            avg_salinity=mean(Salinity), 
            avg_depth=mean(Depth))

View(joined_DepthCond)

#### this was not correct but going to keep here in script to learn the difference ####
## take averages of date, depth, temp, and salinity by minute   
## need to extract hour and min --> this part was challenging!
#Mutated_Data <- joined_DepthCond %>% 
 # mutate(hour=hour(date), 
     #    minute=minute(date), ##finally figured it out!! finally --> haha jk this was not the right way
     #    day=date(date)) %>% 
 # group_by(hour,minute) %>% 
 # summarise(meandate=mean(day, na.rm=TRUE), 
          #  depth=mean(Depth,na.rm=TRUE), 
          #  Temperature=mean(Temperature, na.rm=TRUE),
           # Salinity=mean(Salinity, na.rm=TRUE))


##making a plot 
ggplot(data=joined_DepthCond, 
       aes(x=date)) +
  geom_line(aes(y=avg_temp, 
            color="temp")) + 
  geom_line(aes(y=avg_salinity, 
            color="salinity")) + 
  scale_color_manual("Water Chemistry", breaks = c("salinity", "temp"), 
                     values=c("salinity"="darkgreen", "temp"="coral")) +
  scale_y_continuous() + ##this allows you to put multiple things on the y axis 
  labs(x="Date", 
       y="Average Temperature(C) and Salinity (ppt)", 
       title="Average Temp and Salinity Across Time") + 
  theme_linedraw() +
  theme(axis.text.x=element_text(size=10), 
        axis.text.y=element_text(size=10), 
        axis.title.x=element_text(size=12),
        axis.title.y=element_text(size=12), 
        plot.title=element_text(hjust=0.5)) +
  ggsave(here("Week_05","Outputs","labplot_CondData.jpg"))
         
###good job Hannah 
praise()




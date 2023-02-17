######################################
###### Lab Assignment: using tidyr to clean chemistry data from Hawai'i ##########
###### Created by: Hannah Merges ##############
###### Created on: 2023-02-16 ##############
######## Last updated: 2023-02-16 ##############

###########################
#### Load libraries #####
###########################
library(tidyverse)
library(here)
library(praise)
library(devtools)
library(beyonce)
library(ggthemes)
library(calecopal)
library(nationalparkcolors)
library(ggplot2)
library(hrbrthemes)

###############################
#### Read in data ####
#############################
## load metadata
library(readr)
chem_data_dictionary <- read_csv("Week_04","data","chem_data_dictionary.csv")
View(chem_data_dictionary)

###now load dataset 
### and re-name it 
chem_data <- chemicaldata_maunalua
View(chem_data)

######################################
#### filter and tidy data #### 
#######################################
##drop NAs and separate Tide_time column  
chem_data_clean <- chem_data %>% 
  drop_na() %>% ##filters out everything that is not a complete row 
  separate(col = Tide_time, #chose the tide time column 
           into = c("Tide", "Time"), #separate into 2 columns, Tide and Time 
           sep = "_", ##separates the col by "_" 
           remove = FALSE) %>% 
  filter(Season=="SPRING", Tide=="Low")
#### now pivot dataset b/w wide and long 
  chem_data_long <- chem_data_clean %>% 
  pivot_longer(cols = Temp_in:percent_sgd, # the cols you want to pivot. This says select the temp to percent SGD cols
               names_to = "Variables", # the names of the new cols with all the column names
               values_to = "Values") %>%  # names of the new column with all the values
## summary stats of each parameter
  group_by(Variables, Site, Zone, Tide) %>% ##group by everything we want to get means and var + min/max and std for 
  summarize(param_means = mean(Values, na.rm=TRUE), 
            param_vars = var(Values, na.rm=TRUE), 
            param_min = min(Values, na.rm=TRUE), 
            param_max = max(Values, na.rm=TRUE), 
            param_std = sd(Values, na.rm=TRUE)) %>% 
write_csv(here("Week_04","Outputs","Week04b_lab_chemdata.csv")) # export as a csv to the Output folder
  View(chem_data_clean)
  View(chem_data_long)
###############################
#### Data Analysis ####
###############################
###create a new dataset
  chem_data_clean2 <- chem_data %>% 
    drop_na() %>% ##filters out everything that is not a complete row 
    separate(col = Tide_time, #chose the tide time column 
             into = c("Tide", "Time"), #separate into 2 columns, Tide and Time 
             sep = "_", ##separates the col by "_" 
             remove = FALSE) %>% 
    filter(Zone!="Offshore")
  View(chem_data_clean2)
  
##make a plot 2 
  ggplot(data=chem_data_clean2, ##new dataset excludes Offshore data because limited data points only from one site
         mapping=aes(x=percent_sgd, 
                     y=TA, ##% SGD determines how much TA is present 
                     color=pH,
                     shape=Site)) + 
    geom_point() + 
    scale_shape_manual(values = c(11,8)) + ##representing the Jews 
    facet_wrap(Tide~Zone, scale="free") + ##wanted to look at the differences between zones and also at low and high tide
    theme_classic() + #removes the grid
    scale_color_gradient(low="pink", high="purple") + #create a fancy color gradient for pH
    labs(y="Total Alkalinity Levels", 
         x= "Percent SGD (%)", 
         title= "TA by % SGD at Each Zone and Tide by Site") +
    theme(axis.text.x=element_text(size=10), 
          axis.text.y=element_text(size=10), 
          axis.title.x=element_text(size=12),
          axis.title.y=element_text(size=12), 
          plot.title=element_text(hjust=0.5), 
          panel.background=element_rect("beige"))
  ggsave(here("Week_04","Outputs","labassignment_chemdata.png"),
         width=7, height=5)
  

  
  ######## this one is okay, kept it to refer back to but uses filtered data from Spring and Low tide only 
  
#make a plot 1
  ggplot(data=chem_data_clean, 
         mapping=aes(x=percent_sgd, 
                     y=TA, 
                     color=pH,
                     shape=Site)) + 
    geom_point() + 
    facet_wrap(~Zone, scale="free") +
    theme_classic() + 
    scale_color_gradient(low="pink", high="purple") +
    labs(y="Total Alkalinity Levels", 
         x= "Percent SGD (%)", 
         title= "Percent SGD by TA and... at each Zone") +
    theme(axis.text.x=element_text(size=10), 
          axis.text.y=element_text(size=10), 
          axis.title.x=element_text(size=12),
          axis.title.y=element_text(size=12), 
          plot.title=element_text(hjust=0.5))
  
  
  
 


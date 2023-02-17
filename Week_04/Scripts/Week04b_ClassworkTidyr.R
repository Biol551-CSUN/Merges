###############################
###### ClassWork: using tidyr to tidy/clean data ##########
###### Created by: Hannah Merges ##############
###### Created on: 2023-02-16 ##############
######## Last updated: 2023-02-16 ##############

###############################
#### Load libraries ####
##############################
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

#############################
#### Read in data ####
#############################
###read in metadata to learn about data 
library(readr)
chem_data_dictionary <- read_csv("Week_04","data","chem_data_dictionary.csv")
View(chem_data_dictionary)

### now load dataset 
### and re-name it 
chem_data <- chemicaldata_maunalua
View(chem_data)

######################################
#### filter and tidy data #### 
#######################################

### filter out the NAs in the data to clean it 
chem_data_clean <- chem_data %>% 
  filter(complete.cases(.)) ##filters out everything that is NOT a complete row 
View(chem_data_clean)
# this is the tidyverse way -- does same thing as drop.na()

### separate columns 
chem_data_clean <- chem_data %>% 
  drop_na() %>% ##filters out everything that is not a complete row 
  separate(col = Tide_time, #chose the tide time column 
           into = c("Tide", "Time"), #separate into 2 columns, Tide and Time 
           sep = "_", ##separate by "_" 
           remove = FALSE) %>% 
  unite(col = "Site_Zone", # the name of the NEW col, these DON'T yet exist 
        c(Site,Zone), # the columns to unite
        sep = ".", # lets put a . in the middle ... can put whatever you want though 
        remove = FALSE) # keep the original

View(chem_data_clean)

#### now time to pivot datasets b/w wide and long 
chem_data_long <- chem_data_clean %>% 
  pivot_longer(cols = Temp_in:percent_sgd, # the cols you want to pivot. This says select the temp to percent SGD cols
               names_to = "Variables", # the names of the new cols with all the column names
               values_to = "Values") # names of the new column with all the values

View(chem_data_long)

#### if wanted to take the means and variance of each parameter: 
chem_data_long %>% 
  group_by(Variables, Site) %>% ##group by everything we want to get means and var for 
  summarize(param_means = mean(Values, na.rm=TRUE), 
            param_vars = var(Values, na.rm=TRUE))

### Practice time! 
### calculate mean, var, std for all variables by site, zone, and tide 
chem_data_long %>%
  group_by(Variables, Site, Zone, Tide) %>% # group by everything we want - like site, zone, and tide 
  summarise(param_means = mean(Values, na.rm = TRUE), # get mean 
            param_vars = var(Values, na.rm = TRUE), # get variance
            param_stdv = sd(Values, na.rm = TRUE)) # get st. dev

### time to plot! woo! 
chem_data_long %>% 
  ggplot(aes(x=Site, y=Values)) + 
  geom_boxplot() + 
  facet_wrap(~Variables, scales = "free") ## make scales free so they can be reasonable and change per parameter

### convert long data back to wide 
chem_data_wide <- chem_data_long %>% 
  pivot_wider(names_from = Variables, #column with the names for the new columns 
              values_from = Values) #column with the values 
# this should get your dataset back to where it started, calling the names and columns you started w/

#### try again! and export as a csv file 
chemdata_clean <- chem_data %>% 
  drop_na() %>% #filters everything that is not a complete row 
  separate(col=Tide_time, #chooses the Tide_time col
           into=c("Tide", "Time"), #separates it into 2 new ones 
           sep="_", # separates it by the _
           remove=FALSE) %>% 
  pivot_longer(cols = Temp_in:percent_sgd, # the cols you want to pivot. This says select the temp to percent SGD cols  
               names_to = "Variables", # the names of the new cols with all the column names 
               values_to = "Values") %>% # names of the new column with all the values 
  group_by(Variables, Site, Time) %>% 
  summarise(mean_vals = mean(Values, na.rm = TRUE)) %>%
  pivot_wider(names_from = Variables,
              values_from = mean_vals) %>%  # notice it is now mean_vals as the col name
write_csv(here("Week_04","Outputs","chemsummarystats.csv")) # export as a csv to the right folder





















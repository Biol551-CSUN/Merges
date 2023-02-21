###############################
###### ClassWork: data wrangling:joins ##########
###### Created by: Hannah Merges ##############
###### Created on: 2023-02-21 ##############
######## Last updated: 2023-02-21 ##############

###############################
#### load libraries ####
##############################
library(tidyverse)
library(here)
library(cowsay) #totally awesome R package
say("hello", by="frog")

##############################
#### Read in Data ####
##############################

#Environmental data 
EnviroData<-read_csv(here("Week_05","Data","site.characteristics.data.csv"))
View(EnviroData)

#Thermal performance data
TPCData<-read_csv(here("Week_05","Data","Topt_data.csv"))
View(TPCData)

#### change the formatting ####
EnviroData_wide <- EnviroData %>% 
  pivot_wider(names_from = parameter.measured,
              values_from = values) %>% 
  arrange(site.letter) # arrange the dataframe by site

View(EnviroData_wide)

#############################################################

#### try joining now ####

# trying a left join 
FullData_left<- left_join(TPCData, EnviroData_wide) ## Joining with by = join_by(site.letter)

# trying with relocate 
FullData_left<- left_join(TPCData, EnviroData_wide) %>%
  relocate(where(is.numeric), .after = where(is.character)) # relocate all the numeric data after the character data
# Joining with by = join_by(site.letter)
# other functions that you can use such as "starts with" or "ends with" in place of "where" 

#### try summarize info by site #### 
Summary_FullData_left <-  FullData_left %>% 
  pivot_longer(cols=E:substrate.cover, 
               names_to="variables", 
               values_to="values") %>% 
  group_by(site.letter, variables) %>%
  summarise(mean_vals=mean(values, na.rm=TRUE), 
            var_vals=var(values, na.rm=TRUE))

View(Summary_FullData_left)

##another way - with summary 
Summary_FullData_left <-  FullData_left %>% 
  group_by(site.letter) %>% 
  summarise_at(vars(E:substrate.cover),.funs = list(mean = mean, var = var))

View(Summary_FullData_left)

########################################
#### Creating a tibble ####
########################################
T1 <- tibble(Site.ID = c("A", "B", "C", "D"), 
             Temperature = c(14.1, 16.7, 15.3, 12.8))
T1

#make another tibble using tibble() function and same unique identifier with Site.ID so can see missing columns as they are joined 
T2 <-tibble(Site.ID = c("A", "B", "D", "E"), 
            pH = c(7.3, 7.8, 8.1, 7.9))
T2

#### look for differences between left and right join ####
left_join(T1,T2)
right_join(T1,T2)

#### inner_join #### 
# only keeps data that is complete in both sets 
inner_join(T1,T2)

## full join, everything is kept and fills in the NA - depends on question you are asking 
## same thing as merge (but that is old, base way to do it)
full_join(T1,T2) 

### semi-join vs anti-join 
semi_join(T1,T2) ## keeps all the rows from first dataset
anti_join(T1,T2) ## only keeps rows missing from first dataset -- if need to figure out whichc pH measurements are missing for each temp recording 
anti_join(T2,T1)

#########################################
#### create new tibble ####
#########################################
A <- tibble(Site.ID = c("1", "2", "3", "4"), 
            Phosphates = c(3, 18, 21, 7))
A

B <- tibble(Site.ID = c("1", "2", "3", "4"), 
            Phosphates = c(3, 18, NA, 7))
B



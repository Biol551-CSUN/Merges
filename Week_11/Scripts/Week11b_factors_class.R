####### Class: working with factors ####### 
### Create by: Hannah Merges
##### Created on: 20-04-2023 
####### Last updated: 20-04-2023 

## load libraries 
library(tidyverse)
library(here)

## load data 
#tuesdata <- tidytuesdayR::tt_load(2021, week = 7)
#income_mean<-tuesdata$income_mean
income_mean <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-02-09/income_mean.csv')

## want to turn something into a factor just put factor in front 
fruits<-factor(c("Apple", "Grape", "Banana"))
fruits ## this output gives you levels in alphabetical order 


glimpse(starwars)
star_counts <- starwars %>% 
  drop_na(species) %>% 
  mutate(species=fct_lump(species, n=3)) %>% 
  count(species)

star_counts


##make a plot 

star_counts %>% 
  ggplot(aes(x=species, 
             y=n)) + 
  geom_col()

## to reorder the axes in ascending order  
star_counts %>%  
  ggplot(aes(x=fct_reorder(species,n), 
             y=n)) +
  geom_col()
  
## to reorder the axes in descening order  
star_counts %>%  
  ggplot(aes(x=fct_reorder(species,n, .desc=TRUE), 
             y=n)) +
  geom_col()



## now switch to dataset with 2 factors not just 1 
glimpse(income_mean)

total_income <- income_mean %>% 
  group_by(year, income_quintile) %>% 
  summarise(income_dollars_sum = sum(income_dollars)) %>% 
  mutate(income_quintile=factor(income_quintile))
total_income  

total_income %>% 
  ggplot(aes(x=year, 
             y=income_dollars_sum, 
             color=income_quintile)) + 
  geom_line()


total_income%>%
  ggplot(aes(x = year, y = income_dollars_sum, 
             color = fct_reorder2(income_quintile,year,income_dollars_sum)))+
  geom_line()+
  labs(color = "income quantile")  
## factor reodrer 2 because moving around TWO things 


## when YOU want to decide what order the levels should be 
x1 <- factor(c("Jan", "Mar", "Apr", "Dec"))
x1

x1 <- factor(c("Jan", "Mar", "Apr", "Dec"), levels = c("Jan", "Mar", "Apr", "Dec"))
x1

## if want to subset data with factors: 
starwars_clean<-starwars %>% 
  filter(!is.na(species)) %>% # remove the NAs specifically for species column 
  count(species, sort = TRUE) %>%
  mutate(species = factor(species)) %>% # make species a factor
  filter(n>3) # only keep species that have more than 3
starwars_clean

levels(starwars_clean$species) ## shows you that all these levels still exist 
# want to actually drop them! 

starwars_clean<-starwars %>% 
  filter(!is.na(species)) %>% # remove the NAs specifically for species column 
  count(species, sort = TRUE) %>%
  mutate(species = factor(species)) %>% # make species a factor
  filter(n>3) %>% 
  droplevels()
starwars_clean

## if you want to rename a specific column 
starwars_clean<-starwars %>% 
  filter(!is.na(species)) %>% # remove the NAs specifically for species column 
  count(species, sort = TRUE) %>%
  mutate(species = factor(species)) %>% # make species a factor
  filter(n>3) %>% 
  droplevels() %>% 
  mutate(species=fct_recode(species, "Humanoid"="Human")) ## new = old 
starwars_clean

  
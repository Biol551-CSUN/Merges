###############################
###### Homework: using dpylr to analyze palmer penguins ##########
###### Created by: Hannah Merges ##############
###### Created on: 2023-02-14 ##############
######## Last updated: 2023-02-14 ##############

#########################
### Load libraries ####
#########################
library(palmerpenguins)
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

############################
### Assignments ###
############################
# calculate the mean and variance of body mass by spp, island, and sex without any NAs
# filters out male penguins, calculates log body mass, selects only the columns for spp, island, sex, and log body mass
# use these data to make a plot 
# save and label plot 

averagely_fit_penguins <- penguins %>% 
  drop_na(species, island, sex) %>% ##this drops the NAs in species, island, and sex 
  group_by(species, island, sex) %>% ##this groups by the 3 variables so we can isolate our df to jsut these 3 
  summarize(mean_bodymass = mean(body_mass_g, na.rm=TRUE), #creating columns for mean and variance for bodymass for island, sex, and spp 
            variance_body_mass = var(body_mass_g, na.rm=TRUE))

View(averagely_fit_penguins) #name of the dataset, b/c it is mean... like average, ha.

#next we exclude males, mutate, and select for columns 
log_females <- penguins %>% 
  filter(sex=="female") %>% ##filters only for females
  mutate(log_bodymass = log(body_mass_g)) %>% ##mutates to calculate the log of body mass 
  select(species, island, sex, log_bodymass) ##select all the columns you want 

log_females
View(log_females)  

##time to create a plot 
##what do I want to show? 
  ## I want to look at how the log of the body mass differs by species per island 
  ## I think a violin plot might look fancy 

#this one is a boxplot with a semi-formulated jitter 
ggplot(data=log_females, 
       mapping = aes(x=island, 
                    y=log_bodymass,
                    fill=species)) + ## set the axes, and fill color based on species 
         geom_boxplot() +
        geom_jitter(color="black", size=0.4, alpha=0.5) + #haven't totally figured out jitter 
         scale_fill_manual(values= beyonce_palette(23)) +
        theme_classic() + #removes background 
        labs(x="Species of Penguin on each Island", 
            y="Log of Body mass by Species (g)", 
            title="Body Mass of 3 different Penguins", 
            fill="Species") + 
        theme(axis.text.x=element_text(size=10), 
              axis.text.y=element_text(size=10), #text for axis titles  
              axis.title.x=element_text(size=12),
              axis.title.y=element_text(size=12), #text for axis labels 
              plot.title=element_text(hjust=0.5), 
              panel.background=element_rect("beige")) #background color

#this one is trying out a violin plot 
ggplot(data=log_females, 
       mapping = aes(x=island, 
                     y=log_bodymass,
                     fill=species)) +
  geom_violin() + #yay, fancy shapes
  scale_fill_manual(values= beyonce_palette(18)) +
  #theme_classic() + #i like having the grid for this one
  labs(x="Species of Penguin on each Island", 
       y="Log of Body mass by Species (g)", 
       title="Body Mass of 3 different Penguins", 
       fill="Species") +
  theme(axis.text.x=element_text(size=10), 
        axis.text.y=element_text(size=10), 
        axis.title.x=element_text(size=12),
        axis.title.y=element_text(size=12), 
        plot.title=element_text(hjust=0.5)) 
        #panel.background=element_rect("beige")) 
ggsave(here("Week_04","Outputs","homeworkplot_logbodymass.png"),
       width=7, height=5)




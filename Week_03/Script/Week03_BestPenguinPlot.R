####################
##Lab Exercise: Best Penguin Plot
#Created by: Hannah Merges
#Created on: 2023-02-09
#Last Updated on: 2023-02-09
###################

###load the libraries 
library(palmerpenguins)
library(tidyverse)
library(here)
library(praise)
library(devtools)
library(beyonce)
library(ggthemes)
library(calecopal)

View(penguins)

??geom ##figure out which geom function might be best representation 

##SUPER COOL HACK!! Rainbow parentheses to keep track of them! #prideRscript 
##install the California palette 
devtools::install_github("an-bui/calecopal")


#let's try a bar plot 
#using sex and body mass for each spp as the data from the df 

##not all species sex's were recorded so have to omit some of the NAs
##can do that with pipe function with in the ggplot 
  ggplot(penguins %>% na.omit(),
       mapping = aes(x=sex, 
                     y=body_mass_g, 
                     group=species,
                     color=species)) + 
  geom_bar(stat="identity")
#geom bar will stack everything on top of each other, so would need to use geom_col and summary stats to better visualize data 
##so do it again but with geom_col 
##to do geom_col --> requires summary stats 
##so create a new dataframe that summarizes the body mass data 
penguins_summary <- penguins %>% 
  group_by(sex, species) %>% ##group_by function keeps things the way you want them 
  summarize(mean=mean(body_mass_g), 
             sum=sum(body_mass_g)) ##summarize... gets summarized 

penguins_summary
View(penguins_summary)

#time to create plot 
ggplot(penguins_summary %>% na.omit(), 
       mapping=aes(x=sex, 
                   y=mean, 
                   group=species,
                   fill=species)) + 
  geom_col(position="dodge2") + 
  labs(x="Sex of Penguins", 
       y="Body mass of Penguins (g)", 
       title="Body Mass of Penguins by Sex of 3 Different Species") + 
  scale_x_discrete(label= c("Male", "Female")) +
  scale_fill_manual(values= beyonce_palette(18)) + ##never using anything else (jk), Beyonce is a queen with these blues
  theme_classic() + 
  theme(axis.text.x=element_text(size=13), 
        axis.text.y=element_text(size=13)) 
        #plot.title=element_title(h.just=0.5)) ##this part is not working, can use to center title 
ggsave(here("Week_03","Output","bestpenguinplot.png"),
       width=7, height=5)

##this plot looks good... I should get praise 
praise()

##not totally sure what dodge actually ~means~ but it works!

##could also try density or facet wrapping ?? as another visualization/practice
##don't need to use summary data here 
ggplot(penguins %>% na.omit(), 
       mapping=aes(x=body_mass_g, 
                   group=species,
                   fill=species)) + 
  geom_density() +
  facet_grid(species~sex) + ##try facet wrapping to see how that looks
  theme_classic() + 
  labs(x="Body mass of Penguins (g)", 
       y="Density") + 
  scale_fill_manual(values= beyonce_palette(18)) + 
  theme(axis.text.x=element_text(size=13), 
        axis.text.y=element_text(size=13))  
##looks kinda cool! 


##when you ggsave- change width and height can alter the length of axes, so it might not look the same as you are seeing in the plot window
##adding titles -- figure out how to include this in code 
  #ggtitle
  #plot.title = element_title(h.just=0.5)






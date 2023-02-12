#########################################
### Week 3_Plotting with GGplot2
#########################################

##GG= grammar of graphics 
#part of the tidyverse 

## ggplot(data = [dataset], 
      # mapping = aes(x=[xvar], y=[yvar])) + ###this is the first layer, 
  #geom_x () + ###this is the geometry, how do we want our points to be visualized 
  #other options ##any other info 

#########################
##### load libraries

library(tidyverse)
library(palmerpenguins) ##installed in the terminal
library(ggplot2)

View(penguins)
glimpse(penguins)
head(penguins)
tail(penguins)

?ggplot
ggplot(data=penguins, ##this is where you load data 
       mapping=aes(x=bill_depth_mm, ##x and y axes with range of data, no data visualized yet though 
                   y=bill_length_mm, ##IMPORTANT POINT: comma is good for showing mutliple things WITHIN a function, + sign is for ADDING a new function 
                   color=species, ##aes ALWAYS deal with data in df --> species is a COLUMN in df, uses default colors 
                   shape=island, 
                   size=body_mass_g, 
                   alpha=flipper_length_mm)) + ##alpha makes things transparent  
  geom_point(size=2) + #this is what the points will represent as 
  labs(title="Bill Depth and Length",   ##creates labels 
       subtitle="Dimensions for Adelie, Chinstrap, and Gentoo Penguins", 
       x="Bill Depth (mm)", 
       y="Bill Length(mm)", 
       color="Species", ##can also add legend title b/c this legend title is color 
       caption="Source: Palmer Station LTER/palmerpenguin package", 
       shape="Island", 
       size="Body Mass (g)", ###ERROR HERE
       alpha="Flipper Length (mm)") +  
      scale_color_viridis_d() ##FIX THIS ERROR ##can use colorblind friendly palettes 

##FACETING
ggplot(penguins, 
       aes(x=bill_depth_mm, 
           y=bill_length_mm)) +
  geom_point() +
  facet_grid(sex~species) ##allows you to looks at things in varoius grids 

ggplot(penguins, 
       aes(x=bill_depth_mm, 
           y=bill_length_mm)) +
  geom_point() +
  facet_grid(~species) ##just doing it for one column 

ggplot(penguins, 
       aes(x=bill_depth_mm, 
           y=bill_length_mm)) +
  geom_point() +
  facet_wrap(~species, ncol=2) ##this makes it 2 columns

ggplot(data=penguins, 
       mapping=aes(x=bill_depth_mm, 
                   y=bill_length_mm,
                   color=species,)) + 
  geom_point() + 
  scale_color_viridis_d() + 
  facet_grid(species~sex) + 
  guides(color = FALSE) ##don't need legen for this one because you faceted it 

##########################
##CHECK LINKS FOR GG CHEATSHEET 













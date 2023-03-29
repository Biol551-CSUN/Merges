###############################
###### Lab Assignment: advanced plotting ##########
###### Created by: Hannah Merges ##############
###### Created on: 2023-03-028 ##############
######## Last updated: 2023-03-028 ##############

#### Load libraries #####
library(tidyverse)
library(here)
library(patchwork)
library(ggrepel)
library(gganimate)
library(magick)
library(palmerpenguins)

###### make plots to use patchwork package #### 
# plot 1
p1<-penguins %>%
  ggplot(aes(x = body_mass_g, 
             y = bill_length_mm, 
             color = species))+
  geom_point()
p1

# plot 2
p2<-penguins %>%
  ggplot(aes(x = sex, 
             y = body_mass_g, 
             color = species))+
  geom_jitter(width = 0.2)
p2

p1 + p2 + 
  plot_layout(guides='collect') + ##whichever guides you collect have to be exactly the same 
  plot_annotation(tag_levels = 'A') + ## to change the text capitalization on the legend guide 
  labs(subtitle= "This is a test subtitle for the second plot")

#can also do divide by to get plots above and below instead of side to side 
p1/p2

## in R ==> legends = called "guides" 
## make sure everything is labeled the same 
# check out patchwork website for different orientations!! ****


################# Repel Package ##################
View(mtcars) 

ggplot(mtcars, 
       aes(x=wt, 
           y=mpg, 
           label=rownames(mtcars))) + 
  geom_text() + #creates a text label 
  geom_point(color="red")

#repel text
ggplot(mtcars, 
       aes(x=wt, 
           y=mpg, 
           label=rownames(mtcars))) + 
  geom_text_repel() + #creates your labels AWAY from the point to lessen crowding 
  geom_point(color="red")

#repel label
ggplot(mtcars, 
       aes(x=wt, 
           y=mpg, 
           label=rownames(mtcars))) + 
  geom_label_repel() + #creates your labels AWAY from the point to lessen crowding 
  geom_point(color="red")
## pretty!! 

## can also use "annotate" function to add a label to a specified point on the plot


############# animate package ##############
penguins %>%
  ggplot(aes(x = body_mass_g, 
             y = bill_depth_mm, 
             color = species)) +
  geom_point() + 
  transition_states(year, # what are we animating by
                    transition_length = 2, #The relative length of the transition
                    state_length = 1) + # The length of the pause between transitions
  ease_aes("bounce-in-out") +
  ggtitle('Year: {closest state}') + 
  anim_save(here("Week_08", "Outputs", "Class8a_animation.gif"))

############### Magick package #################
penguin<-image_read("https://pngimg.com/uploads/penguin/pinguin_PNG9.png")
penguin

## did not realize I could also do this in R!! 

penguins %>%
  ggplot(aes(x = body_mass_g, 
             y = bill_depth_mm, 
             color = species)) +
  geom_point() + 
  ggsave(here("Week_08", "Outputs", "penguinplot.jpg"))

# once saved plot as an image THEN can add a picture 

PenguinPlot<-image_read(here("Week_08","Outputs","penguinplot.jpg"))
out <- image_composite(PenguinPlot, penguin, offset = "+70+30")
out

# Read in a penguin gif
pengif<-image_read("https://media3.giphy.com/media/H4uE6w9G1uK4M/giphy.gif")
outgif <- image_composite(penplot, pengif, gravity = "center")
animation <- image_animate(outgif, fps = 10, optimize = TRUE)
animation




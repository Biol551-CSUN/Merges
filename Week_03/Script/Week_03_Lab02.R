##################
###Week 3_Lab 2
###################

###load libraries 
library(palmerpenguins)
library(tidyverse)
library(here)
library(praise)
library(devtools)
library(beyonce)
library(ggthemes)

####make a basic plot 
ggplot(data=penguins, 
       mapping= aes(x=bill_depth_mm, 
                    y=bill_length_mm, 
                    group=species, 
                    color=species)) + 
  geom_point() + 
  geom_smooth(method="lm") + ##default is to add spline function --> look at ?geom_smooth
  labs(x="Bill Depth (mm)", 
       y="Bill Length (mm)") + 
  scale_x_continuous(limits = c(0,20)) + ##c stands for cacantany (fancy word for bring together), you need to do this so R brings 2 values togther and have line 
  scale_y_continuous(limits=c(0,50))

##try this again 
ggplot(data=penguins, 
       mapping= aes(x=bill_depth_mm, 
                    y=bill_length_mm, 
                    group=species, 
                    color=species)) + 
  geom_point() + 
  geom_smooth(method="lm") + ##default is to add spline function --> look at ?geom_smooth
  labs(x="Bill Depth (mm)", 
       y="Bill Length (mm)") +
  color_scale_manual(values=c("orange", "purple", "green")) + 
  scale_x_continuous(limits = c(0,20), breaks=c(14, 17, 21), ##c stands for cacantany (fancy word for bring together), you need to do this so R brings 2 values togther and have line 
                     labels=c("low", "medium", "high")) + ##you can use this to label breaks on your axis related to your data 
  scale_y_continuous(limits=c(0,50))

###try with new color palette
ggplot(data=penguins, 
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     group = species,
                     color = species)) + 
  geom_point()+ 
  geom_smooth(method = "lm")+ 
  labs(x = "Bill depth (mm)", 
       y = "Bill length (mm)"
  ) +
  #scale_color_viridis_d()
  scale_color_manual(values = c("purple", "pink", "blue"))


praise()
praise()

##install Beyonce color palatte and also California, PNW, 

##now try with Beyonce color palette 
ggplot(data=penguins, 
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     group = species,
                     color = species)) + 
  geom_point()+ 
  geom_smooth(method = "lm")+ 
  labs(x = "Bill depth (mm)", 
       y = "Bill length (mm)"
  ) +
  #scale_color_viridis_d()
  scale_color_manual(values = beyonce_palette(15))


####Coordinates#### 
##various forms of switching coordinates
#coord_flip()
#coord_fixed()
#etc 

###just adding coordinates to existing code 
ggplot(data=penguins, 
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     group = species,
                     color = species)) + 
  geom_point()+ 
  geom_smooth(method = "lm")+ 
  labs(x = "Bill depth (mm)", 
       y = "Bill length (mm)"
  ) +
  #scale_color_viridis_d()
  scale_color_manual(values = c("purple", "pink", "blue")) + 
  coord_flip()

##coord fixed 

###just adding coordinates to existing code 
ggplot(data=penguins, 
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     group = species,
                     color = species)) + 
  geom_point()+ 
  geom_smooth(method = "lm")+ 
  labs(x = "Bill depth (mm)", 
       y = "Bill length (mm)"
  ) +
  #scale_color_viridis_d()
  scale_color_manual(values = c("purple", "pink", "blue")) + 
  coord_fixed() ##axes flipped, fixed at a certain ratio 

###NOW IF YOU WANTED TO LOG TRANSFORM DATA 
ggplot(diamonds, aes(carat, price)) +
  geom_point() +
  coord_trans(x = "log10", y = "log10")

##now if you wanted to show data in circles 
ggplot(data=penguins, 
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     group = species,
                     color = species)) + 
  geom_point()+ 
  geom_smooth(method = "lm")+ 
  labs(x = "Bill depth (mm)", 
       y = "Bill length (mm)"
  ) +
  #scale_color_viridis_d()
  scale_color_manual(values = c("purple", "pink", "blue")) + 
  coord_polar("x") ##looks kinda dope though 


######## Working with Themes #########
##now if you wanted to show data in circles 
ggplot(data=penguins, 
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     group = species,
                     color = species)) + 
  geom_point()+ 
  geom_smooth(method = "lm")+ 
  labs(x = "Bill depth (mm)", 
       y = "Bill length (mm)"
  ) +
  #scale_color_viridis_d()
  scale_color_manual(values = c("purple", "pink", "blue")) + 
  theme_classic() ##looks clean 

##now if you wanted to show data in circles 
ggplot(data=penguins, 
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     group = species,
                     color = species)) + 
  geom_point()+ 
  geom_smooth(method = "lm")+ 
  labs(x = "Bill depth (mm)", 
       y = "Bill length (mm)"
  ) +
  #scale_color_viridis_d()
  scale_color_manual(values = c("purple", "pink", "blue")) + 
  theme_bw() 

####### Changing the Axes Titles and Size ########
##now if you wanted to show data in circles 
ggplot(data=penguins, 
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     group = species,
                     color = species)) + 
  geom_point()+ 
  geom_smooth(method = "lm")+ 
  labs(x = "Bill depth (mm)", 
       y = "Bill length (mm)"
  ) +
  #scale_color_viridis_d()
  scale_color_manual(values = c("purple", "pink", "blue")) + 
  theme_classic() + 
  theme(axis.title=element_text(size=20, ##if just wanted to change x axis, type axis.title.
                                color="red"),  
  panel.background = element_rect(fill = "linen"))

###now try to change theme on own 
?theme

ggplot(data=penguins, 
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     group = species,
                     color = species)) + 
  geom_point()+ 
  geom_smooth(method = "lm")+ 
  labs(x = "Bill depth (mm)", 
       y = "Bill length (mm)"
  ) +
  #scale_color_viridis_d()
  scale_color_manual(values = c("purple", "pink", "blue")) + 
  theme_classic() + 
  theme(axis.title=element_text(size=20, ##if just wanted to change x axis, type axis.title.
                                color="black"),  
        panel.background = element_rect(fill = "beige", 
                                        color="green"))

ggplot(data=penguins, 
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     group = species,
                     color = species)) + 
  geom_point()+ 
  geom_smooth(method = "lm")+ 
  labs(x = "Bill depth (mm)", 
       y = "Bill length (mm)"
  ) +
  #scale_color_viridis_d()
  scale_color_manual(values = c("purple", "pink", "blue")) + 
  theme_classic() + 
  theme(axis.title=element_text(size=20, ##if just wanted to change x axis, type axis.title.
                                color="black"),  
        panel.background = element_rect(fill = "beige"), 
        panel.border = element_rect(color="green"))


###### NOW WE NEED TO SAVE OUR PLOT #########
ggplot(data=penguins, 
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     group = species,
                     color = species)) + 
  geom_point()+ 
  geom_smooth(method = "lm")+ 
  labs(x = "Bill depth (mm)", 
       y = "Bill length (mm)"
  ) +
  #scale_color_viridis_d()
  scale_color_manual(values = c("purple", "pink", "blue")) + 
  theme_classic() + 
  theme(axis.title=element_text(size=20, ##if just wanted to change x axis, type axis.title.
                                color="red"),  
        panel.background = element_rect(fill = "linen"))
#use here() brcause unbreakable 
ggsave(here("Week_03","output","penguin.jpg"),
       width=7, height=5) ##in inches 

##### you can NAME your plots ######
plot1 <-ggplot(data=penguins, 
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     group = species,
                     color = species)) + 
  geom_point()+ 
  geom_smooth(method = "lm")+ 
  labs(x = "Bill depth (mm)", 
       y = "Bill length (mm)"
  ) +
  #scale_color_viridis_d()
  scale_color_manual(values = c("purple", "pink", "blue")) + 
  theme_classic() + 
  theme(axis.title=element_text(size=20, ##if just wanted to change x axis, type axis.title.
                                color="red"),  
        panel.background = element_rect(fill = "linen"))

plot1
##This is mad helpful 
##check over 120 different functions 

praise()


?geom
??geom

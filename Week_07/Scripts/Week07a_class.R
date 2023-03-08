###############################
###### Lab Assignment: maps! ##########
###### Created by: Hannah Merges ##############
###### Created on: 2023-03-07 ##############
######## Last updated: 2023-03-07 ##############

###################################
#### install new packages ####
###################################

###################################
#### load libraries ####
###################################
library(tidyverse)
library(here)
library(maps)
library(mapdata)
library(mapproj)

###################################
#### read in data ####
###################################
CApop <-read_csv(here("Week_07","Data","CAPopdata.csv")) 
seastars <-read_csv(here("Week_07","Data","stars.csv")) 
chemdata <-read_csv(here("Week_07","Data","chemicaldata_maunalua.csv")) 

###################################
#### practicing with map packages ####
###################################
world <-map_data("world")
head(world)

usa <- map_data("usa")
head(usa)

italy <- map_data("italy") ##in this package, all countries and states are going to be lower-case 

states <- map_data("state") ##assume this is for US 

counties <- map_data("county")

head(counties)

##what is the structure of this package? 
# long is longitude: some packages are +/- others are 0 to 360 
# latutude, order, region and subregion, group 

#######################
## make a map plot ## 
########################

ggplot() + 
  geom_polygon(data=world, 
               aes(x=long, y=lat, 
                   group=group, 
                   fill=region),  ##group = group because the automatic group denote in world dataset is by country
                   color="black") + ##outside of the () because not related to data
  guides(fill=FALSE) + 
  theme_minimal() +  
  theme(panel.background = element_rect(fill="lightblue")) + ##fills in the panel, color would put a line around the border 
  coord_map(projection="mercator", 
            xlim=c(-180,180)) 

## can work with other projections 
ggplot() + 
  geom_polygon(data=world, 
               aes(x=long, y=lat, 
                   group=group, 
                   fill=region),  ##group = group because the automatic group denote in world dataset is by country
               color="black") + ##outside of the () because not related to data
  guides(fill=FALSE) + 
  theme_minimal() +  
  theme(panel.background = element_rect(fill="lightblue")) + ##fills in the panel, color would put a line around the border 
  coord_map(projection="sinusoidal", 
            xlim=c(-180,180)) 

##if working with different countries, choose the right projection for that country 


#####now just making a map specific to California 
CA_data <- states %>% 
  filter(region=="california")
CA_data

##create a good CA map 
ggplot() + 
  geom_polygon(data=CA_data, 
               aes(x=long, y=lat, 
                   group=group, 
                   fill=region),  ##group = group because the automatic group denote in world dataset is by country
               fill="black") + ##outside of the () because not related to data
  theme_void() +  ##this theme gets rid of axes
  theme(panel.background = element_rect(fill="lightblue")) + ##fills in the panel, color would put a line around the border 
  coord_map(projection="mercator") +
  labs(x="Longitude", 
       y="Latitude",
       fill="State")

#### look at county data 
head(counties)[1:3,]
head(CApop)


CApop_county <- CApop %>% 
  select("subregion"=County, Population) %>% ##rename the county column 
  inner_join(counties) %>% 
  filter(region=="california") ##some countries have same names in other states

#now you can make a new plot with extra layers 
ggplot() + 
  geom_polygon(data=CApop_county, 
               aes(x=long,
                   y=lat,
                   group=group,
                   fill=Population), 
               color="black")+
  coord_map()+ 
  theme_void()+ 
  scale_fill_gradient(trans="log10") ##transform the data b/c it is really skewed, can also add your color palette here

##now add seastar data 
ggplot() + 
  geom_polygon(data=CApop_county, 
               aes(x=long,
                   y=lat,
                   group=group,
                   fill=Population), 
               color="black")+
  geom_point(data=seastars, ## add another layer with sea star info - add as points 
             aes(x=long, 
                 y=lat, 
                 size=star_no),
             color="purple") +
  coord_map()+ 
  theme_void()+ 
  scale_fill_gradient(trans="log10") +
  labs(size="# of star/m2")
ggsave(here("Week_07", "Outputs", "practicemaps_class.jpg"))



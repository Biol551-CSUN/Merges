###############################
###### Class: functional programming  ##########
###### Created by: Hannah Merges ##############
###### Created on: 2023-04-04 ##############
######## Last updated: 2023-04-04 ##############

###### Load Libraries #######
library(tidyverse)
library(here)
library(palmerpenguins)
library(PNWColors) 


########### Read in Data ########
df <- tibble::tibble(
  a = rnorm(10), # draws 10 random values from a normal distribution
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)
)

head(df)

##default = sd of 0 and mean of 1 -- creates a bell curve over 0 
df<-df %>%
  mutate(a = (a-min(a, na.rm = TRUE))/(max(a, na.rm = TRUE)-min(a, na.rm = TRUE)))

df<-df %>%
  mutate(a = (a-min(a, na.rm = TRUE))/(max(a, na.rm = TRUE)-min(a, na.rm = TRUE)),
         b = (b-min(b, na.rm = TRUE))/(max(b, na.rm = TRUE)-min(b, na.rm = TRUE)),
         c = (c-min(c, na.rm = TRUE))/(max(c, na.rm = TRUE)-min(c, na.rm = TRUE)),
         d = (d-min(d, na.rm = TRUE))/(max(d, na.rm = TRUE)-min(d, na.rm = TRUE)))

### Make this a function ### 

  

## try with R code first 

FtoC <- function() {temp_C <- (temp_F-32)* 5/9
  
}

FtoC <- function(temp_F) {temp_C <- (temp_F-32)* 5/9

}

FtoC <- function(temp_F) {temp_C <- (temp_F-32)* 5/9
return(temp_C)

}

## check to make sure it works with using a random temp_F value 

FtoC(32)


### NOW try writing a function to convert C to K
Temp_CtoK <- function() {tempK <- tempC +273.15}
Temp_CtoK <- function(tempC) {tempK <- tempC +273.15}

Temp_CtoK <- function(tempC) {tempK <- tempC +273.15
return(tempK)}

#### Making a function to use the same color palette for many plots 

# first make a plot 
pal<-pnw_palette("Lake",3, type = "discrete") # my color palette 
ggplot(penguins, aes(x = body_mass_g, y = bill_length_mm, color = island))+
  geom_point()+
  geom_smooth(method = "lm")+ # add a linear model
  scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
  theme_bw()


## now design the start of the function 
## what are the arguments?? --> replace aesthetics but everything else stays the same for the plot 
myplot<-function(){
  pal<-pnw_palette("Lake",3, type = "discrete") # my color palette 
  
  ggplot(penguins, aes(x = body_mass_g, y = bill_length_mm, color = island))+
    geom_point()+
    geom_smooth(method = "lm")+ # add a linear model
    scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
    theme_bw()
}

### changing x and y axes 
myplot<-function(data, x, y){
  pal<-pnw_palette("Lake",3, type = "discrete") ## changing 3 different arguments here 
  ## dont need to change names of axes, can just specify x="", y=""
  
  ggplot(data, aes(x =x, y =y , color = island))+
    geom_point()+
    geom_smooth(method = "lm")+ # add a linear model
    scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
    theme_bw()
}


## changing error to include curly curly brackets 
myplot<-function(data, x, y){ 
  pal<-pnw_palette("Lake",3, type = "discrete") # my color palette 
  ggplot(data, aes(x = {{x}}, y = {{y}} , color = island))+
    geom_point()+
    geom_smooth(method = "lm")+ # add a linear model
    scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
    theme_bw()
}


## test to make sure function works 
myplot(data = penguins, x = body_mass_g, y = flipper_length_mm)



### now adding defaults 
myplot<-function(data = penguins, x, y){
  pal<-pnw_palette("Lake",3, type = "discrete") # my color palette 
  ggplot(data, aes(x = {{x}}, y = {{y}} , color = island))+
    geom_point()+
    geom_smooth(method = "lm")+ # add a linear model
    scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
    theme_bw()
}

## now you can just write the x and y variable and R will know to look in specific penguin dataset 
myplot(x = body_mass_g, y = flipper_length_mm)


## can add on another layer like in regular ggplot 
myplot(x = body_mass_g, y = flipper_length_mm)+
  labs(x = "Body mass (g)",
       y = "Flipper length (mm)")


### adding some flexibility with if-else statements 


##If, else statements
a <- 4
b <- 5

if (a > b) { # my question
  f <- 20 # if it is true give me answer 1
} else { # else give me answer 2
  f <- 10
}

f


myplot<-function(data = penguins, x, y, lines=TRUE ){ # add new argument for lines
  pal<-pnw_palette("Lake",3, type = "discrete") # my color palette 
  if(lines==TRUE){
    ggplot(data, aes(x = {{x}}, y = {{y}} , color = island))+
      geom_point()+
      geom_smooth(method = "lm")+ # add a linear model
      scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
      theme_bw()
  }
  else{
    ggplot(data, aes(x = {{x}}, y = {{y}} , color = island))+
      geom_point()+
      scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
      theme_bw()
  }
}

## running with or without lines 
myplot(x = body_mass_g, y = flipper_length_mm)
myplot(x = body_mass_g, y = flipper_length_mm, lines = FALSE)





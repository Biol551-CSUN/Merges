############## Week 12a: For loops #############
## Created by: Hannah Merges
## Created on: 25-04-2023 
## Last updated: 25-04-2023 

### Load libraries 
library(tidyverse)
library(here)

### For loops 
print(paste("The year is", 2000))
## print will output whatever we ask, paste uses info in the (), paste0 does NOT put a SPACE b/w these values

### simple example ### 
years<-c(2015:2021) ##using a colon puts the years iteratively -- by default at 1 --> if want more advanced sequence, can use seq() with labeling the intervals
for (i in years){ # set up the for loop where i is the index
  print(paste("The year is", i)) # loop over i
}

#Pre-allocate space for the for loop
# empty matrix
year_data<-data.frame(matrix(ncol = 2, nrow = length(years)))
# add column names
colnames(year_data)<-c("year", "year_name")
year_data

for (i in 1:length(years)){ # set up the for loop where i is the index
  year_data$year_name[i]<-paste("The year is", years[i]) # loop over i
}
year_data

for (i in 1:length(years)){ # set up the for loop where i is the index
  year_data$year_name[i]<-paste("The year is", years[i]) # loop over year name
  year_data$year[i]<-years[i] # loop over year __. always rows,coumns --> so could have i, j which is rows than columns in brackets --> brackets pull out info from dataframe 
  
}
year_data ## need to pre-allocate space so R can fully run and have nough/know where to create space

### actually using data ### 

## reading in data to create for lop that will automatically create new df and save old one 
testdata<-read_csv(here("Week_12", "Data", "011521_CT316_1pcal.csv"))
glimpse(testdata)

### point to the location on the computer of the folder
CondPath<-here("Week_12", "Data")
CondPath
# list all the files in that path with a specific pattern
# In this case we are looking for everything that has a .csv in the filename
# you can use regex to be more specific if you are looking for certain patterns in filenames
files <- dir(path = CondPath,pattern = ".csv")
filesCondPath<-here("Week_12", "Data")

# pre-allocate space
# make an empty dataframe that has one row for each file and 3 columns
cond_data<-data.frame(matrix(nrow = length(files), ncol = 3))
# give the dataframe column names
colnames(cond_data)<-c("filename","mean_temp", "mean_sal")
cond_data


raw_data<-read_csv(paste0(CondPath,"/",files[1])) # test by reading in the first file and see if it works
head(raw_data)


### FOR LOPS: only work with same column names, etc  

mean_temp<-mean(raw_data$Temperature, na.rm = TRUE) # calculate a mean
mean_temp

for (i in 1:length(files)){ # loop over 1:3 the number of files
}

for (i in 1:length(files)){ # loop over 1:3 the number of files 
  raw_data<-read_csv(paste0(CondPath,"/",files[i]))
  glimpse(raw_data) ## helpful but V slow 
}



#glimpse(raw_data)
cond_data$filename[i]<-files[i]
}

cond_data()


for (i in 1:length(files)){ # loop over 1:3 the number of files 
  raw_data<-read_csv(paste0(CondPath,"/",files[i]))
  #glimpse(raw_data)
  cond_data$filename[i]<-files[i]
  cond_data$mean_temp[i]<-mean(raw_data$Temperature, na.rm =TRUE)
  cond_data$mean_sal[i]<-mean(raw_data$Salinity, na.rm =TRUE)
} 
cond_data

for (i in 1:length(files)){ # loop over 1:3 the number of files 
  raw_data<-read_csv(paste0(CondPath,"/",files[i]))
  #glimpse(raw_data)
  cond_data$filename[i]<-files[i]
  cond_data$mean_temp[i]<-mean(raw_data$Temperature, na.rm =TRUE)
  cond_data$mean_sal[i]<-mean(raw_data$Salinity, na.rm =TRUE)
} 
cond_data

## DONT SET "i" TO BE SOEMTHING SPECIFIC 
## test your forloop with one df to se if it works 
## can easily trace gossip --> what Hannah??


### purrr ### with maps 
1:10 # a vector from 1 to 10 (we are going to do this 10 times)

1:10 %>% # a vector from 1 to 10 (we are going to do this 10 times) %>% # the vector to iterate over
  map(rnorm, n = 15) # calculate 15 random numbers based on a normal distribution in a list

##want to calculate the mean from each list 
1:10 %>% # a vector from 1 to 10 (we are going to do this 10 times) %>% # the vector to iterate over
  map(rnorm, n = 15)  %>% # calculate 15 random numbers based on a normal distribution in a list 
  map_dbl(mean) # calculate the mean. It is now a vector which is type "double"

## make a function! 
1:10 %>% # list 1:10
  map(function(x) rnorm(15, x)) %>% # make your own function ## random, normally distribution 
  map_dbl(mean)
## use tilde to change the function that exists

1:10 %>% # list 1:10
  map(function(x) rnorm(15, x)) %>% # make your own function
  map_dbl(mean)

1:10 %>% ##this is the vector that the thing is being done to
  map(~ rnorm(15, .x)) %>% # changes the arguments inside the function ## use tilde when want t change exisitinf function 
  map_dbl(mean)


## bring in files using purr instead of a for loop 

# point to the location on the computer of the folder
CondPath<-here("Week_12", "Data")
files <- dir(path = CondPath,pattern = ".csv") ## list all the files with .csv that are in this specified path
files

files <- dir(path = CondPath,pattern = ".csv", full.names = TRUE)
#save the entire path name
files

data<-files %>% ## files() is what is getting iteratred over eerything 
  set_names()%>% # set's the id of each list to the file name
  map_df(read_csv,.id = "filename") # map everything to a dataframe and put the id in a column called filename --> this is what is iterating 
data # column file name 


data<-files %>%
  set_names()%>% # set's the id of each list to the file name
  map_df(read_csv,.id = "filename") %>% # map everything to a dataframe and put the id in a column called filename
  group_by(filename) %>%
  summarise(mean_temp = mean(Temperature, na.rm = TRUE),
            mean_sal = mean(Salinity,na.rm = TRUE))
data



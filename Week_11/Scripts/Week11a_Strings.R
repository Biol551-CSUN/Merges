####### Class: learning what strings are ####### 
### Create by: Hannah Merges
##### Created on: 18-04-2023 
####### Last updated: 


###### install packages 

##### load libraries 
library(here)
library(tidyverse)
library(tidytext)
library(wordcloud2)
library(janeaustenr)

### what is a string 
words<-"This is a string"
words

words_vector<-c("Apples", "Bananas","Oranges")
words_vector

#### forms of Manipulation 
  ### pasting 

paste("High temp", "Low pH")
paste("High temp", "Low pH", sep = "-")
paste0("High temp", "Low pH")

## helpful when writing figure captions 

shapes <- c("Square", "Circle", "Triangle")
paste("My favorite shape is a", shapes) ## this applies your string to all the columns in the df 

two_cities <- c("best", "worst")
paste("It was the", two_cities, "of times.")


shapes # vector of shapes
str_length(shapes) # how many letters are in each word? ## works for numbers as well 

seq_data<-c("ATCCCGTC")
str_sub(seq_data, start = 2, end = 4) # extract the 2nd to 4th AA ### this extracts values from vector, used as a subset

str_sub(seq_data, start = 3, end = 3) <- "A" # add/substitute an A in the 3rd position
seq_data

##duplicating text 
str_dup(seq_data, times = c(2, 3)) # times is the number of times to duplicate each string

## removing white space to clean up df 
badtreatments<-c("High", " High", "High ", "Low", "Low")
badtreatments

str_trim(badtreatments) # this removes both sides
str_trim(badtreatments, side = "left") # this removes left

str_pad(badtreatments, 5, side = "right") # add a white space to the right side after the 5th character
str_pad(badtreatments, 5, side = "right", pad = "1") # add a 1 to the right side after the 5th character

## local sensitive 
x<-"I love R!"
str_to_upper(x)
str_to_lower(x)
str_to_title(x) ## capitalizes to first letter of each word

## pattern matching 
data<-c("AAA", "TATA", "CTAG", "GCTT")
# find all the strings with an A
str_view(data, pattern = "A")

str_detect(data, pattern = "A")
str_detect(data, pattern = "AT")

str_locate(data, pattern = "AT")

## using regex
vals<-c("a.b", "b.c","c.d")
#string, pattern, replace
str_replace(vals, "\\.", " ") ## i want R to throw out its definition of this character, and use my own

## metacharacters 
vals<-c("a.b.c", "b.c.d","c.d.e")
#string, pattern, replace
str_replace(vals, "\\.", " ")
#string, pattern, replace
str_replace_all(vals, "\\.", " ")

## sequences 
val2<-c("test 123", "test 456", "test")
str_subset(val2, "\\d")

### character class
str_count(val2, "[aeiou]")
# count any digit
str_count(val2, "[0-9]")


strings<-c("550-153-7578",
           "banana",
           "435.114.7586",
           "home: 672-442-6739")
phone <- "([2-9][0-9]{2})[- .]([0-9]{3})[- .]([0-9]{4})"
## all inside () for groups and quotation marks 
## use sq brackets once inside of () 
## 2-9 = character class --> pick any number that matched 2-9 
## 0-9 = i want another number that is any number 0-9 
## inside curly curkly {} of whatever just specificied - 
## then close parantheses and that is the area code 

## then include brackets to specify separaters 

## no limitations on what digits are --> are there needs to be 3 of them 

## then another separater 

## last 4 numbers will be 0-9 and want exactly 4 of them 

## matches a very specific pattern 

# Which strings contain phone numbers?
str_detect(strings, phone)

## class example 
## "([0-9]{3})[.]([0-9]{4})[.]([0-9]{2})


### think, pair, share -- clean up the dataset 
test<-str_subset(strings, phone)
test

test %>%
  str_replace_all(pattern = "\\.", replacement = "-") %>% # replace periods with -
  str_replace_all(pattern = "[a-zA-Z]|\\:", replacement = "") %>% # remove all the things we don't want
  str_trim() # trim the white space

#### Tidy Text #########

# explore it
head(austen_books())

original_books <- austen_books() %>% # get all of Jane Austen's books
  group_by(book) %>%
  mutate(line = row_number(), # find every line
         chapter = cumsum(str_detect(text, regex("^chapter [\\divxlc]", # count the chapters (starts with the word chapter followed by a digit or roman numeral)
                                                 ignore_case = TRUE)))) %>% #ignore lower or uppercase
  ungroup() # ungroup it so we have a dataframe again
# don't try to view the entire thing... its >73000 lines...
head(original_books)

tidy_books <- original_books %>%
  unnest_tokens(output = word, input = text) # add a column named word, with the input as the text column
head(tidy_books) # there are now >725,000 rows. Don't view the entire thing!


#see an example of all the stopwords
head(get_stopwords())


cleaned_books <- tidy_books %>%
  anti_join(get_stopwords()) # dataframe without the stopwords
head(cleaned_books)


cleaned_books %>%
  count(word, sort = TRUE)

sent_word_counts <- tidy_books %>%
  inner_join(get_sentiments()) %>% # only keep pos or negative words
  count(word, sentiment, sort = TRUE) # count them
head(sent_word_counts)

sent_word_counts %>%
  filter(n > 150) %>% # take only if there are over 150 instances of it
  mutate(n = ifelse(sentiment == "negative", -n, n)) %>% # add a column where if the word is negative make the count negative
  ## this puts positive and negative values in different directions on the figure 
  mutate(word = reorder(word, n)) %>% # sort it so it gows from largest to smallest
  ggplot(aes(word, n, fill = sentiment)) +
  geom_col() +
  coord_flip() +
  labs(y = "Contribution to sentiment")

### word clouds #### 

words<-cleaned_books %>%
  count(word) %>% # count all the words
  arrange(desc(n))%>% # sort the words
  slice(1:100) #take the top 100
wordcloud2(words, shape = 'triangle', size=0.3) # make a wordcloud out of the top 100 words




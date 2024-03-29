#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny) 

ui<-fluidPage(
  sliderInput(inputId = "num", # ID name for the input 
              label = "Choose a number", # Label above the input
              value = 25, min = 1, max = 100 # values for the slider
  ),
  textInput(inputId = "title", # new Id is title 
            label = "Write a title",
            value = "Histogram of Random Normal Values"), # starting title 
  plotOutput("hist"), #creates space for a plot called hist
  verbatimTextOutput("stats") # create a space for stats
)
server<-function(input,output){
  output$hist <- renderPlot({
    # {} allows us to put all our R code in one nice chunck
    data<-tibble(x = rnorm(input$num)) # 100 random normal points 
    ggplot(data, aes(x = x))+ # make a histogram 
      geom_histogram() +
      labs(title = input$title) #Add a new title
    })
  }
shinyApp(ui = ui, server = server)


library(shiny)
library(tidyverse)

ui<-fluidPage(
  sliderInput(inputId = "num", # ID name for the input
              label = "Choose a number", # Label above the input
              value = 25, min = 1, max = 100 # values for the slider
  ), 
  textInput(inputId = "title", # new Id is title
            label = "Write a title", #
            value = "Histogram of Random Normal Values"), # starting title
  plotOutput("hist"), #creates space for a plot called hist  
  verbatimTextOutput("stats") # create a space for stats
)
server<-function(input,output){
  data<-reactive({ 
    tibble(x = rnorm(input$num)) # 100 random normal points
  }) 
  output$hist <- renderPlot({
    ggplot(data(), aes(x = x))+ # make a histogram
      geom_histogram()+
      labs(title = input$title) #Add a new title
  })
  output$stats <- renderPrint({
    summary(data()) # calculate summary stats based on the numbers
  })
}
shinyApp(ui = ui, server = server)

  






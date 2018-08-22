#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)

# Define UI for application that draws a histogram
shinyUI(fluidPage(theme = shinytheme("flatly"),
  
  # Application title
  titlePanel("Data Science Capstone Project: Word Prediction"),
  br(),
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      textInput("usrInput", "Please enter text here", "Hello. How are ..."),
      br(),
      submitButton("Predict")
    ,width = "100%"),
    
    
    
    # Show a plot of the generated distribution
    mainPanel(
      
      helpText('Next word'),
      h2(textOutput("usrOutput")),
      
      br()
      #helpText("Other possible candidates"),
      #dataTableOutput(outputId = "usrOutputOtherCand")   
    )
  )
))

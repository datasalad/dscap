#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Data Science Capstone Project: Word Prediction"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      textInput("usrInput", "Please enter text here", "let me"),
      submitButton("Predict")
    ),
    
    
    
    # Show a plot of the generated distribution
    mainPanel(
      
      h3('Next word'),
      h2(textOutput("usrOutput"))
    )
  )
))

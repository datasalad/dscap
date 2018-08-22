#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#



# Define UI for application that draws a histogram
shinyUI(fluidPage(theme = "bootstrap.css",
  
  titlePanel("Predict MPG demo"),
  sidebarPanel(
    sliderInput('wt', 'Weight (lbs)', value = 2500, min=1000, max=5000),
    selectInput('cyl', 'Cylinders', sort(unique(mtcars$cyl))),
    checkboxInput('am', 'Manual transmission'),
    h3('How to use this demo:'),
    helpText('Please set the weight, number of cylinders and transmission type of the car to get the estimated MPG.') 
  ),
  
  mainPanel(
    h4('Weight of the car'),
    verbatimTextOutput("wt"),
    h4('Number of cylinders'),
    verbatimTextOutput("cyl"),
    h4('Transmission'),
    verbatimTextOutput("transmission"),
    h3('Estimated MPG'),
    h2(textOutput("mpg"))
  )
  
  
))

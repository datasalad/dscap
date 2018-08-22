#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#


library(ggplot2)

modfit <- lm(mpg ~ wt + as.factor(cyl) + as.factor(am), mtcars)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$wt  <- renderPrint({input$wt})
  output$cyl <- renderPrint({input$cyl})
  output$transmission <- renderPrint({ifelse(input$am, 'manual', 'auto')})
  
  output$mpg <- reactive({
    dataset <- data.frame(
      wt  = input$wt/1000,
      cyl = input$cyl,
      am  = ifelse(input$am, 1, 0)
    )
    round(predict(modfit, dataset)[[1]], 2)
  })
  
})

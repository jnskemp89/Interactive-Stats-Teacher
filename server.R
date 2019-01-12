#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$distPlot <- renderPlot({
    
    # draw the histogram 
    
    x <-  seq(min(Galton$childHeight), max(Galton$childHeight), length.out = 100)
    df <- data.frame(x = x, y = dnorm(x, input$mean, input$sd))
    ggplot(Galton) +
      geom_histogram(aes(x = childHeight, y = ..density..),
                     binwidth = 1, fill = "grey", color = "black") + 
      geom_line(data = df, aes(x=x, y=y), color = "red")
    
    
  })
  
})

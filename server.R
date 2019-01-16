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
    x <-  seq(min(Galton$childHeight), max(Galton$childHeight), length.out = 934)
    df <- data.frame(height = x, density = dnorm(x, input$mean3, input$sd3), cumulative = rnorm(x, input$mean3, input$sd3))
    
    ggplot(Galton) +
      geom_histogram(aes(x = childHeight, y = ..density..),
                     binwidth = 1, fill = "grey", color = "black") + 
      geom_line(data = df, aes(x = height, y = density), color = "red")
    
    
  })
  
  output$quartPlot <- renderPlot({
    
    # draw the histogram 
    x <-  seq(min(Galton$childHeight), max(Galton$childHeight), length.out = 934)
    df <- data.frame(height = x, density = dnorm(x, input$mean3, input$sd3), cumulative = rnorm(x, input$mean3, input$sd3))
    
    plot1 <- ggplot(Galton) +
      geom_histogram(aes(x = childHeight, y = ..density..),
                     binwidth = 1, fill = "grey", color = "black") + 
      geom_line(data = df, aes(x = height, y = density), color = "red")
      
    plot2 <- ggplot(df) + 
      geom_boxplot(aes(y = density, alpha = 0.7, fill = "red")) +
      theme(legend.position = "none")
    
    grid.arrange(plot1, plot2, ncol=2)
    
    
  })
  
  output$cdfPlot <- renderPlot({
    
    # draw the histogram 
    x <-  seq(min(Galton$childHeight), max(Galton$childHeight), length.out = 934)
    df <- data.frame(height = x, density = dnorm(x, input$mean3, input$sd3), cumulative = rnorm(x, input$mean3, input$sd3))
    
    plot1 <- ggplot(Galton) +
      geom_histogram(aes(x = childHeight, y = ..density..),
                     binwidth = 1, fill = "grey", color = "black") + 
      geom_line(data = df, aes(x = height, y = density), color = "red")
    #geom_boxplot(y = df$y, horiz = TRUE)
    plot2 <- ggplot(df, aes(cumulative)) + 
      xlim(min(Galton$childHeight), max(Galton$childHeight)) +
      stat_ecdf()
    grid.arrange(plot1, plot2, ncol=2)
    
    
  })
})

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
    df <- data.frame(height = x, density = dnorm(x, input$mean, input$sd), 
                     cumulative = rnorm(x, input$mean, input$sd))
    
    ggplot(Galton) +
      geom_histogram(aes(x = childHeight, y = ..density..),
                     binwidth = 1, fill = "grey", color = "black") + 
      geom_line(data = df, aes(x = height, y = density), color = "red")
    
    
  })
  
  output$quartPlot <- renderPlot({
    
    # draw the histogram 
    x <-  seq(min(Galton$childHeight), max(Galton$childHeight), length.out = 934)
    x1 <- rnorm(934, input$mean2, input$sd2)
    df <- data.frame(height = x1, density = dnorm(x1, input$mean2, input$sd2), 
                     cumulative = rnorm(934, input$mean2, input$sd2))
    
    plot1 <- ggplot(Galton) +
      geom_histogram(aes(x = childHeight, y = ..density..),
                     binwidth = 1, fill = "grey", color = "black") + 
      geom_line(data = df, aes(x = height, y = density), color = "red")
      
    plot2 <- ggplot(df) + 
      geom_boxplot(aes(y = x1, alpha = 0.7, fill = "red")) +
      theme(legend.position = "none") + 
      ylim(55, 80) + 
      coord_flip()
    
    grid.arrange(plot1, plot2, ncol=2)
    
    
  })
  
  output$cdfPlot <- renderPlot({
    
    # draw the histogram 
    x <-  seq(min(Galton$childHeight), max(Galton$childHeight), length.out = 934)
    df <- data.frame(height = x, density = dnorm(x, input$mean3, input$sd3), 
                     cumulative = rnorm(x, input$mean3, input$sd3))
    
    plot1 <- ggplot(Galton) +
      geom_histogram(aes(x = childHeight, y = ..density..),
                     binwidth = 1, fill = "grey", color = "black") + 
      geom_line(data = df, aes(x = height, y = density), color = "red")
    #geom_boxplot(y = df$y, horiz = TRUE)
    plot2 <- ggplot(df, aes(cumulative)) + 
      xlim(50, 85) +
      stat_ecdf()
    grid.arrange(plot1, plot2, ncol=2)
    
    
  })
  
  output$boxPlot <- renderPlot({
    set.seed(40)
    X <- rnorm(100, 50, 25)
    boxplot(X, horizontal = TRUE, axes = FALSE, staplewex = 1)
    text(x=fivenum(X), labels =c("min", "Q1", "Q2", "Q3", "max"), y=1.35)
  })
  
})

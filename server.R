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
    set.seed(42)
    x <-  seq(min(Galton$childHeight), max(Galton$childHeight), length.out = 934)
    df <- data.frame(height = x, density = dnorm(x, input$mean, input$sd), 
                     cumulative = rnorm(x, input$mean, input$sd))
    
    ggplot(Galton) +
      geom_histogram(aes(x = childHeight, y = ..density..),
                     binwidth = 1, fill = "blue", color = "black", alpha = 0.3) + 
      geom_line(data = df, aes(x = height, y = density), color = "red", size = 2) + 
      xlab("Height (inches)") + 
      ylab("Percentage of Total Data") + 
      theme(axis.title.x = element_text(vjust = 3, size = 15),
            axis.title.y = element_blank(),
            panel.background = element_blank(),
            axis.line.x = element_line(color = "black", size = 1),
            axis.ticks.y = element_blank(),
            axis.text.y = element_blank()) +
      scale_x_continuous(expand = c(0, 0)) + 
      scale_y_continuous(expand = c(0, 0.0005))
    
    
  })
  
  output$quartPlot <- renderPlot({
    
    # draw the histogram 
    set.seed(42)
    x <-  seq(min(Galton$childHeight), max(Galton$childHeight), length.out = 934)
    x1 <- rnorm(934, input$mean2, input$sd2)
    df <- data.frame(height = x1, density = dnorm(x1, input$mean2, input$sd2), 
                     cumulative = rnorm(934, input$mean2, input$sd2))
    
    plot1 <- ggplot(Galton) +
      geom_histogram(aes(x = childHeight, y = ..density..),
                     binwidth = 1, fill = "blue", color = "black", alpha = 0.3) + 
      geom_line(data = df, aes(x = height, y = density), color = "red", size = 1.5) + 
      xlab("Height (inches)") + 
      ylab("Percentage of Total Data") + 
      theme(axis.title.x = element_text(vjust = 3, size = 15),
            axis.title.y = element_blank(),
            panel.background = element_blank(),
            axis.line.x = element_line(color = "black", size = 1),
            axis.ticks.y = element_blank(),
            axis.text.y = element_blank()) +
      scale_x_continuous(expand = c(0, 0)) + 
      scale_y_continuous(expand = c(0, 0.0005))
      
    plot2 <- ggplot(df) + 
      geom_boxplot(aes(y = x1, alpha = 0.7, fill = "red")) +
      theme(legend.position = "none",
            axis.line.y = element_blank(),
            axis.text.y = element_blank(),
            axis.ticks.y = element_blank(),
            axis.title.x = element_text(vjust = 3, size = 15),
            panel.background = element_blank(),
            axis.line = element_line(color = "black", size = 1)) + 
      ylim(55, 80) +
      ylab("Height (inches)") + 
      coord_flip() +
      scale_x_continuous(expand = c(0, 0)) + 
      scale_y_continuous(expand = c(0, 0))
    
    grid.arrange(plot1, plot2, ncol=2)
    
    
  })
  
  output$cdfPlot <- renderPlot({
    
    # draw the histogram 
    set.seed(42)
    x <-  seq(min(Galton$childHeight), max(Galton$childHeight), length.out = 934)
    df <- data.frame(height = x, density = dnorm(x, input$mean3, input$sd3), 
                     cumulative = rnorm(x, input$mean3, input$sd3))
    
    plot1 <- ggplot(Galton) +
      geom_histogram(aes(x = childHeight, y = ..density..),
                     binwidth = 1, fill = "blue", color = "black", alpha = 0.3) + 
      geom_line(data = df, aes(x = height, y = density), color = "red", size = 1.5) + 
      xlab("Height (inches)") + 
      ylab("Percentage of Total Data") + 
      theme(axis.title.x = element_text(vjust = 3, size = 15),
            axis.title.y = element_blank(),
            panel.background = element_blank(),
            axis.line.x = element_line(color = "black", size = 1),
            axis.ticks.y = element_blank(),
            axis.text.y = element_blank()) +
      scale_x_continuous(expand = c(0, 0)) + 
      scale_y_continuous(expand = c(0, 0.0005))
    #geom_boxplot(y = df$y, horiz = TRUE)
    plot2 <- ggplot(df, aes(cumulative)) + 
      
      stat_ecdf(size = 1.5, color = "blue") +
      xlab("Height (inches)") + 
      ylab("Percentage of Total Data") + 
      theme(axis.title.x = element_text(vjust = 3, size = 15),
            axis.title.y = element_text(vjust = 3, size = 15),
            panel.background = element_blank(),
            axis.line = element_line(color = "black", size = 1)) +
      scale_x_continuous(expand = c(0, 0)) + 
      scale_y_continuous(expand = c(0, 0.01)) + 
      xlim(50, 85) +
      geom_vline(xintercept = input$mean3, linetype = 'dotted', size = 1) +
      geom_text(aes(x=input$mean3 - 2, label="Mean", y = 0.9), size = 6, colour="blue", text=element_text(size=11))
    grid.arrange(plot1, plot2, ncol=2)
    
    
  })
  
  output$boxPlot <- renderPlot({
    set.seed(42)
    X <- rnorm(100, 50, 25)
    boxplot(X, horizontal = TRUE, axes = FALSE, staplewex = 1)
    text(x=fivenum(X), labels =c("min", "Q1", "Q2", "Q3", "max"), y=1.35)
  })
  
  output$table <- renderTable({
    Galton %>% select(X, father, mother, midparentHeight, childHeight, gender) %>% head(n = 15)
  })
  
})

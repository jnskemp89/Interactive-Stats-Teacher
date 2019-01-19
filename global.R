library(shiny)
library(shinydashboard)
library(dplyr)
library(ggplot2)

setwd("C:/Users/jnske/GIT/NSS/Stats_Textbook")
#read.csv("./data/GaltonFamilies.csv") %>% 
 # saveRDS("Galton")
Galton <- readRDS("./data/Galton") 
heights <- Galton["childHeight"] 
heights <- as.numeric(as.character(unlist(heights['childHeight'])))

example_dist <- rnorm(heights, mean = mean(heights), sd = sd(heights)) %>% 
  sort()

input_mean <- mean(Galton$childHeight)
input_sd <- sd(Galton$childHeight)

set.seed(40)
X <- rnorm(100, 50, 25)
boxplot(X, horizontal = TRUE, axes = FALSE, staplewex = 1)
text(x=fivenum(X), labels =c("min", "Q1", "Q2", "Q3", "max"), y=1.5)


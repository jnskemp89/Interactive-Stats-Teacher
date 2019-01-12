# Define UI for application that draws a histogram
ui <- dashboardPage(skin = "red",
  dashboardHeader(
    title = "Statistics Teacher"
  ),#dashboardHeader
  dashboardSidebar(
    sidebarMenu(
      menuItem("Introduction", tabName = "Introduction"),
      menuItem("Normal Distribution", tabName = "normDist", startExpanded = TRUE,
               menuSubItem("Explanation", tabName = "ndistExp", icon = shiny::icon("circle")),
               menuSubItem("Demonstration", tabName = "ndistDemo", icon = shiny::icon("circle"))
      ),#menuItem
      menuItem("Interquartile Ranges", tabName = "interquartiles", startExpanded = TRUE,
               menuSubItem("Explanation", tabName = "quartExp", icon = shiny::icon("circle")),
               menuSubItem("Demonstration", tabName = "quartDemo", icon = shiny::icon("circle"))
      ),#menuItem
      menuItem("Cumulative Density Function", tabName = "cdf", startExpanded = TRUE,
               menuSubItem("Explanation", tabName = "cdfExp", icon = shiny::icon("circle")),
               menuSubItem("Demonstration", tabName = "cdfDemo", icon = shiny::icon("circle"))
      )#menuItem
    )#sidebarMenu
  ),#dashboardSidebar
    
    # Show a plot of the generated distribution
  dashboardBody(
    tabItems(
      tabItem(tabName = "Introduction",
              box(
                h3("The goal of this app is to create an easily digestible way to explain 
                some of the fundamental concepts of statistics. We aim to do this by 
                using a real-world dataset (Galton's height data) to display visually 
                how certain aspects of the data can affect things like distribution, "), width = 12
              )#box
      ),#tabItem
      tabItem(tabName = "ndistExp",
              h3("Normal Distributions"),
              br(),
              h4("Explanation of mean and std in relation to normal distribution")
      ),#tabItem
      tabItem(tabName = "ndistDemo",
              h3("Use the sliders below to visualize the impact that mean and standard deviation have on a distribution"),
              fluidRow(
                box(
                  sliderInput("mean",
                              "Mean",
                              min = 55,
                              max = 80,
                              value = input_mean
                  )#sliderInput
                ),#box
                box(
                  sliderInput("sd",
                              "Standard Deviation",
                              min = 1,
                              max = 10,
                              value = input_sd
                  )#sliderInput
                )#box
              ),#fluidRow
              plotOutput("distPlot")
      ),#tabItem
      tabItem(tabName = "quartExp",
              h3("Explanation of interquartile ranges")
      ),#tabItem
      tabItem(tabName = "quartDemo",
              h3("Demo of interquartile ranges")
      ),#tabItem
      tabItem(tabName = "cdfExp",
              h3("Explanation of CDF")
      ),#tabItem
      tabItem(tabName = "cdfDemo",
              h3("Demo of CDF")
      )#tabItem
    )#tabItems        
  )#dashboardBody
)#dashboardPage

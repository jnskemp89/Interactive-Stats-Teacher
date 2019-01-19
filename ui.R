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
      ),#menuItem
      menuItem("Glossary", tabName = "Glossary")
    )#sidebarMenu
  ),#dashboardSidebar
    
    # Show a plot of the generated distribution
  dashboardBody(
    tabItems(
      tabItem(tabName = "Introduction",
              box(
                h2("Introduction"),
                br(),
                h4("The goal of this app is to create an easily digestible way to explain 
                some of the fundamental concepts of statistics. We aim to do this by 
                using a real-world dataset (Galton's height data) to display visually 
                how certain aspects of the data can affect things like distribution, 
                interquartile ranges, and cumulative distribution functions. We will use 
                interactive graphs so that the effects of these statistics are easily displayed
                and understood."),
                br(),
                h4("As this must be a somewhat brief format textbook to fit the constrictions
                of this app, we will provide a brief glossary of some of the more important 
                concepts, written in ", strong('bold'), ", while assuming some basic understanding of the underlying concepts.
                The intent will be to show in particular how specifically the population variables
                of mean and standard deviation link and influence the three chosen topics."), 
                width = 12
              )#box
      ),#tabItem
      tabItem(tabName = "ndistExp",
              box(
                h3("Normal Distributions"),
                br(),
                h4('The normal distribution is the most important and most widely used 
                  distribution in statistics. It is sometimes called the "bell curve," 
                  or the "Gaussian curve" after the mathematician Karl Friedrich Gauss. 
                  These distributions are generally indicative of a dataset containing 
                  highly independent variables, meaning that the observed findings do 
                  not have any underlying factors influencing the variable in question.'),
                br(),
                h4('All normal distributions are symmetric with relatively 
                  more values at the center of the distribution and relatively few in 
                  their tails. Where normal distributions can differ is in their means and 
                  in their standard deviations. The ', strong('mean'), ' , as the average value of a dataset,
                  will be the value on the x-axis where the majority of the data points
                  are clustered. If the mean changes, then the center of the distribution 
                  changes. The ', strong('standard deviation'), ' of the data tells us how far on average 
                  the data will stray from the mean to either the positive or the negative 
                  side. Therefore, the smaller the deviation is, the more narrow the 
                  distribution will be, and a larger deviation will result in a wider range 
                  to the distribution.'),
                br(),
                h4("Now take a look at the demonstration tab so see how changing these two 
                  values will affect the distribution as a whole. By default for this and all
                  other demonstrations in this application, the mean and standard deviation 
                  will be set to match the values in Galton's height data, depicted by a 
                  static histogram to give a point of reference."),
                br(),
                h5(a("Reference - OnlineStatBook", href = "http://onlinestatbook.com/2/normal_distribution/intro.html")),
                width = 12
              )#box
      ),#tabItem
      tabItem(tabName = "ndistDemo",
              box(h4("Use the sliders below to visualize the impact that mean and standard 
                 deviation have on a distribution. The default red line matches the 
                 underlying histogram of Galton's data, and will change according to 
                 the sliders. The histogram will remain static to give a point of reference."), width = 12),
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
              fluidRow(
                box(
                h3("Interquartile Ranges (IQRs)"),
                br(),
                h4('To understand the interquartile range, it would be best to start with 
                   an explanation of how it is created. We first order all points of data 
                  in order from least to greatest. Then we must determine three specific 
                  data points:'),
                tags$div(tags$ul(
                  tags$li(h4("The ", strong('median'), ", which will be labelled Q2")),
                  tags$li(h4("The median of the half of the data which precedes Q2, which will be labelled Q1")),
                  tags$li(h4("The median of the half of the data which follows Q2, which will be labelled Q3")))),
                h4('These points will be used to create the boundaries of our IQR, sectioning
                  off the dataset into four equally sized parts. The IQR is depicted by 
                  drawing a box with sides at the Q1 and Q3 boundaries, with Q2 running 
                  through the middle, and a line emerging perpendicular from either side 
                  and ending at the minimun and maximum values of the dataset. Any points that 
                  are more than two standard deviations away from the mean are labelled outliers 
                  and marked by a dot on the graph.'),
              
                plotOutput("boxPlot"),
              
                h4("It is easy to see how the mean will affect this particular chart, since 
                  it the mean and the median values of a set are so closely related. Changing 
                  the mean will by rule change the Q2 value in a very similar way. Increasing standard 
                  deviation will cause the data to vary further from the median, thus the widths of the 
                  four quartiles will increase. Take a look at the demonstration on the next page to see
                  these effects in action. The histogram and bell curve from the previous example are 
                  provided here as well for context."), width = 12
              )#box
              )#fluidRow
      ),#tabItem
      tabItem(tabName = "quartDemo",
              h3("Use the sliders below to visualize the impact that mean and standard deviation have on interquartile ranges."),
              fluidRow(
                box(
                  sliderInput("mean2",
                              "Mean",
                              min = 55,
                              max = 80,
                              value = input_mean
                  )#sliderInput
                ),#box
                box(
                  sliderInput("sd2",
                              "Standard Deviation",
                              min = 1,
                              max = 10,
                              value = input_sd
                  )#sliderInput
                )#box
              ),#fluidRow
              plotOutput("quartPlot")
      ),#tabItem
      tabItem(tabName = "cdfExp",
              fluidRow(
                box(
                  h3("Cumulative Distributuion Function (CDF)"),
                  br(),
                  h4("The CDF is a function which shows how quickly a data set reaches
                     100% of its data points over the observed data range. From observing 
                     the histogram of the Galton dataset we can see that all of our 
                     height data falls between 56 and 79 inches. This means that the 
                     CDF will increase from zero to one in that same interval."),
                  br(),
                  h4("The rate at which the function increases it dependent on the 
                     accumulation of data points at each value within this range. This 
                     means that, for a data set with 100 points of data, if the first 
                     position in the range holds 3 identical data points, then the CDF 
                     will increase by 0.03 at that position (3%). This continues for 
                     every position in the range of the data values until all the data 
                     has been accounted for."),
                  br(),
                  h4('The CDF of a normally distributed variable will always take on a 
                     distinctive "S" shape due to the bell-shaped distribution. Because
                     the tails contain fewer data points being furthest away from the 
                     mean, they will have the slowest step-by-step increase contributing
                     to the CDF. The range values at and near the mean, where most of 
                     the data is clustered, will give the sharpest increase. Then on the
                     other side of the mean, as the number of values starts to decrease 
                     again, the slope of the corresponding CDF will begin to level off 
                     until it reaches the end of the range. Another way to think about this 
                     is by taking the histogram bar at each position in the range and 
                     stacking it on top of all the previous histogram bars. The line 
                     connecting the tops of all of these stacks will be our CDF.'),
                  br(),
                  h4("This means that the mean and standard deviation of the normal 
                     distribution will have an intuitive impact on the shape of this 
                     function. A change in the mean will result in a change in the 
                     position where we have the sharpest increase in the graph, which 
                     is to say that the center of our 'S' shape will slide to match the 
                     mean. We already know that an increase to the standard deviation 
                     results in a data set that is more evenly spread out across the 
                     range of the data, making our histogram more level and the increases 
                     across our CDF more gradual. Of course the opposite also holds true - 
                     a smaller standard deviation results in data which is more tightly 
                     condensed around the mean, which will make for a much steeper and 
                     sudden increase in the CDF."),
                  width = 12
                )#box
              )#fluidRow
      ),#tabItem
      tabItem(tabName = "cdfDemo",
              h3("Use the sliders below to visualize the impact that mean and standard
                  deviation have on a cumulative density function."),
              fluidRow(
                box(
                  sliderInput("mean3",
                              "Mean",
                              min = 55,
                              max = 80,
                              value = input_mean
                  )#sliderInput
                ),#box
                box(
                  sliderInput("sd3",
                              "Standard Deviation",
                              min = 1,
                              max = 10,
                              value = input_sd
                  )#sliderInput
                )#box
              ),#fluidRow
              plotOutput("cdfPlot")
      ),#tabItem
      tabItem(tabName = "Glossary",
              fluidRow(
                box(
                  h4(strong("Mean - "), "The arithmatic average of the dataset."),
                  h4(strong("Standard Deviation - "),"A measure of the variation or dispersion of a dataset. A low standard deviation indicates that the majority of the data is close to the mean, and a large standard deviation means that the data is spread out over a wider range of values."),
                  h4(strong("Median - "), "In an ordered dataset, this is the middle point separating the lower and upper halves of the data. This is the actual central data point, rather than a calculated average."),
                  h4(""), width = 12
                )#box
              )#fluidRow
      )#tabItem
    )#tabItems        
  )#dashboardBody
)#dashboardPage

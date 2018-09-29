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

  # Slider layout

  # Application title
  titlePanel("Twitter Word Could"),

  # Text Input
  textInput(inputId = "searchword",
            label = "Twitter search word"),

  # Numeric input for min word frequency
  numericInput(inputId = "min_freq",
               label = "Minimum frequency of the search",
               value = 50,
               max = 1500,
               min = 1),

  # Slider input for max word frequency
  sliderInput(inputId = "max_freq",
              label = "Maximum of the word frequency",
              value = 1500,
              max = 1500,
              min = 1),

  # action button
  actionButton(inputId = "action_btn",
               label = "Apply action"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
       sliderInput("bins",
                   "Number of bins:",
                   min = 1,
                   max = 50,
                   value = 30)
    ),

    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("distPlot"),
       plotOutput("wordcloud")
    )
  )
))

#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws the word cloud
shinyUI(fluidPage(# Slider layout
  sidebarLayout
  (
    sidebarPanel
    (
      # Application title
      titlePanel("Twitter Word Cloud"),

      # Input search text, default is water
      textInput(
        inputId = "searchword",
        label = "Twitter search word",
        value = "water"),

      # Numeric input for min word frequency, default is 50
      numericInput(
        inputId = "min_freq",
        label = "Minimum frequency of the search",
        value = 50,
        max = 1500,
        min = 1),

      # Slider input for max word frequency
      sliderInput(
        inputId = "max_number",
        label = "Maximum of the Twitt",
        value = 1500,
        max = 1500,
        min = 1),

      # action button
      actionButton(inputId = "action_btn",
                   label = "Create cloud")
      ),
    # plot the cloud
    mainPanel(plotOutput("wordcloud", height = "600px"))
   )
  )
)

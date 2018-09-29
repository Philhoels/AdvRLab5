#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# devtools::install_github("rstudio/shinyapps") #to use shinyapps install it from github
install.packages("rsconnect") # rstudio/shinyapps -> got replaced by the package rsconnect
library(rsconnect)


# Startdard R Shing ####
# # Define UI for application that draws a histogram
# ui <- fluidPage(
#
#    # Application title
#    titlePanel("Old Faithful Geyser Data"),
#
#    # Sidebar with a slider input for number of bins
#    sidebarLayout(
#       sidebarPanel(
#          sliderInput("bins",
#                      "Number of bins:",
#                      min = 1,
#                      max = 50,
#                      value = 30)
#       ),
#
#       # Show a plot of the generated distribution
#       mainPanel(
#          plotOutput("distPlot")
#       )
#    )
# )
#
# # Define server logic required to draw a histogram
# server <- function(input, output) {
#
#    output$distPlot <- renderPlot({
#       # generate bins based on input$bins from ui.R
#       x    <- faithful[, 2]
#       bins <- seq(min(x), max(x), length.out = input$bins + 1)
#
#       # draw the histogram with the specified number of bins
#       hist(x, breaks = bins, col = 'darkgray', border = 'white')
#    })
# }
#
# # Run the application
# shinyApp(ui = ui, server = server)
#

# App template ####
# User Interface ####
ui <- fluidPage(
  # Text Input
  textInput(inputId = "title", label = "The title of the word cloud"),
  textInput(inputId = "twitter_word", label = "Enter your ´search on twitter´ word here"),

  # Slider
  # sliderInput(inputId = "num_min",
  #             label = "Minimum counted",
  #             min = 1,
  #             max = 10000,
  #             value = 100),
  # sliderInput(inputId = "num_max",
  #             label = "Maximum counted",
  #             min = 1,
  #             max = 1000,
  #             value = 500),

  # Numeric input
  numericInput(inputId = "num_min",
               label = "Minimum counted",
               min = 1,
               max = 10000,
               value = 100),
  numericInput(inputId = "num_max",
               label = "Max counted",
               min = 1,
               max = 10000,
               value = 500),
  actionButton(inputId = "action_btn", lable = "Apply change"),
  #plotOutput("wordcloud")
  plotOutput("hist"),
  verbatimTextOutput("stats")
)
server <- function(input, output){
  # save the data
  data <- reactive({
    rnorm(input$num_min)
  })
  # hist output
  output$hist <- renderPlot({
    title <- "Twitter Word Cloud"
    hist(rnorm(data()),
         main = isolate({input$title}))
  })
  # stats output
  output$stats <- renderPrint(
    summary(rnorm(data()))
  )
  # output$wordcloud <- renderPlot({
  #   TwitterWordCould(isolate({word = input$twitter_word}),
  #                    min_freq = input$num_min,
  #                    max_freq = input$num_max)
  #})
}
shinyApp(ui = ui, server = server)


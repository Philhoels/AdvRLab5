# User Interface ####
ui <- fluidPage(
  # Text Input
  textInput(inputId = "Twitter_word", label = "Enter your ´search on twitter´ word here"),

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
  plotOutput("hist")
)

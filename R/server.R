# Server ####
server <- function(input, output){
  output$hist <- renderPlot({
    title <- "Twitter Word Cloud"
    hist(rnorm(input$num_min),
         main = title )
  })
}

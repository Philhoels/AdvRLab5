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
shinyServer(function(input, output, searchword) {

  output$distPlot <- renderPlot({

    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)

    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')

  })

  terms <- reactive({
    # Change when the "action" button is pressed...
    input$action_btn
    # ...but not for anything else
    isolate({
      withProgress({
        setProgress(message = "Processing corpus...")
        my_df <<- TwitterWordCould(word = input$searchword,
                                 max_freq = input$max_freq,
                                 min_freq = input$min_freq)
      })
    })
  })

  output$wordcloud <- renderPlot({
    # create the needed data
    #data <- TwitterWordCould(word = input$searchword,
    #                         max_freq = input$max_freq,
    #                         min_freq = input$min_freq)
    v <- terms()
    wordcloud(words = my_df$term, freq = my_df$freq, min.freq = input$min_freq,
              random.order=FALSE, rot.per=0.35, colors=brewer.pal(8, "Dark2"))
  })

})

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

  recalculate <- reactive({
    # Change when the "create cloud" button is pressed...
    input$action_btn
    isolate({
      withProgress({
        #Show the progress
        setProgress(message = "Processing word cloud...")
        #Call the function to crawl data from Twitter
        my_df <<- TwitterWordCould(word = input$searchword,
                                   min_freq = as.double(input$min_freq),
                                  max_number = as.double(input$max_number)
                                 )
      })
    })
  })

  output$wordcloud <- renderPlot({
    #Recalculate when the input text change
    recalculate()
    #Dwaw the cloud
    wordcloud(words = my_df$term, freq = my_df$freq, min.freq = input$min_freq,
              random.order=FALSE, rot.per=0.35, colors=brewer.pal(8, "Dark2"))
  })

})

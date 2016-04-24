
shinyServer(function(input, output) {
    rOut <- reactive({ngram_backoff(input$entry, hash_table)})
    
    output$sentence <- renderText({input$entry})

    output$predicted <- renderText({
        out <- rOut()
        out[1]
    })

    output$others <- renderText({
        out <- rOut()

        length_out <- length(out)
        if (length_out >= 2 ) {
            if (length_out > input$max) {
                out[2:input$max]
            } else {
                out[2:length_out]
            }
        }
    })

    withProgress(message = 'Loading Data ...', value = NULL, {
        # load libraries and files here
        library(shiny)
        load(file = "data/hash_table.rda")
        source('predict.R')
        
        dat <- data.frame(x = numeric(0), y = numeric(0))
        withProgress(message = 'App Initializing', detail = "part 0", value = 0, {
            for (i in 1:10) {
                dat <- rbind(dat, data.frame(x = rnorm(1), y = rnorm(1)))
                incProgress(0.1, detail = paste(":", i*10,"%"))
                Sys.sleep(0.5)
            }
        })
        
        # Increment the top-level progress indicator
        incProgress(0.5)
    })
})

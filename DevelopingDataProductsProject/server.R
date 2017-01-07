# Coursera - Developing Data Products- Course Project

# server.R file for the shiny app

# This app was developed to help people choose the best car for their trip, 
# using mtcars dataset, from [R]

library(shiny)
library(datasets)
library(dplyr)

data(mtcars)
mtcarsData <- mtcars

shinyServer(function(input, output) {
    
    # Radion Button for cylinders
    output$choose_cyl <- renderUI({
        colnames <- unique(mtcarsData$cyl)
        
        checkboxGroupInput("cyl", "Cylinders", 
                     choices = colnames,
                     selected = colnames)
    })
    
    # Radion Button  for Gears
    output$choose_gear <- renderUI({
        colnames <- unique(mtcarsData$gear)
        
        checkboxGroupInput("gear", "Gears", 
                     choices = colnames,
                     selected = colnames)
    })
    
    # Radion Button for Carburetors
    output$choose_carb <- renderUI({
        colnames <- unique(mtcarsData$gear)
        
        checkboxGroupInput("carb", "Carburetors",
                     choices = colnames,
                     selected = colnames)
    })
    
    # Slider Input for gross horsepower
    output$choose_hp <- renderUI({
        hpMax <- max(mtcars$hp)
        hpMin <- min(mtcars$hp)

        sliderInput('hp', 'Gross horsepower', min=hpMin, max=hpMax, value=c(hpMin,hpMax), step=10)
    })

    # Radio Button for Transmission
    output$choose_trans <- renderUI({
        colnames <- c("Automatic"=0, "Manual"=1)
        
        checkboxGroupInput("am", "Trasmission",
                           choices = colnames,
                           selected = colnames)
    })

    # Show the cars that correspond to the filters
    output$table <- renderDataTable({
        hp_seq <- seq(from = input$hp[1], to = input$hp[2], by = 1)

        data <- transmute(mtcars, 
                          Car = rownames(mtcars),
                          MilesPerGallon = mpg,
                          GasolineCost = input$dis/mpg*input$cost,
                          Cylinders = cyl,
                          Gears = gear,
                          Carburetors = carb,
                          Horsepower = hp,
                          Transmission = am)
        
        data <- filter(data, 
                       Cylinders %in% input$cyl, 
                       Gears %in% input$gear,
                       Carburetors %in% input$carb,
                       Horsepower %in% hp_seq,
                       Transmission %in% input$am)

        data <- mutate(data, Transmission = ifelse(Transmission == 0, "Automatic", "Manual"))
        data
    }, options = list(lengthMenu = c(5, 15, 32), pageLength = 32))

    # Show the cars that correspond to the filters
    output$plot <- renderPlot({
        
        hp_seq <- seq(from = input$hp[1], to = input$hp[2], by = 1)
        
        data <- transmute(mtcars, 
                          Car = rownames(mtcars),
                          MilesPerGallon = mpg,
                          GasolineCost = input$dis/mpg*input$cost,
                          Cylinders = cyl,
                          Gears = gear,
                          Carburetors = carb,
                          Horsepower = hp,
                          Transmission = am)
        
        data <- filter(data, 
                       Cylinders %in% input$cyl, 
                       Gears %in% input$gear,
                       Carburetors %in% input$carb,
                       Horsepower %in% hp_seq,
                       Transmission %in% input$am)
        
        validate(
            need(try(nrow(data) != 0), "No car with this options")
        )
        
        data <- head(data[order(data$MilesPerGallon, decreasing = TRUE),], 3)
        plot(data$MilesPerGallon, axes = FALSE, type = "o", col = "blue", ann = FALSE)
        box()
        axis(1, at=1:3, lab = data$Car)
        axis(2, las=1)
        title(main="Best cars", col.main="red", font.main=4)
        title(xlab="Car name", col.lab=rgb(0,0.5,0))
        title(ylab="Total cost", col.lab=rgb(0,0.5,0))
    })
})
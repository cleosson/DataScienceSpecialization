# Coursera - Developing Data Products- Course Project
# ui.R file for the shiny app

library(shiny)

shinyUI(
    navbarPage(
        "Select the best car for your trip",
        tabPanel("Plot",
                 sidebarLayout(
                     sidebarPanel(
                         helpText("Provide information about your trip and the carachteristics of the car that you want"),
                         numericInput('dis', 'Distance (in miles):', 69, min = 1, max = 1000),
                         numericInput('cost', 'Gasoline Price (per gallon):', 3.69, min = 2, max = 4, step=0.01),
                         uiOutput("choose_hp"),
                         uiOutput("choose_cyl"),
                         uiOutput("choose_gear"),
                         uiOutput("choose_carb"),
                         uiOutput("choose_trans")
                     ),
                     mainPanel(plotOutput('plot'))
                 )
        ),
        tabPanel("About",
                 mainPanel(
                     includeMarkdown("about.md")
                 )
        )
    )
)
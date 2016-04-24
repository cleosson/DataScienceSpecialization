library(shiny)
require(markdown)

shinyUI(navbarPage("Data Science Capstone by Cleosson Souza",
                   tabPanel("Shiny Word Prediction Application",
                            sidebarPanel(width=,
                                         h5("Enter the text:"),
                                         textInput("entry", 
                                                   "The app will predict your next possible word you want to type. Now, please type your input here:",
                                                   "Alive and well"),
                                         br(),
                                         sliderInput("max", 
                                                     h5("Maximum Number of Words:"), 
                                                     min = 10,  max = 200,  value = 100),
                                         br(),
                                         hr(),
                                         helpText(h5("Help Instruction:")),
                                         helpText("Please have a try to make the prediction by using the dashboard on right side. Specifically, you can:"),
                                         helpText("1. Type your sentence in the text field", style="color:#428ee8"),
                                         helpText("2. The value will be passed to the model while you are typing.", style="color:#428ee8"),
                                         helpText("3. Obtain the instant predictions below.", style="color:#428ee8"),
                                         hr(),
                                         helpText(h5("Note:")),
                                         helpText("The application will be initialized at the first load. After", code("100% loading"), ", you will see the prediction for the default sentence example \"Alive and wellu\" on the right side."),
                                         hr(),
                                         h6("This App is built for:"),
                                         a("Data Science Capstone (SwiftKey)", href="https://www.coursera.org/course/dsscapstone"),
                                         p("class started on 7th March 2016"),
                                         hr(),
                                         h6("For more information about Cleosson Souza:"),
                                         a(img(src = "github.png", height = 30, width = 30),href="https://github.com/cleosson/data-science-capstone"),
                                         a(img(src = "linkedin.png", height = 26, width = 26),href="https://br.linkedin.com/in/cleossonsouza"),
                                         br()
                            ),
                            
                            # Show a plot of the generated distribution
                            mainPanel(
                                column(5,
                                       h3("Word Prediction"),hr(),
                                       h5('The sentence you just typed:'),                             
                                       wellPanel(span(h4(textOutput('sentence')),style = "color:#428ee8")),
                                       hr(),
                                       h5('Single Word Prediction:'),
                                       wellPanel(span(h4(textOutput('predicted')),style = "color:#e86042")),
                                       hr(),
                                       h5('Other Possible Single Word Predictions:'),
                                       wellPanel(span(h5(textOutput('others')),style = "color:#2b8c1b")),
                                       hr(),
                                       
                                       p('More details of the prediction algorithm and source codes', code("server.R"), code("ui.R"), code("predict.R"), code("build_base.R"), code("load_base.R"), 'can be found at', a("Data Science Capstone.",href="https://github.com/cleosson/data-science-capstone"))
                                )
                            )
                   ),
                   tabPanel("Algorithm",
                            h3('The algorithm steps:'),
                            h5('- Creates the ngram for 4, 3 and 2.'),
                            h5('- Sums the frequency of ngrams (4, 3 and 2)'),
                            h5('- Adds the ngram into a hash table:'),
                            h5('  - For ngram 4, the three first words are the key and the last word is the value'),
                            h5('  - For ngram 3, the two first words are the key and the last word is the value'),
                            h5('  - For ngram 2, the  first words are the key and the last word is the value'),
                            h5('- The algorithm checks what is been typed using the entered text as a key in the hash table to get the next word, the value.'),
                            hr(),
                            a(img(src = "algorithm_flow.png"))),
                   tabPanel("Reports",
                            a("Milestone Report", href="https://github.com/cleosson/data-science-capstone/blob/master/reports/CourseraDataScienceCapstone.Rmd")
                   )
)
)
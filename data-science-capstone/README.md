## John Hopkins School of Public Health
### Coursera Data Science Capstone

This repository contains code for the final N-gram model for my Coursera
Data Science Capstone project. The goal is to take a dataset provided by
SwiftKey and create an NLP (natural language processing) model that is able
to predict subsequent words.

### Model Overview
- N-gram model with "Stupid Backoff" ([Brants et al 2007](http://www.cs.columbia.edu/~smaskey/CS6998-0412/supportmaterial/langmodel_mapreduce.pdf))
- Checks if highest-order (in this case 4) n-gram has been seen. If not "degrades" to a lower-order model (3, 2); we would use even higher orders, but ShinyApps caps app size at 100mb
- A simplified view of it is below

![Algorithm](https://raw.githubusercontent.com/cleosson/DataScienceSpecialization/data-science-capstone/master/presentation/images/algorithm_flow.png)

### Folder structure

- code: R code to create the hash_table.rda file used by Shiny app. To create hash_table.rda, use build_base.R and build_hashtable.R
- shiny-app: The shiny application code
- presentation: A slide deck [presentation](http://rpubs.com/cleosson/DataScienceCapstone)

### Shiny App
If you haven't tried out the app, go [here](https://cleosson.shinyapps.io/DataScienceCapstone/) to try it.

- Predicts next word
- Shows you top other possibilities
- Make prediction as you type


### Main Feature
- The underlying code stores the n-gram into a hash table, where the words entered by the user are the key and the next word is the value in the hash table
- The hash table is a enclosing environment (new.env)
- "Stupid Backoff" is designed for scale. We're restricted to 100mb on ShinyApps.
- "Stupid Backoff" performance approaches more sophisticated models like Kneser-Ney as we increase amount of data


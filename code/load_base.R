rm(list=ls())
setwd('/Users/cjps/Programming/tools/R/WorkingDirectory/DataScienceCapstone/shiny-app')

###
### Load Libraries
###

library(dplyr)
library(doParallel)
cl<-makeCluster(4)
registerDoParallel(cl)

#
# Creates the hash table and adds the phrase and next word into hash table
#
hash_table <- new.env()

# Function to populate the hash table 
f <- function(x) {
    # 1 is the phrase
    # 3 is next word
    hash_table[[x[1]]] <- c(hash_table[[x[1]]], x[3])
    NULL
}

#
# Loads ngram 4 data frame
#
load(file = 'data/ngram_dt_4_sorted_formatted.rda')
# insert the phrase and next word into hash table
apply(ngram_dt_4, 1, f)
rm(ngram_dt_4)
gc()

#
# Loads ngram 3 data frame
#
load(file = 'data/ngram_dt_3_sorted_formatted.rda')
# insert the phrase and next word into hash table
apply(ngram_dt_3, 1, f)
rm(ngram_dt_3)
gc()

#
# Loads ngram 2 data frame
#
load(file = 'data/ngram_dt_2_sorted_formatted.rda')
# insert the phrase and next word into hash table
apply(ngram_dt_2, 1, f)
rm(ngram_dt_2)
gc()


#
# Save hash table
#
save(hash_table, file = 'data/hash_table.rda')

stopCluster(cl)

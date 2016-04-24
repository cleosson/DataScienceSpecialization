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
}

#
# Loads ngram 4 data frame
#
load(file = 'data/ngram_dt_4_sorted_formatted.rda')
# Get ngram with frequency bigger than one
ngram_dt <- filter(ngram_dt_4, freq > 1)
nrow(ngram_dt)/nrow(ngram_dt_4)
dt_temp <- arrange(ngram_dt_4, phrase)
rm(ngram_dt_4)
# insert the phrase and next word into hash table
output <- apply(ngram_dt, 1, f)
rm(ngram_dt)

#
# Loads ngram 3 data frame
#
load(file = 'data/ngram_dt_3_sorted_formatted.rda')
# Get ngram with frequency bigger than one
ngram_dt <- filter(ngram_dt_3, freq > 1)
nrow(ngram_dt)/nrow(ngram_dt_3)
rm(ngram_dt_3)
# insert the phrase and next word into hash table
output <- apply(ngram_dt, 1, f)
rm(ngram_dt)

#
# Loads ngram 2 data frame
#
load(file = 'data/ngram_dt_2_sorted_formatted.rda')
# Get ngram with frequency bigger than one
ngram_dt <- filter(ngram_dt_2, freq > 1)
nrow(ngram_dt)/nrow(ngram_dt_2)
rm(ngram_dt_2)
# insert the phrase and next word into hash table
output <- apply(ngram_dt, 1, f)
rm(ngram_dt)

#
# Save hash table
#
save(hashTable, file = 'data/hash_table.rda')

stopCluster(cl)

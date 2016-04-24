rm(list=ls())
setwd('/Users/cjps/Programming/tools/R/WorkingDirectory/DataScienceCapstone/shiny-app')

###
### Load Libraries
###

library(dplyr)
library(quanteda)
library(doParallel)

# Set cluster
cl<-makeCluster(4)
registerDoParallel(cl)

###
### Load corpus files
###

zipfile <- 'data/Coursera-SwiftKey.zip'
url <- 'https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip'
us_blogs <- 'data/final/en_US/en_US.blogs.txt'
us_twitter <- 'data/final/en_US/en_US.twitter.txt'
us_news <- 'data/final/en_US/en_US.news.txt'

# Check for data file and unzip if necessary
if (!file.exists(us_blogs)) {
    # Check for zip file and download if necessary
    if (!file.exists(zipfile)) {
        download.file(url, destfile = zipfile)
    }
    
    unzip(zipfile, exdir = 'data')
}

###
### Load the lines from files
###
nbr_lines <- 200000
lines_twitter <- readLines(us_twitter, n = nbr_lines, encoding = 'UTF-8')
lines_news <- readLines(us_news, n = nbr_lines, encoding = 'UTF-8')
lines_blogs <- readLines(us_blogs, n = nbr_lines, encoding = 'UTF-8')
doc_source <- c(lines_news, lines_blogs, lines_twitter)
#doc_source <- readLines(us_blogs, n = nbr_lines, encoding = 'UTF-8')
rm(lines_twitter, lines_news, lines_blogs)
gc()

# Create the corpus
doc <- corpus(doc_source)
rm(doc_source)
gc()

# Profanity
profanity <- read.table('data/profanity_words.txt', sep='\n', stringsAsFactors = FALSE)
profanity <- dictionary(profanity)

#
# Create the ngram 4
#
ngram_4 <- dfm(doc, toLower = TRUE, removeNumbers = TRUE, removePunct = TRUE, removeSeparators = TRUE, removeTwitter = TRUE, ignoredFeatures = profanity, ngrams = 4)
ngram_sum_4 <- colSums(ngram_4)
rm(ngram_4, ngram_sum_4)
gc()
ngram_dt_4 <- data.frame(names(ngram_sum_4), ngram_sum_4, row.names = NULL, check.rows = FALSE, check.names = FALSE, stringsAsFactors = FALSE)
# Save the data frame
save(ngram_dt_4, file = 'data/ngram_dt_4.rda')
# Format and sort the data frame
colnames(ngram_dt_4) <- c('phrase', 'freq')
ngram_dt_4 <- mutate(ngram_dt_4, phrase = gsub('_', ' ', phrase), phrase = gsub('^ +|  +$', '', phrase), nextWord = gsub('^\\S+ \\S+ \\S+ ', '', phrase), phrase =  gsub(' \\S*$', '', phrase))
ngram_dt_4 <- arrange(ngram_dt_4, desc(freq))
save(ngram_dt_4, file = 'data/ngram_dt_4_sorted_formatted.rda')
# Remove variables
rm(ngram_4, ngram_sum_4, ngram_dt_4)
gc()


#
# Create the ngram 3
#
ngram_3 <- dfm(doc, toLower = TRUE, removeNumbers = TRUE, removePunct = TRUE, removeSeparators = TRUE, removeTwitter = TRUE, ignoredFeatures = profanity, ngrams = 3)
ngram_sum_3 <- colSums(ngram_3)
ngram_dt_3 <- data.frame(names(ngram_sum_3), ngram_sum_3, row.names = NULL, check.rows = FALSE, check.names = FALSE, stringsAsFactors = FALSE)
rm(ngram_3, ngram_sum_3)
gc()
# Save the data frame
save(ngram_dt_3, file = 'data/ngram_dt_3.rda')
# Format and sort the data frame
colnames(ngram_dt_3) <- c('phrase', 'freq')
ngram_dt_3 <- mutate(ngram_dt_3, phrase = gsub('_', ' ', phrase), phrase = gsub('^ +|  +$', '', phrase), nextWord = gsub('^\\S+ \\S+ ', '', phrase), phrase =  gsub(' \\S*$', '', phrase))
ngram_dt_3 <- arrange(ngram_dt_3, desc(freq))
save(ngram_dt_3, file = 'data/ngram_dt_3_sorted_formatted.rda')
# Remove variables
rm(ngram_3, ngram_sum_3, ngram_dt_3)
gc()


#
# Create the ngram 2
#
ngram_2 <- dfm(doc, toLower = TRUE, removeNumbers = TRUE, removePunct = TRUE, removeSeparators = TRUE, removeTwitter = TRUE, ignoredFeatures = profanity, ngrams = 2)
ngram_sum_2 <- colSums(ngram_2)
ngram_dt_2 <- data.frame(names(ngram_sum_2), ngram_sum_2, row.names = NULL, check.rows = FALSE, check.names = FALSE, stringsAsFactors = FALSE)
rm(ngram_2, ngram_sum_2)
gc()
# Save the data frame
save(ngram_dt_2, file = 'data/ngram_dt_2.rda')
# Format and sort the data frame
colnames(ngram_dt_2) <- c('phrase', 'freq')
ngram_dt_2 <- mutate(ngram_dt_2, phrase = gsub('_', ' ', phrase), phrase = gsub('^ +|  +$', '', phrase), nextWord = gsub('^\\S+ ', '', phrase), phrase =  gsub(' \\S*$', '', phrase))
ngram_dt_2 <- arrange(ngram_dt_2, desc(freq))
save(ngram_dt_2, file = 'data/ngram_dt_2_sorted_formatted.rda')
# Remove variables
rm(ngram_2, ngram_sum_2, ngram_dt_2)
rm(profanity)
gc()


stopCluster(cl)

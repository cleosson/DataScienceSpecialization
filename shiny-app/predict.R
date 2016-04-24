library(quanteda)

ngram_backoff <- function(input, ht) {
    phrase <- tolower(input)
    tokens <- tokenize(phrase, removeNumbers = TRUE, removePunct = TRUE, removeSeparators = TRUE, removeTwitter = TRUE)
    token_list <- tokens[[1]]
    token_list_length <- length(token_list)
    result <- NULL

    if (token_list_length >= 3) {
        ngram_4_key <- paste(token_list[token_list_length - 2], token_list[token_list_length - 1], token_list[token_list_length])
        result <- ht[[ngram_4_key]]
    }

    if (token_list_length >= 2) {
        ngram_3_key <- paste(token_list[token_list_length - 1], token_list[token_list_length])    
        if (!is.null(ht[[ngram_3_key]])) {
            if (!is.null(result)) {
                result <- c(result, ht[[ngram_3_key]])
            } else {
                result <- ht[[ngram_3_key]]
            }
        }
    }

    if (token_list_length >= 1) {
        ngram_2_key <- token_list[token_list_length]
        if (!is.null(ht[[ngram_2_key]])) {
            if (!is.null(result)) {
                result <- c(result, ht[[ngram_2_key]])
            } else {
                result <- ht[[ngram_2_key]]
            }
        }
    }

    if (is.null(result)) {
        result <- " "
    }

    unique(result)
    
}
#this script is to prepare the file to be used for the model, going up to 5-grams

library(lubridate)
library(readtext)
library(Rcpp)
library(quanteda)
library(data.table)
library(stringr)

#read the samples text in one file
mytxt_twit <- readtext("sample_twitter.txt")
mytxt_news <- readtext("sample_news.txt")
mytxt_blog <- readtext("sample_blog.txt")

#get a list of bad words to remove from the data set
con_pro <- file("en", "r")
pro <- readLines(con_pro, encoding = "UTF-8")
close(con_pro)

#get a total corpus
corp <- corpus(mytxt_twit) + corpus(mytxt_news) + corpus(mytxt_blog)

#removing the punctuation, @ and #, and also the bad words from the list pro
#do not remove stopwords for unigram, but will remove them for bi-grams and trigrams
#no stemming because, it is important to keep the words as it is in order to build the model afterwards

tok <- tokens_remove(tokens(corp, remove_punct = TRUE, remove_separators = TRUE, remove_numbers = TRUE, remove_url = TRUE, remove_hyphens = TRUE), c(pro,"u", "#*","@*","D","w"))
tok <- tokens_remove(tok, valuetype = "regex", "\\w*[0-9]+\\w*\\s*") #remove all the words that start/end/contain with numbers
tok <- tokens_remove(tok, valuetype = "regex", "\\.")

#then creation of the dfm in order to look at the data
my_dfm <- dfm(tok, tolower = TRUE)
my_dfm <- textstat_frequency(my_dfm)
my_dfm <- as.data.table(my_dfm)
my_dfm[, c("rank", "docfreq", "group") := NULL]
setnames(my_dfm, "feature", "n")

#remove the words that have a frequency equal to 4
my_dfm <- my_dfm[my_dfm$frequency >4,]

write.table(my_dfm, row.names = FALSE, "unigram.txt")

#data set of bigrams
ng_upp <- textstat_frequency(dfm(tok, ngrams = 2, tolower = TRUE))
ng_upp <- as.data.table(ng_upp, index = c("n-1", "n"))
ng_upp[,c("rank", "docfreq", "group") := NULL ]

#remove the words that have a frequency equal to 4
ng_upp <- ng_upp[ng_upp$frequency>4,]

#split the feature in two columns
ng_upp <- ng_upp[, c("n-1", "n") := tstrsplit(feature, "_")] 
ng_upp[, feature := NULL]
setcolorder(ng_upp, c(2,3,1)) #reorder the columns

write.table(ng_upp, row.names = FALSE, "bigram.txt")


#construct the right trigram table for the model
ng3_upp <- textstat_frequency(dfm(tok, ngrams = 3, tolower = TRUE))
ng3_upp <- as.data.table(ng3_upp)
ng3_upp[,c("rank", "docfreq", "group") := NULL ]

#remove the words that have a frequency equal to 4
ng3_upp <- ng3_upp[ng3_upp$frequency>4,]


ng3_upp <- ng3_upp[, feature := gsub("_", " ", feature)] #get _ removed
ng3_upp <- ng3_upp[, c("n-1", "n") := list(word(feature, 1,2),word(feature,-1))]
ng3_upp[, feature := NULL]
setcolorder(ng3_upp, c(2,3,1)) #reorder the columns

write.table(ng3_upp, row.names = FALSE, "trigram.txt")


#construct the right 4-gram table for the model
ng4_upp <- textstat_frequency(dfm(tok, ngrams = 4, tolower = TRUE))
ng4_upp <- as.data.table(ng4_upp)
ng4_upp[,c("rank", "docfreq", "group") := NULL ]

#remove the words that have a frequency equal to 4
ng4_upp <- ng4_upp[ng4_upp$frequency>4,]


ng4_upp <- ng4_upp[, feature := gsub("_", " ", feature)] #get _ removed
ng4_upp <- ng4_upp[, c("n-1", "n") := list(word(feature, 1,3),word(feature,-1))]
ng4_upp[, feature := NULL]
setcolorder(ng4_upp, c(2,3,1)) #reorder the columns

write.table(ng4_upp, row.names = FALSE, "4gram.txt")


#construct the right 5-gram table for the model
ng5_upp <- textstat_frequency(dfm(tok, ngrams = 5, tolower = TRUE))
ng5_upp <- as.data.table(ng5_upp)
ng5_upp[,c("rank", "docfreq", "group") := NULL ]

#remove the words that have a frequency equal to 4
ng5_upp <- ng5_upp[ng5_upp$frequency>4,]


ng5_upp <- ng5_upp[, feature := gsub("_", " ", feature)] #get _ removed
ng5_upp <- ng5_upp[, c("n-1", "n") := list(word(feature, 1,4),word(feature,-1))]
ng5_upp[, feature := NULL]
setcolorder(ng5_upp, c(2,3,1)) #reorder the columns

write.table(ng5_upp, row.names = FALSE, "5gram.txt")

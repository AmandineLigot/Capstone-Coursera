library(data.table)
library(stringr)
library(qdapRegex)

#read all th n-gram tables

fifth <- fread("5gram.txt", key  = "n-1")
fourth <- fread("4gram.txt", key = c("n-1","n"))
tri <- fread("trigram.txt", key = c("n-1","n"))
bi <- fread("bigram.txt", key =c("n-1","n"))
uni <- fread("unigram.txt", key = "n")

#and get the function

source("sbo4.R")

sbo4 <- function(w){
  
  w <- rm_url(w) #remove url in the sentence
  w <- rm_emoticon(w) #remove emoticons
  w <- rm_non_ascii(w)
  w <- gsub('[[:punct:] ]+',' ',w) #remove possible punctuation
  w <- trimws(w) #remove leading and trailing whitespace
  w <- tolower(w) #remove all capital letters
  
  l <- length(strsplit(w, " ")[[1]]) #calculate the length of the given sentence
  
  if(l>=4){

    #get the matrix containing the possible n-grams and remove n-grams that area already before
    possible5g <- fifth[word(w, -4, -1)]
    possible4g <- fourth[word(w,-3, -1)]
    possible3g <- tri[word(w,-2, -1)]
    possible2g <- bi[word(w,-1)] 
    
    #find all th lines from 4-gram, trigram, bigram, unigram with the word w
    c4 <- fourth[.(word(w,-4,-2), word(w, -1))]
    c3 <- tri[.(word(w,-3,-2), word(w, -1))]
    c2 <- bi[.(word(w,-2), word(w, -1))]
    c1 <- uni[ word(w, -1)]
    
    #Do not take care of the double for the moment
    #calculate the scores for every table
    
    possible5g <- possible5g[, score := frequency/c4$frequency]
    possible4g <- possible4g[, score := 0.4*frequency/c3$frequency]
    possible3g <- possible3g[, score := 0.4*0.4*frequency/c2$frequency]
    possible2g <- possible2g[, score := 0.4*0.4*0.4*frequency/c1$frequency]
    
    possible5g <- possible5g[,c("n-1", "frequency"):= NULL]
    possible4g <- possible4g[,c("n-1", "frequency"):= NULL]
    possible3g <- possible3g[,c("n-1", "frequency"):= NULL]
    possible2g <- possible2g[,c("n-1", "frequency"):= NULL]
    
    tot <- rbind(possible5g,possible4g, possible3g, possible2g)
    setorder(tot, -score)
    tot <- na.omit(tot, cols = "score")
    #c(tot$n[1],tot$n[2],tot$n[3])
    
  }else if(l ==3){
    
    #get the matrix containing the possible n-grams and remove the n-grams already found before
    possible4g <- fourth[word(w,-3, -1)]
    possible3g <- tri[word(w,-2, -1)]
    possible2g <- bi[word(w,-1)]
    
    #find all th lines from 4-gram, trigram, bigram, unigram with the word w
    c3 <- tri[.(word(w,-3,-2), word(w, -1))]
    c2 <- bi[.(word(w,-2), word(w, -1))]
    c1 <- uni[ word(w, -1)]
    
    #Do not take care of the double for the moment
    #calculate the scores for every table
    
    possible4g <- possible4g[, score := frequency/c3$frequency]
    possible3g <- possible3g[, score := 0.4*frequency/c2$frequency]
    possible2g <- possible2g[, score := 0.4*0.4*frequency/c1$frequency]
    
    possible4g <- possible4g[,c("n-1", "frequency"):= NULL]
    possible3g <- possible3g[,c("n-1", "frequency"):= NULL]
    possible2g <- possible2g[,c("n-1", "frequency"):= NULL]
    
    tot <- rbind(possible4g, possible3g, possible2g)
    setorder(tot, -score)
    tot <- na.omit(tot, cols = "score")
    #c(tot$n[1],tot$n[2],tot$n[3])
    
  }else if(l == 2){
    
    #get the matrix containing the possible n-grams
    possible3g <- tri[word(w,-2, -1)]
    possible2g <- bi[word(w,-1)]
 
  
    #find all th lines from 4-gram, trigram, bigram, unigram with the word w
    c2 <- bi[.(word(w,-2), word(w, -1))]
    c1 <- uni[word(w, -1)]
    
    #Do not take care of the double for the moment
    #calculate the scores for every table
    
    possible3g <- possible3g[, score := frequency/c2$frequency]
    possible2g <- possible2g[, score := 0.4*frequency/c1$frequency]
    
    possible3g <- possible3g[,c("n-1", "frequency"):= NULL]
    possible2g <- possible2g[,c("n-1", "frequency"):= NULL]
    
    tot <- rbind(possible3g, possible2g)
    setorder(tot, -score)
    tot <- na.omit(tot, cols = "score")
    #c(tot$n[1],tot$n[2],tot$n[3])
    
  }else{
    #get the matrix containing the possible n-grams
    possible2g <- bi[word(w,-1)]
    possible1g = copy(uni)
    setorder(possible1g,-frequency)
    possible1g <- possible1g[1:5,] #will take max 5 from unigrams
    
    
    #find all th lines from 4-gram, trigram, bigram, unigram with the word w
    c1 <- uni[ word(w, -1)]
    
    #Do not take care of the double for the moment
    #calculate the scores for every table
    
    possible2g <- possible2g[, score := frequency/c1$frequency]
    possible1g <- possible1g[, score := frequency/sum(uni$frequency)]
    
    possible2g <- possible2g[,c("n-1", "frequency"):= NULL]
    possible1g <- possible1g[ ,frequency := NULL]  
    
    tot <- rbind(possible2g, possible1g)
    tot <- na.omit(tot, cols = "score")
    setorder(tot, -score)
    #c(tot$n[1],tot$n[2],tot$n[3])
    
  }
  
  
  
}
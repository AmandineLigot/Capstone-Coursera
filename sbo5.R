

sbo5 <- function(w){
  
  w <- rm_url(w) #remove url in the sentence
  w <- rm_emoticon(w) #remove emoticons
  w <- rm_non_ascii(w)
  w <- gsub('[[:punct:] ]+',' ',w) #remove possible punctuation
  w <- tolower(w) #remove all capital letters
  
  l <- length(strsplit(w, " ")[[1]]) #calculate the length of the given sentence
  
  if(l >= 4){
    possible5g <- fifth[word(w, -4, -1)]
    tot = copy(possible5g)
    tot <- na.omit(tot, cols = "frequency")
    
    nr <- nrow(tot)
    
    if(nr >= 3){
      
      tot <- tot[1:3,]
      
      #order the table and give back the first three
      setorder(tot, -frequency)
      c(tot$n[1],tot$n[2],tot$n[3])
      
    }else{
      c4 <- fourth[.(word(w,-4,-2), word(w, -1))]
      tot <- tot[, score := frequency/c4$frequency]
      tot <- tot[,c("n-1", "frequency"):= NULL]
      
      #read the 4-grams
      possible4g <- fourth[word(w,-3, -1)]
      possible4g <- possible4g[!(tot$n), on = "n"]
      c3 <- tri[.(word(w,-3,-2), word(w, -1))]
      possible4g <- possible4g[, score := 0.4*frequency/c3$frequency]
      possible4g <- possible4g[,c("n-1", "frequency"):= NULL]
      
      tot <- rbindlist(list(tot, possible4g), use.names = TRUE)
      tot <- na.omit(tot, cols = "score")
      setorder(tot, -score)
      
      nr <- nrow(tot)
      
      if(nr >= 3){
        c(tot$n[1],tot$n[2],tot$n[3])
        
      }else {
        
        possible3g <- tri[word(w,-2, -1)]
        possible3g <- possible3g[!(tot$n), on = "n"]
        c2 <- bi[.(word(w,-2), word(w, -1))]
        possible3g <- possible3g[, score := 0.4*0.4*frequency/c2$frequency]
        possible3g <- possible3g[,c("n-1", "frequency"):= NULL]
        
        tot <- rbindlist(list(tot, possible3g), use.names = TRUE)
        tot <- na.omit(tot, cols = "score")
        setorder(tot, -score)
        
        nr <- nrow(tot)
        
        if(nr>=3){
          c(tot$n[1],tot$n[2],tot$n[3])
          
        }else{
          
          possible2g <- bi[word(w,-1)] 
          possible2g <- possible2g[!(tot$n), on = "n"]
          c1 <- uni[ word(w, -1)]
          possible2g <- possible2g[, score := 0.4*0.4*0.4*frequency/c1$frequency]
          possible2g <- possible2g[,c("n-1", "frequency"):= NULL]
          
          tot <- rbindlist(list(tot, possible2g), use.names = TRUE)
          tot <- na.omit(tot, cols = "score")
          setorder(tot, -score)
          
          c(tot$n[1],tot$n[2],tot$n[3])
        }
        
      }
      
    }
    
  }else if(l==3){
    
    possible4g <- fourth[word(w,-3, -1)]
    tot = copy(possible4g)
    tot <- na.omit(tot, cols = "frequency")
    
    nr <- nrow(tot)
    
    if(nr >=3){
      
      setorder(tot, -frequency())
      c(tot$n[1],tot$n[2],tot$n[3])
      
    }else{
      c3 <- tri[.(word(w,-3,-2), word(w, -1))]
      tot <- tot[, score := frequency/c3$frequency]
      tot <- tot[,c("n-1", "frequency"):= NULL]
      
      possible3g <- tri[word(w,-2, -1)]
      possible3g <- possible3g[!(tot$n), on = "n"]
      c2 <- bi[.(word(w,-2), word(w, -1))]
      possible3g <- possible3g[, score := 0.4*frequency/c2$frequency]
      possible3g <- possible3g[,c("n-1", "frequency"):= NULL]
      
      tot <- rbindlist(list(tot, possible3g), use.names = TRUE)
      tot <- na.omit(tot, cols = "score")
      setorder(tot, -score)
      
      nr <- nrow(tot)
      
      if(nr>=3){
        
        c(tot$n[1],tot$n[2],tot$n[3])
      }else{
        possible2g <- bi[word(w,-1)] 
        possible2g <- possible2g[!(tot$n), on = "n"]
        c1 <- uni[ word(w, -1)]
        possible2g <- possible2g[, score := 0.4*0.4*frequency/c1$frequency]
        possible2g <- possible2g[,c("n-1", "frequency"):= NULL]
        
        tot <- rbindlist(list(tot, possible2g), use.names = TRUE)
        tot <- na.omit(tot, cols = "score")
        setorder(tot, -score)
        
        c(tot$n[1],tot$n[2],tot$n[3])
        
      }

      
    }
    
  }else if(l ==2){
    possible3g <- tri[word(w,-2, -1)]
    tot = copy(possible3g)
    tot <- na.omit(tot, cols = "frequency")
    
    nr <- nrow(tot)
    
    if(nr>=3){
      setorder(tot, -frequency())
      c(tot$n[1],tot$n[2],tot$n[3])
      
    }else{
      
      c2 <- bi[.(word(w,-2), word(w, -1))]
      tot <- tot[, score := frequency/c2$frequency]
      tot <- tot[,c("n-1", "frequency"):= NULL]
      possible2g <- bi[word(w,-1)] 
      possible2g <- possible2g[!(tot$n), on = "n"]
      c1 <- uni[ word(w, -1)]
      possible2g <- possible2g[, score := 0.4*frequency/c1$frequency]
      possible2g <- possible2g[,c("n-1", "frequency"):= NULL]
      
      tot <- rbindlist(list(tot, possible2g), use.names = TRUE)
      tot <- na.omit(tot, cols = "score")
      setorder(tot, -score)
      
      c(tot$n[1],tot$n[2],tot$n[3])
      
    }
    
  }else{
    
    possible2g <- bi[word(w,-1)]
    tot = copy(possible2g)
    tot <- na.omit(tot, cols = "frequency")
    
    nr <- nrow(tot)
    
    if(nr>=3){
      
      setorder(tot, -frequency())
      c(tot$n[1],tot$n[2],tot$n[3])
      
    }else{
      
      c1 <- uni[ word(w, -1)]
      tot <- tot[, score := frequency/c1$frequency]
      tot <- tot[,c("n-1", "frequency"):= NULL]
      
      possible1g = copy(uni)
      setorder(possible1g,-frequency)
      possible1g <- possible1g[1:5,] #will take max 5 from unigrams
      possible1g <- possible1g[, score := frequency/sum(uni$frequency)]
      possible1g <- possible1g[ ,frequency := NULL] 
      
      tot <- rbindlist(list(tot, possible1g), use.names = TRUE)
      tot <- na.omit(tot, cols = "score")
      setorder(tot, -score)
      
      c(tot$n[1],tot$n[2],tot$n[3])
      
      
    }
  }
}
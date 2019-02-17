
#Aim: getting a sample of all the data sets
set.seed(1200)

#for Twitter data set
con_twit <- file("en_US.twitter.txt", "r")
twit <- readLines(con_twit, encoding = "UTF-8")
close(con_twit)

l_twit <- length(twit)

twit <- twit[rbinom(l_twit, 1, 0.5) == 1] #take 50% of the Twit

fileConn<-file("sample_twitter.txt")
writeLines(twit, fileConn)
close(fileConn)

#For blog data set
con_blog <- file("en_US.blogs.txt", "r")
blog <- readLines(con_blog, encoding = "UTF-8")
close(con_blog)

l_blog <- length(blog)

blog <- blog[rbinom(l_blog, 1, 0.50) == 1] #take 50% of the blog
fileConn<-file("sample_blog.txt")
writeLines(blog, fileConn)
close(fileConn)

#For news data set
con_news <- file("en_US.news.txt", "r")
news <- readLines(con_news, encoding = "UTF-8")
close(con_news)

l_news <- length(news)
news <- news[rbinom(l_news, 1, 0.5) == 1] #take 50% of the news

fileConn<-file("sample_news.txt")
writeLines(news, fileConn)
close(fileConn)
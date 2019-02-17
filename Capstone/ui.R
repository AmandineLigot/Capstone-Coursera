

library(shiny)
library(shinyWidgets)

shinyUI(fluidPage(theme = "bootstrap.css",
                  
                  setBackgroundColor(color = "mintcream"),
  
  # Application title
  h1(id = "title", "Next word prediction"),
  tags$style(HTML("#title{color: green;font-size: 70px;font-style: bold;}")),
  h3(id="id", "by Amandine Ligot"),
  tags$style(HTML("#id{color: green;font-size: 25px;font-style: bold;}")),
  
  
  
  sidebarLayout(
    sidebarPanel(
      tags$style(".well {background-color:white;}"),
       h2("This application is built to give you the best next word prediction."),
       h2("To do so, you need to enter a part of a sentence or a word in the Enter text field and then press the Submit button"),
       h2("The result will appear below. It will give you the most probable word to follow the sentence you have entered.")
    ),
    
    
    mainPanel(
      tags$style(HTML(".tabbable > .nav > li > a                  {background-color: green;  color:white;font-size: 20px }
                 .tabbable > .nav > li[class=active]    > a {background-color: black; color:white}")),
    
      tabsetPanel(type ="tabs",
                  tabPanel("Prediction", 
                           br(),
                           br(),
                           tags$style("#w {font-size:25px;}"),
                           h2(id ="in",textInput("w", "Enter sentence/word:")),
                           tags$style(HTML("#in{color: black;font-size: 25px;font-style: bold;}")),
                           actionButton("b", "Submit",size = "large"),
                           tags$style(HTML("#b{color: white;font-size: 25px;background-color: green}")),
                           br(),
                           br(),
                           br(),
                           h2(id="out","The next word prediction is:"),
                           tags$style(HTML("#out{color: black;font-size: 25px;font-style: bold;}")),
                           h2(id= "result",textOutput("text")),
                           tags$style(HTML("#result{color: black;font-size: 30px;font-style: bold;background-color: white}"))),
                  tabPanel("Explanation",
                           br(),
                           br(),
                           p(id ="p1","This application enables the user to predict the next word from a given sentence."),
                           tags$style(HTML("#p1{color: black;font-size: 20px;}")),
                           p(id="p2","The model has been built using a corpus gathering texts from Twitter, blogs and news articles.
                             Stupid backoff algorithm is used based on n-grams built with 50% of the given corpus.
                             The algorithm uses from 5 to 1-gram to build the prediction.
                             The algorithm and also the corpus can be found in : "),
                           tags$style(HTML("#p2{color: black;font-size: 20px;}")),
                           tags$a(id="link",href = "https://github.com/AmandineLigot/Capstone-Coursera.git", "Github"),
                           tags$style(HTML("#link{color: black;font-size: 20px;}"))
                           
                           ))
      
      
    )
  )
))

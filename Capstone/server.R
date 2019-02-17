

library(shiny)

shinyServer(function(input, output) {
   
output$text <- eventReactive (input$b,{
  if(input$w == ""){
    ""
  }else {
    
    as.character(sbo4(input$w)[1,1])
  }
  
  
  })
  
})

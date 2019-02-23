


shinyServer(function(input, output) {
     
  output$text <- renderText(
       
       if(input$w == ""){
         ""
       }else {
         
         cmp_sbo5(input$w)
       }
     )  

  
  
})

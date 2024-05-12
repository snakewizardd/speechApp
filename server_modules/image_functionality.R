observeEvent(input$generateImage,{
  
    sxDL(prompt = input$transcriptionTextarea,
         fileName=input$imageName)
  
  
  output$imageArea <- renderImage({
    
    list(src = input$imageName, contentType = "image/jpeg")
    
    
  })
  
  
  
})


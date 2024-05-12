observeEvent(input$generateImage,{
    
      string_clean <- gsub("[[:punct:]\\s]+", "", input$imagePrompt)
      
      # Convert to lowercase
      string_clean <- tolower(string_clean)
      
      if(input$sdVersion == 'SD1'){
        
        
        sxDL(prompt = string_clean,
             fileName=input$imageName)
        
      }
  
      if(input$sdVersion == 'SD3'){
        
        stableDiffusionImageSD3(prompt = string_clean,
             fileName=input$imageName)
        
      }
  
  
  output$imageArea <- renderImage({
    
    list(src = input$imageName, contentType = "image/jpeg")
    
    
  })
  
  
  
})

#sdXL(prompt = 'Stars twinkling over Jerusalem's Old City, moonlit streets, quietly joyful atmosphere',
#fileName = 'jerusalem.jpeg')
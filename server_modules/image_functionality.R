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
  
  image_files <- list.files(pattern = "*.jpeg$")
  
  
  updateSelectizeInput(inputId = 'sd_image_list',
                       choices = image_files,
                       selected=image_files[length(image_files)])
  
  
  
})

#sdXL(prompt = 'Stars twinkling over Jerusalem's Old City, moonlit streets, quietly joyful atmosphere',
#fileName = 'jerusalem.jpeg')

observe({
  
  image_files <- list.files(pattern = "*.jpeg$")
  
  updateSelectizeInput(inputId = 'sd_image_list',
                       choices = image_files,
                       selected=image_files[1])
  
})

observeEvent(input$show_image, {
  
  output$imageArea <- renderImage({
    
    list(src = input$sd_image_list, contentType = "image/jpeg")
    
    
  })
  
})
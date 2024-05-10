observe({

    song_files <- list.files(pattern = "_.+\\.mp3$")

    updateSelectizeInput(inputId = 'suno_song_list',
                         choices = song_files,
                         selected=song_files[1])

})

observeEvent(input$playSuno, {
  
  system(paste0('afplay ',input$suno_song_list, '&'))

})

observeEvent(input$stopSuno, {
  
  system('killall afplay')

})



observeEvent(input$generateSuno,{

  withProgress(message = 'Generating Suno Song', value = 0, {
  
  # Number of times we'll go through the loop
  n <- 10
  
    
  incProgress(1/10, detail = paste("Processing Prompt with LLM..."))   


  body <- list(question = input$transcriptionTextarea)
  
  response <- POST(
    url = 'http://localhost:3000/api/v1/prediction/24f9ed69-dd85-4d3c-9a21-9f1c532af6b9',
    add_headers(`Content-Type` = "application/json"),
    body = body,
    encode = "json"
  )
  
  aiResponse <- content(response)

    
  incProgress(2/n, detail = paste("Sending prompt to server and fetching...(the long part) ~1 minute"))  
    
  generateSong(prompt = aiResponse$json$prompt,
               title = input$titleInput,
               make_instrumental = aiResponse$json$make_instrumental,
               tags = aiResponse$json$prompt,
               sunoSongName = paste0('./',input$songName))
  
  incProgress(3/n, detail = paste("Audio File Generated Successfully!"))   
  
  
  
  song_files <- list.files(pattern = "_.+\\.mp3$")
  
  incProgress(4/n, detail = paste("Audio Files Fetched from Local Cache..."))   
  
  
  updateSelectizeInput(inputId = 'suno_song_list',
                       choices = song_files,
                       selected=song_files[length(song_files)])
  
  incProgress(5/n, detail = paste("In-App Audio File List Updated!"))   
  
  incProgress(6/n, detail = paste("Fetching Song Description"))   

    output$AIOutput <- renderText({    
        
            
      as.character(writeSongInfos)
        
      })


  
  
  })
  
  
})
#Handles the button click functionality. The transcribed text is sent over to the chat completion API. 
#the API's response is stored and displayed
observeEvent(input$sendTranscription,{
  
  userInput <- input$transcriptionTextarea
  #browser()
  
  addUserMessage(userMessage =userInput)
  
  storeAPI <- pingAPI(userInputMessage = userInput)
  #Uncomment for Hebrew Bot
  #storeAPI <- interpretHebrewBot(hebrewBotReponse =
  #                                 pingHebrewBot(userInputMessage = userInput))
  
  
  aiOutputReactiveValue(storeAPI)
  
  output$AIOutput <- renderText({
    
    
    
    storeAPI
    
  })
  
  
  
})

#Handling the functionality of hitting the speech to audio API and having it be spoken to the user
observeEvent(input$speakOutput,{
  
  #browser()
  
  system("rm -rf speechOutput.mp3")
  
  speak_text(text=aiOutputReactiveValue(),
             voice="nova"
                )
  
  #Sys.sleep(5)
  
  #system(paste("afplay", "speechOutput.mp3"))  # or "start" or "mpg123" depending on your OS
  
  
})

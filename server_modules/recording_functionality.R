#Begin recording when the button is clicked
observeEvent(input$record, {
  rec_status(toggle_audio_recording("start"))
})

#Stop the recording when the button is clicked. Transcribe the recording to mp3, and render the text on the screen
observeEvent(input$stop, {
  rec_status(toggle_audio_recording("stop"))
  transcription <- transcribe("./output.mp3") 
  
  
  transcriptionValue(transcription$text)
  

  updateTextAreaInput(
  session = session,
  inputId = "transcriptionTextarea",
  value = transcription$text
  )
  
  #output$transcription <- renderText({
  #  transcription$text
  #})

})

#Display text containing status of recording procedure
output$rec_status <- renderText({
  rec_status()
})
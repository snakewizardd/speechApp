source('./functions/libraries.R',local=TRUE)

readRenviron(".env")

importedAPIKey <- Sys.getenv("OPEN_AIKEY")
groqKey <- Sys.getenv("GROQ_KEY")
sdToken <- Sys.getenv("SDToken")

discordURL <- Sys.getenv("DISCORDURL")



source('./functions/functions.R',local=TRUE)


source('./ui/ui.R',local=TRUE)


messages = list(
  list(role = "system", content = "Please converse with me as if you were a true bro. 
Use evidence and reasoning to support your arguments, but always talk to me like my life long homie.
Feel free to delve into any area of science or philosophy as needed, but always in the tone of my broski.")
)

writeSongInfos <- list()

#songIdRow <- data.frame(songFileName ='', songSunoID = '')

#songIds <= rbind(songIds,songIdRow)

server <- function(input, output, session) {
  
  rec_status <- reactiveVal("")
  transcriptionValue <- reactiveVal("")
  aiOutputReactiveValue <- reactiveVal("")
  
  source('./server_modules/recording_functionality.R',local=TRUE)
  
  source('./server_modules/transcription_functionality.R',local=TRUE)
  
  source('./server_modules/speech_functionality.R',local=TRUE)
  
  source('./server_modules/song_functionality.R',local=TRUE)
  
  source('./server_modules/image_functionality.R',local=TRUE)
  
  observeEvent(input$sendDiscord,{
    
    valueToSend <- aiOutputReactiveValue()
    
    sendToDiscord(InputMessage = valueToSend)
    
    
  })
  
}

# Run the app
shinyApp(ui = ui, server = server)

saveMessages()
source('./functions/libraries.R',local=TRUE)

readRenviron(".env")

importedAPIKey <- Sys.getenv("OPEN_AIKEY")
groqKey <- Sys.getenv("GROQ_KEY")
sdToken <- Sys.getenv("SDToken")


source('./functions/functions.R',local=TRUE)


#source('./ui/ui.R',local=TRUE)
source('./ui/hebrewAssistant.R',local=TRUE)
#source('./ui/hebrewOffline.R',local=TRUE)



messages = list(
  list(role = "system", content = "")
)

#writeSongInfos <- list()

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
  
}

# Run the app
shinyApp(ui = ui, server = server)

saveMessages()
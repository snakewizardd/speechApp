ui <- fluidPage(
  useShinyjs(),  # Initialize shinyjs
  titlePanel("Audio Recorder and Transcriber"),
  tags$head(
    tags$style(HTML("
      #record { 
        margin-top: 20px; 
        margin-bottom: 5px; 
        width: 100%;
        font-size: 18px;
      }
      #stop { 
        margin-top: 5px; 
        margin-bottom: 20px;
        width: 100%; 
        font-size: 18px;
      }
      #rec_status { 
        font-weight: bold; 
        color: #007bff;
      }
      .transcription-box {
        border: 1px solid #ccc;
        padding: 10px;
        margin-top: 20px;
        width: 100%;
        height: 150px;
        overflow-y: scroll;
      }
     .output-box {
        border: 1px solid #ccc;
        padding: 10px;
        margin-top: 20px;
        width: 100%;
        height: 150px;
        overflow-y: scroll;
        background-color: #f5f5f5;  /* Light grey background */
        border-radius: 10px;  /* Rounded corners */
        line-height: 1.5;  /* Increase line spacing */
        font-family: 'Arial', sans-serif;  /* Change font to Arial */
      }
      #sendTranscription { 
        margin-top: 20px; 
        margin-bottom: 5px; 
        width: 100%;
        font-size: 18px;
      }
    "))
  ),
  sidebarLayout(
    sidebarPanel(
      actionButton("record", "Record"),
      actionButton("stop", "Stop"),
      textOutput("rec_status"),
      br(),
      br(),
      selectizeInput(inputId = 'suno_song_list',
                     label = 'Suno Song List',
                     choices = NULL,
                     multiple = F),
      actionButton("playSuno", "Play Song"),
      actionButton("stopSuno", "Stop Song"),
      fluidRow(
      h6('A short title'),
      textAreaInput("titleInput", "", width = "100%", height = "50px"),
      h6('song file name'),
      textAreaInput("songName", "", width = "100%", height = "50px"),
      actionButton("generateSuno", "Generate Song")
      )
    ),
    mainPanel(
      div(class = "transcription-box", 
          textAreaInput("transcriptionTextarea", "", width = "100%", height = "150px")
          ),
      br(),
      actionButton("sendTranscription", "sendTranscription"),
      h3('AI Output'),
      br(),
      div(class = "output-box", textOutput("AIOutput", container = span)),
      actionButton("speakOutput", "speakOutput"),
      
    )
  )
)

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
      body {
        background-image: url('https://th.bing.com/th/id/OIP.8dsUmNRShVq6Hi-tUNOTYgHaHa?rs=1&pid=ImgDetMain');
        background-repeat: repeat;
        background-size: auto;
        background-position: center;
      }
      /* Updated styles for input box text labels */
      label.control-label {
        color: #fff;  /* Set the text color to white */
      }
      h6 {
        color: #ffffff;  /* Set the text color to white */
        font-size: 20px;  /* Adjust the font size as desired */
        margin-top: 10px;  /* Add some top margin */
        text-transform: uppercase;  /* Convert text to uppercase */
      }
      
      h3 {
        color: #ffffff;  /* Set the text color to white */
        font-size: 20px;  /* Adjust the font size as desired */
        margin-top: 10px;  /* Add some top margin */
        text-transform: uppercase;  /* Convert text to uppercase */
      }
      
      h2 {
        color: #ffffff;  /* Set the text color to white */
        font-size: 20px;  /* Adjust the font size as desired */
        margin-top: 10px;  /* Add some top margin */
        text-transform: uppercase;  /* Convert text to uppercase */
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
        h5('A short title'),
        textAreaInput("titleInput", "", width = "100%", height = "50px",
                      label = HTML('<span class="control-label">A short title</span>')),
        h5('song file name'),
        textAreaInput("songName", "", width = "100%", height = "50px",
                      label = HTML('<span class="control-label">Song file name</span>')),
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
      br(),
      h6('Image'),
      h6('Image Prompt'),
      selectizeInput(inputId = 'sdVersion',
                     label = 'SD versions',
                     choices = c('SD1','SD3'),
                     selected= 'SD1',
                     multiple = F),
      textAreaInput("imagePrompt", "", width = "100%", height = "50px",
                    label = HTML('<span class="control-label">Image Prompt</span>')),
      textAreaInput("imageName", "", width = "100%", height = "50px",
                    label = HTML('<span class="control-label">Image Name</span>')),
      actionButton("generateImage", "generateImage"),
      imageOutput('imageArea')
    )
  )
)
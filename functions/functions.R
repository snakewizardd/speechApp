#Function to toggle or shut off recording feature
toggle_audio_recording <- function(action) {
  if (action == "start") {
    if (file.exists("output.mp3")) {
      system("rm output.mp3")
    }
    system("rec -r 16000 output.mp3 &")
    return("Recording started!")
  } else if (action == "stop") {
    system("pkill -f 'rec -r 16000 output.mp3'")
    return("Recording stopped.")
  } else {
    return("Invalid action! Please use 'start' or 'stop'.")
  }
}

#Function to hit the Whisper API and transcribe the user's voice recording
transcribe <- function(audio_file_path, api_key = importedAPIKey) {
  response <- POST(
    url = "https://api.openai.com/v1/audio/transcriptions",
    add_headers(
      "Authorization" = paste("Bearer", api_key),
      'Content-Type' = 'multipart/form-data'
    ),
    body = list(
      file = upload_file(audio_file_path),
      model = "whisper-1"
    ),
    encode = "multipart"
  )
  content <- content(response, "parsed")
  return(content)
}


#Add the user generated message to the message qeue
addUserMessage <- function(userMessage){
  
  processMessgae <- list(role = "user", content = userMessage)
  
  messages[[length(messages) + 1]] <<- processMessgae
}

#Ping the chat completions API endpoint
pingAPI <- function(userInputMessage
                    ){
  
  #url <- "https://api.openai.com/v1/chat/completions"
  url <- "https://api.groq.com/openai/v1/chat/completions"
  #url <- "http://localhost:3000/api/v1/prediction/779c8564-0600-4930-9b6c-926a1e658c5a"
  
  #apiKey <- importedAPIKey
  apiKey <-  groqKey
  
  body <- list(
    #model = "gpt-3.5-turbo",
    #model = "llama3-70b-8192",
    model = "mixtral-8x7b-32768",
    #question = userInputMessage
      messages=messages
  )
  
  response <- POST(
    url,
    add_headers(`Authorization` = paste("Bearer", apiKey),
                `Content-Type`="application/json"),
    body = body,
    encode = "json"
  )
  
  
  
  aiResponseFormatted<- list(
    role = "assistant",
    content = content(response)$choices[[1]]$message$content
      #content(response)$text
  )
  
  messages[[length(messages) + 1]] <<- aiResponseFormatted
  
  print(aiResponseFormatted$content)
}


saveMessages <- function(){
  
  write_json(messages %>% toJSON(pretty=TRUE),'messagesJSON.json')
  
  
}


createCharacterScene <- function(characterPrompt){
  
  body <- list(question = userInputMessage)
  response <- POST(
    characterCreatorURL,
    add_headers(`Content-Type` = "application/json"),
    body = body,
    encode = "json"
  )
  aiResponse <- content(response)$text
  
  return(aiResponse)
  
}

#createCharacterScene('two fighters')

formatString <- function(userInputMessage) {
  
  body <- list(question = userInputMessage)
  response <- POST(
    stringFormatURL,
    add_headers(`Content-Type` = "application/json"),
    body = body,
    encode = "json"
  )
  aiResponse <- content(response)$json$body
  
  return(aiResponse)
}


#Function to hit the speech to text API and save the output as an .mp3 file
speak_text <- function(text, 
                       model = "tts-1", 
                       voice = "onyx", 
                       output_file = "speechOutput.mp3", 
                       api_keyInput=importedAPIKey) {
  system("rm -rf speechOutput.mp3")
  
  # Create the API request body
  body <- list(model = model, 
               input = text, 
               voice = voice)
  body_json <- toJSON(body, auto_unbox = TRUE)
  
  # Create the API request
  request <- POST("https://api.openai.com/v1/audio/speech",
                  add_headers(`Authorization` = paste("Bearer", api_keyInput),
                              `Content-Type` = "application/json"),
                  body = body_json,
                  encode = "json")
  
  # Check if the request was successful
  if (status_code(request) < 200 | status_code(request) > 300) {
    stop(paste("Failed to generate speech: ", content(request, "text", encoding = "UTF-8")))
  }
  
  # Get the audio response
  response_content <- content(request, "raw")
  
  
  # Write the audio to file
  writeBin(response_content, output_file)
  
  #cat("Audio saved to", output_file, "\n")
  
  invisible(NULL)
  
  
  system(paste("afplay", "speechOutput.mp3")) 
  
  
}


speak_text2 <- function(text, 
                        voice = "s3://voice-cloning-zero-shot/2879ab87-3775-4992-a228-7e4f551658c2/fredericksaad2/manifest.json", 
                        output_file = "speechOutput.mp3") {
  
  system("rm -rf speechOutput.mp3")
  
  
  # Create the API request body
  body <- list(text = text, 
               voice = voice,
               output_format = "mp3",
               speed= 1,
               sample_rate = 44100,
               voice_engine = "PlayHT2.0-turbo")
  
  body_json <- toJSON(body, auto_unbox = TRUE)
  
  # Create the API request
  request <- POST("https://api.play.ht/api/v2/tts/stream",
                  add_headers(`Authorization` = paste(' ',speechSecret),
                              `X-USER-ID` = paste(' ',speechClient),
                              `accept` = 'audio/mpeg',
                              `Content-Type` = "application/json"),
                  body = body_json,
                  encode = "json")
  
  # Check if the request was successful
  if (status_code(request) < 200 | status_code(request) > 300) {
    stop(paste("Failed to generate speech: ", content(request, "text", encoding = "UTF-8")))
  }
  
  # Get the audio response
  response_content <- content(request, "raw")
  
  
  # Write the audio to file
  writeBin(response_content, output_file)
  
  #cat("Audio saved to", output_file, "\n")
  
  invisible(NULL)
  
  
  system(paste("afplay", "speechOutput.mp3")) 
  
  
}


speak_text3 <- function(text, 
                        voice = "Whisper") {
  
  system("rm -rf output.aiff")
  
  text <- formatString(text)
  
  sayCommand <- paste0('say -o output.aiff "', text, '" -v ', voice)
  
  system(sayCommand)
  
  suppressWarnings(suppressMessages(system("ffmpeg -y -i output.aiff speechOutput.mp3 > /dev/null 2>&1")))
  
  print('Audio Processed.....Now Playing...')
  
  system(paste("afplay", "output.aiff")) 
  
  
}

# Define the ping function for Character1
pingMe <- function(userInputMessage) {
  
  body <- list(question = userInputMessage)
  
  response <- POST(
    me_url,
    add_headers(`Content-Type` = "application/json"),
    body = body,
    encode = "json"
  )
  
  aiResponse <- content(response)$text
  
  messages[[length(messages) + 1]] <<- list(role = "assistant", content = aiResponse)
  
  speak_text(text = as.character(aiResponse),
             voice = voice1)
  
  system(paste0('cp speechOutput.mp3 ', paste0('./functionOutputs/output',length(messages),'.mp3')))
  
  print(paste(setcharacter1Name,":", aiResponse))
  
  return(aiResponse)
}

# Define the ping function for Character2
pingMeAlt <- function(userInputMessage) {
  
  body <- list(question = userInputMessage)
  
  response <- POST(
    me_alt_url,
    add_headers(`Content-Type` = "application/json"),
    body = body,
    encode = "json"
  )
  
  
  aiResponse <- content(response)$text
  
  messages[[length(messages) + 1]] <<- list(role = "assistant", content = aiResponse)
  
  speak_text(text = as.character(aiResponse),
             voice = voice2)
  
  
  system(paste0('cp speechOutput.mp3 ', paste0('./functionOutputs/output',length(messages),'.mp3')))
  
  print(paste(setcharacter2Name,":", aiResponse))
  
  return(aiResponse)
  
}


firstQuestion <- function(firstMessagePart1, firstMessagePart2){
  
  while (TRUE) {
    
    firstMessagePart1 <- firstPrompt
    firstMessagePart2 <- firstPromptSpecific
    
    firstQuery <- paste0(firstMessagePart1,firstMessagePart2)
    
    if(length(messages)<1){
      
      #firstQuery <- formatString(firstQuery)
      
      print('.....FIRST QUESTION')
      print(paste0(setcharacter2Name,': ',firstQuery))
      print('.....Beginning')
      print('____')
      #firstRequest <-pingMe(firstQuery)
      firstRequest <-pingMe(firstQuery)
      print('____')
      
    }
    
    if(length(messages)==1){
      
      stringInput <- paste0('I first said this: ',
                            firstQuery, 
                            'Which was responded to by the other person I am talking to now this way:  ',
                            messages[[length(messages)]]$content,
                            'Now its my turn to reply. from now on you are to speak in first person as me and continue the conversation exactly from here. Do not say ready. Just reply to this: ',
                            messages[[length(messages)]]$content)
      
      
      
      #userInputMessage <- pingMeAlt(formatString(stringInput))
      
      userInputMessage <- pingMeAlt(stringInput)
      
      
      
    }
    
    if(length(messages)>1){
    userInputMessage <- pingMe(messages[[length(messages)]]$content)
    pingMeAlt(userInputMessage)
    }

    print('____')
  }
  
  
}


generateSong <- function(url = "http://localhost:3001/api/generate",
                         prompt,
                         tags,
                         title,
                         make_instrumental= TRUE,
                         wait_audio = TRUE,
                         sunoSongName = 'sunoMusic'){
  

  #writeSongInfos <- list()
  # sunoSongName = 'arapsong'
  # wait_audio = TRUE
  # url = "http://localhost:3001/api/generate"
  # make_instrumental = FALSE
  # post_body <- list(prompt = "arapsong", 
  #              tags = "music, arabic, song",
  #              title = "Arapsong",
  #              make_instrumental = FALSE, 
  #              wait_audio = wait_audio)
  # body_json <- toJSON(post_body, auto_unbox = TRUE)
  
  # Create the API request body
  
  string_clean <- gsub("[[:punct:]\\s]+", "", prompt)
  
  # Convert to lowercase
  string_clean <- tolower(string_clean)
  
  body <- list(prompt = string_clean, 
               tags = tags,
               title = title,
               make_instrumental = make_instrumental, 
               wait_audio = wait_audio)
  
  body_json <- toJSON(body, auto_unbox = TRUE)
  
  # Create the API request
  request <- POST(url = url,
                  add_headers(`accept` = "application/json",
                              `Content-Type` = "application/json"),
                  body = body_json,
                  encode = "json")
  
  response_content <- content(request)
  
  #response_content[[1]]$id
  
  for (i in 1:2){
    
  
  songInfo <- GET(url =paste0("http://localhost:3001/api/get?ids=",response_content[[i]]$id)) 
  
  songInfoContent <- content(songInfo)
  
  #writeSongInfos[[length(writeSongInfos) + 1]] <- songInfoContent
  writeSongInfos[[length(writeSongInfos) + 1]] <<- songInfoContent
  
  song_request <- GET(url=songInfoContent[[1]]$audio_url) %>%
  content(type="raw")


  writeBin(song_request, paste0(sunoSongName,'_',i,'.mp3'))
  
  
  }

}


#Example Usage...still being refined
#songLyrics <- "A jovial modern techno klezmer, mix of traditional and new worlds collide"
#songLocation <- './musicOutputs/klezmerTry3'
#generateSong(prompt = songLyrics,
#             title = 'ModernKlezmer',
#             make_instrumental = TRUE,
#             tags = 'fun jovial chassidic traditionalButModern fun techno house trance',
#             sunoSongName = songLocation)



stableDiffusionImageSD3 <- function(url = "https://api.stability.ai/v2beta/stable-image/generate/sd3",
                         prompt,
                         output_format = 'jpeg',
                         fileName){
  
  command <- paste0("curl -f -sS \"https://api.stability.ai/v2beta/stable-image/generate/sd3\" \
  -H \"authorization: Bearer ",sdToken,"\" \
  -H \"accept: image/*\" \
  -F prompt=\"",prompt,"\" \
  -F output_format=\"",output_format,"\" \
  -o \"./",fileName,"\"")
  
  formattedCommand <- gsub('\n','',command)
  
  system(formattedCommand)
  
  
}


sxDL <- function(url = "https://api.stability.ai/v2beta/stable-image/generate/sd3",
                 prompt,
                 fileName){
  
  "https://api.stability.ai/v1/generation/stable-diffusion-v1-6/text-to-image"
  
  command <- paste0("curl -f -sS -X POST \"https://api.stability.ai/v1/generation/stable-diffusion-v1-6/text-to-image\" \
  -H 'Content-Type: application/json' \
  -H 'Accept: image/png' \
  -H \"Authorization: Bearer ",sdToken,"\" \
  --data-raw '{
    \"text_prompts\": [
      {
        \"text\": \",",prompt,"\"
      }
    ],
    \"cfg_scale\": 7,
    \"height\": 1024,
    \"width\": 1024,
    \"samples\": 1,
    \"steps\": 30
  }' \
  -o \"",fileName,"\"")
  
  formattedCommand <- gsub('\n','',command)
  
  system(formattedCommand)
  
  
}

#stableDiffusionImage(prompt = 'a gorgeous scene for Motzei Shabbat',
#                     fileName = 'mShabs.jpeg')

#sxDL(prompt = 'a man chilling like a villain',fileName='chilling.jpeg')

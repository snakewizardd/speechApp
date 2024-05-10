#Load libraries
source('./functions/libraries.R',local=TRUE)

#Load .env file
readRenviron(".env")

#API Keys
importedAPIKey <- Sys.getenv("OPEN_AIKEY")
groqKey <- Sys.getenv("GROQ_KEY")

#PlayHT Client and Secret
speechClient <- Sys.getenv("USERAPI")
speechSecret <- Sys.getenv("SECRETAPI")

#Loading Character Information
setcharacter1Name <- Sys.getenv("CH1Name")
setcharacter2Name <- Sys.getenv("CH2Name")

voice1 <- Sys.getenv("CH1VOICE")
voice2 <- Sys.getenv("CH2VOICE")

me_url <- Sys.getenv("CH1URL")
me_alt_url <- Sys.getenv("CH2URL")

###################

#Capturing first prompt and question
firstPrompt <- Sys.getenv("FirstPrompt")
firstPromptSpecific <- Sys.getenv("FirstPromptSpecific")

#Setting StringFormatter URL
stringFormatURL <- Sys.getenv("StringFormatURL")

characterCreatorURL <- Sys.getenv("CharacterCreatorEndpoint")
################

source('./functions/functions.R',local=TRUE)

###########################################

# Initialize the empty conversation
messages <- list()

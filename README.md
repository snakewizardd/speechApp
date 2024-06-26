*Notes:
- Added Webhook to Discord server
- Added drop down list for load of local images
- Vision now powered by GPT 4o

Current setup:

- *LLM*: Localhost KoboldCPP 
- *LLM Vision*: OpenAI GPT 4o
- *Agentic Processing*: Flowise in Docker
- *STT*: Whisper API Paid
- *TTS*: OpenAI TTS Paid 
- *SDXL*: SD API Paid
- *SD3*: SD API Paid 



___
- Added Stable Diffusion 1 and 3 functionality
- Integrated <del>Gemini</del> Vision (flexible) feature with embedded API widget

**Project Overview**
This is a web-based application built using R and Shiny, a web application framework for R. A demo video can be viewed here on [Youtube](https://www.youtube.com/watch?v=X9X6RfpwubA). It is a comprehensive audio processing and generation system that integrates various functionalities, including:

1. **Audio Recording and Transcription**: Users can record audio, and the application will transcribe the audio into text.
2. **Chatbot/LLM Integration**: The transcribed text is sent to a Large Language Model (LLM) or chatbot, which generates a response.
3. **Speech Synthesis**: The chatbot's response is converted into an audio file using a text-to-speech (TTS) engine.
4. **Music Generation**: The application can generate music based on user input, using a music generation API.

**Functionality**

The application consists of several modules:

1. **Audio Recorder**: Records user audio input.
2. **Transcription**: Transcribes the recorded audio into text.
3. **Chatbot/LLM**: Sends the transcribed text to a chatbot or LLM, which responds with a textual output.
4. **Speech Synthesis**: Converts the chatbot's response into an audio file.
5. **Music Generation**: Generates music based on user input using a music generation API.
6. **Suno Song Generation**: Generates a song using the music generation API, with options to control instrumental, tags, and title.
7. **Stable Diffusion 1 and 3**: Utilizes Stable Diffusion models for image generation and manipulation.
8. **Gemini Vision**: Integrates an embedded API widget for computer vision capabilities.

**UI Components**

The user interface includes:

1. **Audio Recorder**: Buttons for recording and stopping audio input.
2. **Transcription Box**: Displays the transcribed text.
3. **Chatbot/LLM Output**: Displays the chatbot's response.
4. **Speech Synthesis**: Button to convert the chatbot's response into an audio file.
5. **Suno Song Generation**: Inputs for title, song name, and options to generate a song.
6. **Audio Player**: Allows users to play and stop audio files.
7. **Gemini Vision Widget**: Embedded API widget for computer vision capabilities.

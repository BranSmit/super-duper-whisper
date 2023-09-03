#!/bin/bash

# Start recording. Press Ctrl+C to stop.
echo "Recording audio. Press Ctrl+C to stop..."
arecord -f cd temp_recorded_audio.wav

# Process the audio with Whisper, specifying English language.
RAW_OUTPUT=$(whisper temp_recorded_audio.wav --model base --language English)

# Extract only the transcription.
OUTPUT=$(echo "$RAW_OUTPUT" | awk -F']' '{print $2}' | sed 's/^ *//g' | tr -d '\n')

# Print the result.
echo "Transcription:"
echo "$OUTPUT"

# Copy to clipboard.
echo "$OUTPUT" | xclip -selection clipboard

# Remove the temporary file.
rm temp_recorded_audio.wav

echo "Transcription copied to clipboard!"

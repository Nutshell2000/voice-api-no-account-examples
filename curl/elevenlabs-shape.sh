#!/usr/bin/env sh
# ElevenLabs-shaped calls: same paths, same xi-api-key header, different host.
# Key: https://agent-data-tools.revmesh2074.workers.dev/credits
set -e
HOST="https://agent-data-tools.revmesh2074.workers.dev"
AUDIO="${1:-sample.wav}"

# Speech to text (Scribe shape): text, language and word timings
curl -s -X POST "$HOST/v1/speech-to-text" \
  -H "xi-api-key: $API_KEY" \
  -F "file=@$AUDIO" -F "model_id=scribe_v1"
echo

# Text to speech: MP3 bytes back, as ElevenLabs returns them (premade voice IDs map to a similar voice)
curl -s -X POST "$HOST/v1/text-to-speech/21m00Tcm4TlvDq8ikWAM" \
  -H "xi-api-key: $API_KEY" -H "Content-Type: application/json" \
  -d '{"text": "Hello from the ElevenLabs shape.", "model_id": "eleven_flash_v2_5"}' \
  -o speech.mp3
echo "Wrote speech.mp3"

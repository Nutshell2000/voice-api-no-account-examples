#!/usr/bin/env sh
# Up to 60 minutes of MP3 or WAV (25 MB) to transcript + SRT subtitles in one call, $0.05.
# By URL (below) or upload the file: curl -F "file=@episode.mp3" "$HOST/transcribe/long?subtitles=srt"
# Key: https://agent-data-tools.revmesh2074.workers.dev/credits
set -e
HOST="https://agent-data-tools.revmesh2074.workers.dev"
URL="${1:-https://upload.wikimedia.org/wikipedia/commons/6/60/Cross_of_Gold_speech_excerpt.mp3}"

curl -s -G "$HOST/transcribe/long" \
  -H "Authorization: Bearer $API_KEY" \
  --data-urlencode "url=$URL" \
  --data-urlencode "subtitles=srt" \
  > long.json

# Pull the SRT out of the JSON answer (needs jq)
jq -r .subtitles long.json > long.srt
jq -r '"\(.durationSeconds) s in \(.parts) parts, language \(.language), \(.wordCount) words"' long.json
echo "Wrote long.srt"
# Example run (15 Nov 2026): a 9 MB, 9.7-minute speech -> 581.5 s in 3 parts, language en, 1515 words

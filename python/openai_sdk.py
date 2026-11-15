"""Transcription and text to speech with the OpenAI Python SDK, pointed at a no-account endpoint.

pip install openai
export API_KEY=...   # https://agent-data-tools.revmesh2074.workers.dev/credits
python openai_sdk.py meeting.mp3
"""
import os
import sys

from openai import OpenAI

client = OpenAI(
    api_key=os.environ["API_KEY"],
    base_url="https://agent-data-tools.revmesh2074.workers.dev/v1",  # the only change from stock OpenAI code
)

audio_path = sys.argv[1] if len(sys.argv) > 1 else "sample.wav"

# 1. Transcript as JSON
with open(audio_path, "rb") as f:
    transcript = client.audio.transcriptions.create(model="whisper-1", file=f)
print("Text:", transcript.text)

# 2. The same audio as SRT subtitles (also: "vtt", "text", "verbose_json")
with open(audio_path, "rb") as f:
    srt = client.audio.transcriptions.create(model="whisper-1", file=f, response_format="srt")
with open("subtitles.srt", "w", encoding="utf-8") as out:
    out.write(srt)
print("Wrote subtitles.srt")

# 3. Text to speech (OpenAI voice names work)
speech = client.audio.speech.create(model="tts-1", voice="alloy", input="Your order has shipped and arrives on Friday.")
speech.write_to_file("speech.mp3")
print("Wrote speech.mp3")

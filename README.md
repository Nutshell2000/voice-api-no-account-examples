# Whisper and ElevenLabs-style voice API with no account: drop-in examples

Copy-paste examples for transcription (speech to text, SRT/VTT subtitles) and text to speech. They keep your
existing **OpenAI SDK** or **ElevenLabs API** code and only change the base URL and the key.

Every example in this repo was run against the live API before it was published (15 Nov 2026).

| You use today | Change this | Works for |
|---|---|---|
| OpenAI SDK (`client.audio.transcriptions`, `client.audio.speech`) | `base_url="https://agent-data-tools.revmesh2074.workers.dev/v1"` | `json`, `text`, `srt`, `vtt`, `verbose_json`; `tts-1` voices |
| ElevenLabs REST (`/v1/speech-to-text`, `/v1/text-to-speech/{voice_id}`) | host `agent-data-tools.revmesh2074.workers.dev`, same `xi-api-key` header | Scribe-shaped transcripts with word timings; premade voice IDs map to a similar voice |

## Why use it

- **No account.** A card top-up from $1 gives you a key (https://agent-data-tools.revmesh2074.workers.dev/credits).
  AI agents can also pay per call in USDC (x402 / MPP) with no key at all.
- **Transcription: an hour of audio for $0.05**, subtitles included (`/transcribe/long`, MP3/WAV up to 60 min /
  25 MB). Short clips up to 5 MB cost $0.01 a file.
- **Whisper large-v3-turbo**, 90+ languages, detected automatically or named.
- **Failed calls are never charged.** Uploaded audio is processed in memory for that one request and not stored.

When something else fits better: if you need cloned voices, speaker labels, dubbing or the most natural speech in
many languages, ElevenLabs itself is the better tool. Our text to speech covers English and Spanish.

## Examples

- [`python/openai_sdk.py`](python/openai_sdk.py): transcription (JSON and SRT) and speech with the OpenAI Python SDK
- [`node/openai-sdk.mjs`](node/openai-sdk.mjs): the same with the OpenAI Node SDK
- [`curl/elevenlabs-shape.sh`](curl/elevenlabs-shape.sh): ElevenLabs-shaped speech to text and text to speech
- [`curl/long-audio-srt.sh`](curl/long-audio-srt.sh): an hour-long recording to SRT subtitles in one call

Set your key first:

```bash
export API_KEY="..."   # from https://agent-data-tools.revmesh2074.workers.dev/credits
```

## Prices (15 Nov 2026)

| Call | Price |
|---|---|
| Transcribe a file up to 5 MB (any common format) | $0.01 |
| Transcribe up to 60 minutes (MP3/WAV, 25 MB), SRT/VTT included | $0.05 |
| Transcript + summary + action items of a recording | $0.05 |
| Text to speech, up to 300 characters | $0.01 |
| Text to speech lite (English), up to 2,000 characters | $0.04 |
| Text to speech (Aura-2, English and Spanish), up to 2,000 characters | $0.08 |

Live prices: https://agent-data-tools.revmesh2074.workers.dev/speech-to-text-api and `/text-to-speech-api`.

## No code at all?

- In the browser, free and private (the file never leaves your computer): https://glyphcall-voice.pages.dev
- Podcasts or batches of files, no code: the Apify actors
  [Audio & Video Transcriber](https://apify.com/spellzcode/audio-video-transcriber) and
  [Podcast Transcriber](https://apify.com/spellzcode/podcast-transcriber)

---

Made by SpellzCode, which runs the API these examples call. MIT licensed.

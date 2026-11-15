// Transcription and text to speech with the OpenAI Node SDK, pointed at a no-account endpoint.
//
//   npm install openai
//   API_KEY=... node openai-sdk.mjs meeting.mp3      (key: https://agent-data-tools.revmesh2074.workers.dev/credits)
import fs from 'node:fs';
import OpenAI from 'openai';

const client = new OpenAI({
  apiKey: process.env.API_KEY,
  baseURL: 'https://agent-data-tools.revmesh2074.workers.dev/v1', // the only change from stock OpenAI code
});

const audioPath = process.argv[2] ?? 'sample.wav';

// 1. Transcript as JSON
const transcript = await client.audio.transcriptions.create({ model: 'whisper-1', file: fs.createReadStream(audioPath) });
console.log('Text:', transcript.text);

// 2. The same audio as SRT subtitles (also: 'vtt', 'text', 'verbose_json')
const srt = await client.audio.transcriptions.create({ model: 'whisper-1', file: fs.createReadStream(audioPath), response_format: 'srt' });
fs.writeFileSync('subtitles.srt', srt);
console.log('Wrote subtitles.srt');

// 3. Text to speech (OpenAI voice names work)
const speech = await client.audio.speech.create({ model: 'tts-1', voice: 'alloy', input: 'Your order has shipped and arrives on Friday.' });
fs.writeFileSync('speech.mp3', Buffer.from(await speech.arrayBuffer()));
console.log('Wrote speech.mp3');

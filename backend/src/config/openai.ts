import OpenAI from 'openai';
import 'dotenv/config';

export const openai: OpenAI = new OpenAI({
    apiKey: process.env.OPENAI_API_KEY
});
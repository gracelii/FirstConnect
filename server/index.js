import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import twilio from 'twilio';


dotenv.config();
const app = express();
app.use(cors());
app.use(express.json());


const client = twilio(process.env.TWILIO_ACCOUNT_SID, process.env.TWILIO_AUTH_TOKEN);


function auth(req, res, next) {
const key = req.header('x-api-key');
if (!key || key !== process.env.API_KEY) return res.status(401).json({ error: 'unauthorized' });
next();
}


app.post('/sms', auth, async (req, res) => {
const { to, message } = req.body || {};
if (!to || !message) return res.status(400).json({ error: 'missing to/message' });
try {
const r = await client.messages.create({ to, from: process.env.TWILIO_FROM, body: message });
res.json({ sid: r.sid });
} catch (e) {
console.error(e);
res.status(500).json({ error: 'twilio_failed' });
}
});


app.get('/health', (req, res) => res.json({ ok: true }));


app.listen(process.env.PORT || 3000, () => {
console.log(`FirstConnect server listening on :${process.env.PORT || 3000}`);
});
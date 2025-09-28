# Server backend
# FirstConnect SMS microservice


A minimal SMS service for FirstConnect using Twilio. Protect with an API key and restrict by IP/firewall in production.


## Setup
1. `cp .env.example .env` and fill values.
2. `npm i` and `npm start`.
3. Expose over HTTPS (e.g., Cloud Run/Render/Fly) and set the iOS app `baseURL` and `x-api-key`.


## Endpoints
- `POST /sms` with headers `x-api-key: <key>` and body `{ "to": "+1555...", "message": "..." }`.
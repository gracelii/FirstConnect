# 🚨 FirstConnect

**FirstConnect** is an iOS app designed to improve public safety and communication during emergencies. Inspired by the ease of real-time tracking in apps like Uber and Lyft, FirstConnect allows users to see the live location and ETA of emergency responders (police, fire, EMS) when help is dispatched.  

The app also supports a **covert “Pizza Delivery Mode”** for high-risk situations (kidnapping/hostage), letting users receive disguised updates (“Pizza ready in XX minutes”) instead of revealing that law enforcement is being notified.

---

## 📱 Features

- **Real-time responder tracking**  
  Live location of fire trucks, ambulances, or police cars relative to the user.

- **Map view**  
  Google Maps SDK displays the user and responder with route and ETA.

- **Dashboard**  
  Quick stats for Active responders, En Route units, Messages, and Privacy status.

- **Responder list**  
  Filter responders by type (Police, Fire Dept, Ambulance, AAA) and view unit details.

- **Messaging**  
  Built-in chat system for dispatchers/responders to send status updates.

- **Privacy & safety settings**  
  - Toggle Pizza Delivery Mode  
  - Control location sharing  
  - Emergency SOS button and contact shortcuts  

---

## ⚙️ Technical Overview

### Frontend (iOS App)
- **Language**: Swift 5, SwiftUI  
- **Frameworks**:
  - [Google Maps iOS SDK](https://developers.google.com/maps/documentation/ios-sdk) for maps and markers
  - CoreLocation for user location tracking
- **Views**:
  - `DashboardView` – status cards and map
  - `ResponderListView` – filterable responder list
  - `MessagesView` – chat-like UI
  - `SettingsView` – privacy/safety options

### Backend (Server)
- **Language**: Node.js (Express)
- **Services**:
  - [Twilio API](https://www.twilio.com/sms) for SMS messaging (standard or covert “pizza” messages)
- **Endpoints**:
  - `POST /sms` → Sends ETA or covert messages to user
- **Security**:
  - Protected with API key header
  - `.env` file for secrets (`TWILIO_ACCOUNT_SID`, `TWILIO_AUTH_TOKEN`, `TWILIO_FROM`)

---

## 🌐 APIs & Services Used

- **Google Maps iOS SDK**  
  Displays maps, markers, and user location.

- **Google Distance Matrix API / Routes API**  
  Calculates ETA (minutes + distance) between responder and user.

- **Twilio SMS API**  
  Sends text message updates:
  - Standard: “Responder ETA ~5 minutes”  
  - Covert: “Pizza ready in ~5 minutes?”

---

## 🚀 Getting Started

### Prerequisites
- Xcode 15 or later
- CocoaPods (`brew install cocoapods`)
- Node.js (v18+)
- Twilio account + API keys
- Google Cloud API keys:
  - iOS SDK Key
  - Routes/Distance Matrix API Key

### iOS Setup
```bash
cd ios
pod install
open FirstConnect.xcworkspace

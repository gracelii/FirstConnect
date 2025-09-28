import SwiftUI


struct MessagesView: View {
struct Message: Identifiable {
let id = UUID()
let sender: String
let text: String
let time: String
let isUser: Bool
let isDispatcher: Bool
}


let messages: [Message] = [
Message(sender: "Unit 247", text: "Dispatched to your location. ETA 6 minutes.", time: "2:34 PM", isUser: false, isDispatcher: false),
Message(sender: "Dispatcher", text: "Please remain in a safe location until responders arrive.", time: "2:35 PM", isUser: false, isDispatcher: true),
Message(sender: "You", text: "Thank you, staying put.", time: "2:36 PM", isUser: true, isDispatcher: false)
]


var body: some View {
NavigationView {
List(messages) { msg in
VStack(alignment: .leading, spacing: 4) {
HStack {
if msg.isUser {
Spacer()
Text(msg.text)
.padding()
.background(Color.blue.opacity(0.2))
.cornerRadius(8)
} else if msg.isDispatcher {
Text(msg.text)
.padding()
.background(Color.yellow.opacity(0.2))
.cornerRadius(8)
Spacer()
} else {
Text(msg.text)
.padding()
.background(Color.gray.opacity(0.2))
.cornerRadius(8)
Spacer()
}
}
Text("\(msg.sender) • \(msg.time)").font(.caption).foregroundColor(.secondary)
}
}
.navigationTitle("Messages")
}
}
}
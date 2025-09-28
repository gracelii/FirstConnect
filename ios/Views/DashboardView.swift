import SwiftUI


struct DashboardView: View {
@State private var active = 1
@State private var enRoute = 1
@State private var messages = 6
@State private var privacyOn = false


var body: some View {
NavigationView {
VStack(spacing: 16) {
VStack(alignment: .leading, spacing: 4) {
Text("Emergency Response Tracker")
.font(.title2).bold()
Label("Emergency Active", systemImage: "exclamationmark.octagon.fill")
.foregroundColor(.red)
Text("Real-time responder locations and communication")
.font(.subheadline)
.foregroundColor(.secondary)
}
.padding(.bottom)


StatCard(title: "Active", value: "\(active)", icon: "person.2.fill")
StatCard(title: "En Route", value: "\(enRoute)", icon: "location.fill")
StatCard(title: "Messages", value: "\(messages)", icon: "message.fill")
StatCard(title: "Privacy", value: privacyOn ? "ON" : "OFF", icon: "lock.fill")


Spacer()
Text("Live Responder Locations")
.font(.headline)
Rectangle()
.fill(Color.gray.opacity(0.2))
.frame(height: 200)
.overlay(Text("Google Map placeholder"))
}
.padding()
.navigationTitle("Dashboard")
}
}
}


struct StatCard: View {
var title: String
var value: String
var icon: String
var body: some View {
HStack {
Label(title, systemImage: icon)
Spacer()
Text(value).bold()
}
.padding()
.background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.3)))
}
}
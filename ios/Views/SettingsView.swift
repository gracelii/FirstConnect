import SwiftUI


struct SettingsView: View {
@State private var pizzaMode = false
@State private var shareLocation = true
@State private var pushNotifications = true


var body: some View {
NavigationView {
Form {
Section(header: Text("Privacy & Safety")) {
Toggle("Pizza Delivery Mode", isOn: $pizzaMode)
Toggle("Share My Location", isOn: $shareLocation)
Toggle("Push Notifications", isOn: $pushNotifications)
}


Section(header: Text("Emergency")) {
Button("Emergency SOS") {}
.foregroundColor(.red)
Button("Medical Info") {}
}


Section(header: Text("Emergency Contacts")) {
Button("Call 911 Emergency") {}
Button("Call Local Police") {}
Button("Call Poison Control") {}
}
}
.navigationTitle("Settings")
}
}
}
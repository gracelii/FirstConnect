import SwiftUI


struct ResponderListView: View {
@State private var selectedTypes: Set<String> = ["Police"]


let types = ["Police", "Fire Dept", "Ambulance", "AAA"]


var body: some View {
NavigationView {
VStack(alignment: .leading) {
Text("Filter Responders").font(.headline)
HStack {
ForEach(types, id: \.self) { type in
Button(action: {
if selectedTypes.contains(type) {
selectedTypes.remove(type)
} else {
selectedTypes.insert(type)
}
}) {
Text(type)
.padding(8)
.background(selectedTypes.contains(type) ? Color.blue.opacity(0.2) : Color.gray.opacity(0.2))
.cornerRadius(8)
}
}
}


List {
ResponderCard(unit: "Unit 247 - Officer Johnson", type: "Police", address: "546 S. Forest Ave, Ann Arbor, MI", eta: "6:38 arrival", distance: "5 miles")
}
}
.padding()
.navigationTitle("Responders")
}
}
}


struct ResponderCard: View {
var unit: String
var type: String
var address: String
var eta: String
var distance: String


var body: some View {
VStack(alignment: .leading, spacing: 6) {
HStack {
Text(unit).bold()
Spacer()
Text("en-route").font(.caption).foregroundColor(.blue)
}
Text(type).foregroundColor(.secondary)
Label(address, systemImage: "mappin.and.ellipse")
HStack {
Label(eta, systemImage: "clock")
Text(distance).font(.subheadline)
}
HStack {
Button("Message") {}
Spacer()
Button("Call") {}
}
.padding(.top, 4)
Text("Last updated: 2 min ago").font(.caption2).foregroundColor(.secondary)
}
}
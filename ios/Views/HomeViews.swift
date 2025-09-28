import SwiftUI


struct HomeView: View {
var body: some View {
TabView {
DashboardView()
.tabItem {
Label("Map View", systemImage: "map")
}


ResponderListView()
.tabItem {
Label("Responder List", systemImage: "person.3")
}


SettingsView()
.tabItem {
Label("Settings", systemImage: "gearshape")
}
}
}
}
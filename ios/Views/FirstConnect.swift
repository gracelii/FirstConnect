import SwiftUI


@main
struct FirstConnectApp: App {
@UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate


var body: some Scene {
WindowGroup {
HomeView()
}
}
}
import SwiftUI

@main
struct SpiderSenseApp: App {

    init() {
        ReminderManager.shared.start()
    }

    var body: some Scene {

        MenuBarExtra("SpiderSense", systemImage: "spider") {

            Text("🕷️ SpiderSense")
                .font(.headline)

            Divider()

            Button("Test Spider-Sense") {
                ReminderWindowController.shared.showReminder()
            }

            Divider()

            Button("Quit SpiderSense") {
                NSApplication.shared.terminate(nil)
            }
        }
    }
}

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("🕷️ SpiderSense")
                .font(.largeTitle)
                .bold()
            
            Text("Hydration reminder system")
                .font(.headline)
            
            Button("Test Spider-Sense") {
                ReminderWindowController.shared.showReminder()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(40)
        .frame(width: 400, height: 250)
    }
}

#Preview {
    ContentView()
}

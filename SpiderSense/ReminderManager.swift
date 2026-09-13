import Foundation

final class ReminderManager {
    
    static let shared = ReminderManager()
    
    private var timer: Timer?
    private var activeSeconds: TimeInterval = 0
    
    // TESTING: 30 seconds
    // FINAL: 30 * 60 = 1800 seconds
    private let reminderInterval: TimeInterval = 30*60
    
    private init() {}
    
    func start() {
        guard timer == nil else { return }
        
        timer = Timer.scheduledTimer(
            withTimeInterval: 1,
            repeats: true
        ) { [weak self] _ in
            self?.checkActivity()
        }
        
        print("🕷️ SpiderSense monitoring started")
    }
    
    private func checkActivity() {
        
        if ActivityMonitor.shared.isUserActive() {
            activeSeconds += 1
            
            print("Active time: \(Int(activeSeconds)) seconds")
            
            if activeSeconds >= reminderInterval {
                showReminder()
            }
        } else {
            print("😴 User idle — timer paused")
        }
    }
    
    private func showReminder() {
        
        // Reset the active timer
        activeSeconds = 0
        
        // Show SpiderSense popup
        ReminderWindowController.shared.showReminder()
    }
    
    func resetTimer() {
        activeSeconds = 0
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
    }
}

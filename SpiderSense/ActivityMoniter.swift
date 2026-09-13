import Foundation
import CoreGraphics

final class ActivityMonitor {
    
    static let shared = ActivityMonitor()
    
    private init() {}
    
    func secondsSinceLastActivity() -> TimeInterval {
        return CGEventSource.secondsSinceLastEventType(
            .combinedSessionState,
            eventType: .mouseMoved
        )
    }
    
    func isUserActive() -> Bool {
        let idleTime = secondsSinceLastActivity()
        
        // Consider the user active if they
        // interacted with the Mac recently.
        return idleTime < 60
    }
}

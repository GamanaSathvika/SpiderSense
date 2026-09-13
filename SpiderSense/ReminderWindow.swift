import SwiftUI
import AppKit
import AVFoundation

// MARK: - Transparent Overlay Window

final class ReminderPanel: NSPanel {

    override var canBecomeKey: Bool {
        false
    }

    override var canBecomeMain: Bool {
        false
    }

}

// MARK: - Window Controller

final class ReminderWindowController {

    static let shared = ReminderWindowController()

    private var window: ReminderPanel?

    private init() {}

    func showReminder() {

        guard window == nil else {
            return
        }

        let mouseLocation = NSEvent.mouseLocation

        guard let screen = NSScreen.screens.first(where: {
            NSMouseInRect(mouseLocation, $0.frame, false)
        }) ?? NSScreen.main else {
            return
        }

        let screenFrame = screen.frame

        let newWindow = ReminderPanel(
            contentRect: screenFrame,
            styleMask: [
                .borderless,
                .nonactivatingPanel
            ],
            backing: .buffered,
            defer: false
        )

        // SwiftUI content
        let hostingView = NSHostingView(
            rootView: ReminderView()
        )

        // Make hosting view transparent
        hostingView.wantsLayer = true
        hostingView.layer?.backgroundColor = NSColor.clear.cgColor

        newWindow.contentView = hostingView

        // Transparent window
        newWindow.backgroundColor = NSColor.clear
        newWindow.isOpaque = false
        newWindow.hasShadow = false

        // Don't block clicks on Chrome / VS Code
        newWindow.ignoresMouseEvents = true

        // Stay above normal applications
        newWindow.level = .floating

        // Don't switch Spaces
        newWindow.collectionBehavior = [
            .canJoinAllSpaces,
            .fullScreenAuxiliary,
            .stationary,
            .ignoresCycle
        ]

        // Don't activate SpiderSense
        newWindow.orderFrontRegardless()

        self.window = newWindow
    }

    func closeReminder() {

        DispatchQueue.main.async {
            self.window?.orderOut(nil)
            self.window = nil
        }
    }
}


// MARK: - Reminder View

struct ReminderView: View {

    @State private var spiderOffset: CGFloat = -500
    @State private var spiderScale: CGFloat = 0.7

    @State private var showQuote = false
    @State private var quoteOpacity = 0.0

    @State private var audioPlayer: AVAudioPlayer?

    private let quotes = [

        "Bro. Drink some water. 🗿",

        "Your spider-sense called. It wants water.",

        "Plot twist: you're thirsty.",

        "You can fight villains, but apparently not dehydration.",

        "Peter Parker would be disappointed. Drink water.",

        "Breaking news: local hero discovers water.",

        "Sir, this is a hydration intervention.",

        "Your body has submitted a formal complaint.",

        "Drink water before your spider-sense files for resignation.",

        "POV: Your water bottle has been watching you ignore it.",

        "Web-slinging requires hydration. Probably.",

        "Great power. Great responsibility. Zero water. 🤨",

        "Spider-Man says: put the coffee down.",

        "You've been staring at that screen long enough. WATER.",

        "Hydration check! No, coffee doesn't count.",

        "Even superheroes need water breaks."

    ]

    @State private var quote = ""

    var body: some View {

        ZStack {

            // Transparent background
            Color.clear

            // MARK: Spider

            Text("🕷️")
                .font(.system(size: 80))
                .scaleEffect(spiderScale)
                .offset(y: spiderOffset)

            // MARK: Quote

            if showQuote {

                Text("“\(quote)”")
                    .font(
                        .system(
                            size: 28,
                            weight: .bold
                        )
                    )
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .frame(width: 600)
                    .padding(.vertical, 18)
                    .padding(.horizontal, 30)
                    .background(
                        Rectangle()
                            .fill(.black.opacity(0.75))
                    )
                    .opacity(quoteOpacity)
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
        .onAppear {
            startAnimation()
        }
    }


    // MARK: Animation

    private func startAnimation() {

        quote = quotes.randomElement() ?? quotes[0]

        playSound()

        // Spider starts above the screen
        spiderOffset = -500
        spiderScale = 0.7

        // Spider comes down, but NOT too far
        withAnimation(
            .easeOut(duration: 2.0)
        ) {

            spiderOffset = -180
            spiderScale = 1.0

        }


        // Show quote
        DispatchQueue.main.asyncAfter(
            deadline: .now() + 1.5
        ) {

            withAnimation(
                .easeInOut(duration: 0.5)
            ) {

                showQuote = true
                quoteOpacity = 1.0

            }
        }


        // Start disappearing
        DispatchQueue.main.asyncAfter(
            deadline: .now() + 4.0
        ) {

            withAnimation(
                .easeOut(duration: 1.0)
            ) {

                quoteOpacity = 0.0
                spiderOffset = -500

            }
        }


        // Completely remove overlay
        DispatchQueue.main.asyncAfter(
            deadline: .now() + 5.0
        ) {

            ReminderWindowController.shared.closeReminder()

        }
    }


    // MARK: Sound

    private func playSound() {

        guard let url = Bundle.main.url(
            forResource: "spider_alert",
            withExtension: "mp3"
        ) else {

            print("❌ Sound file not found")
            return
        }

        do {

            audioPlayer = try AVAudioPlayer(
                contentsOf: url
            )

            // 🔊 Reduced volume
            audioPlayer?.volume = 0.25

            audioPlayer?.play()


            // Fade sound during final second
            DispatchQueue.main.asyncAfter(
                deadline: .now() + 4.0
            ) {

                audioPlayer?.setVolume(
                    0.0,
                    fadeDuration: 1.0
                )

            }

        } catch {

            print(
                "❌ Could not play sound: \(error)"
            )

        }
    }
}

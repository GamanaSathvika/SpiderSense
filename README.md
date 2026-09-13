# 🕷️ SpiderSense

> A lightweight macOS hydration reminder that uses your activity to remind you to drink water — without interrupting your workflow.

SpiderSense is a native macOS application built with **Swift and SwiftUI**. Instead of tracking how many glasses of water you drink, SpiderSense simply monitors your active computer usage and periodically sends a fun visual reminder to take a water break.

The reminder appears directly over the application you're currently using, so you don't have to switch windows or leave your workflow.

---

## ✨ Features

- 🕷️ **Animated Spider Reminder**
  - Spiders crawl down from the top of the screen.
  - A random humorous hydration quote appears alongside the animation.

- 💧 **Activity-Based Reminders**
  - Reminders are based on active computer usage rather than wall-clock time.
  - Idle periods do not count toward the reminder interval.

- 🎭 **Non-Intrusive Overlay**
  - The reminder appears over the currently active application.
  - No focus stealing.
  - No unnecessary popup windows.

- 🔊 **Custom Sound**
  - Plays a short custom alert sound.
  - Sound volume is intentionally kept subtle.
  - Audio fades out smoothly.

- 🎨 **Transparent UI**
  - No opaque fullscreen background.
  - Only the animated reminder elements appear on screen.

- 🖥️ **Native macOS App**
  - Built using Swift + SwiftUI.
  - Uses AppKit for the transparent overlay window.

- ⚡ **Lightweight**
  - No backend.
  - No database.
  - No cloud services.
  - No hydration history or tracking.

---

## 🛠️ Tech Stack

| Technology | Purpose |
|---|---|
| **Swift** | Core application logic |
| **SwiftUI** | User interface and animations |
| **AppKit** | Native macOS window management |
| **AVFoundation** | Alert sound playback |
| **CoreGraphics** | User activity detection |
| **Xcode** | Development environment |

---

## 🏗️ Architecture

```text
                    ┌──────────────────┐
                    │    SpiderSense   │
                    │    macOS App     │
                    └────────┬─────────┘
                             │
                             ▼
                    ┌──────────────────┐
                    │ ReminderManager  │
                    │                  │
                    │ Tracks active    │
                    │ usage interval   │
                    └────────┬─────────┘
                             │
                             ▼
                    ┌──────────────────┐
                    │ ActivityMonitor  │
                    │                  │
                    │ Detects user     │
                    │ activity / idle  │
                    └────────┬─────────┘
                             │
                    Active usage reached
                             │
                             ▼
                 ┌────────────────────────┐
                 │ ReminderWindowController│
                 └────────────┬───────────┘
                              │
                              ▼
                  ┌──────────────────────┐
                  │ Transparent NSPanel  │
                  │                      │
                  │ Non-activating       │
                  │ Always-on-top        │
                  └──────────┬───────────┘
                             │
                             ▼
                    ┌──────────────────┐
                    │   ReminderView   │
                    │                  │
                    │ 🕷️ Animation     │
                    │ 💬 Random Quote  │
                    │ 🔊 Sound         │
                    └──────────────────┘
````

---

## 📂 Project Structure

```text
SpiderSense/
│
├── SpiderSenseApp.swift
│
├── ContentView.swift
│
├── ActivityMonitor.swift
│
├── ReminderManager.swift
│
├── ReminderWindow.swift
│
├── Assets.xcassets
│   └── AppIcon
│
└── spider_alert.mp3
```

### `SpiderSenseApp.swift`

Initializes the application and starts the reminder system.

### `ActivityMonitor.swift`

Handles detection of user activity and determines whether the user is currently active or idle.

### `ReminderManager.swift`

Maintains the active usage timer and determines when a hydration reminder should be triggered.

### `ReminderWindow.swift`

Responsible for the transparent overlay window, spider animation, quote display, and sound playback.

### `ContentView.swift`

Provides the basic application interface and a manual **Test Spider-Sense** button during development.

---

## 🕷️ Reminder Experience

When the active usage interval is reached:

```text
          Current Application
────────────────────────────────────

       🕷️
          🕷️
   🕷️          🕷️
        🕷️

      ┌───────────────────────┐
      │ "Plot twist: you're   │
      │       thirsty."       │
      └───────────────────────┘

────────────────────────────────────
```

The spiders animate onto the screen, a random quote appears, and a short sound plays.

After a few seconds, the entire reminder disappears automatically.

---

## ⚙️ Configuration

The reminder interval can be configured in:

```text
ReminderManager.swift
```

During development, a short interval can be used for testing:

```swift
private let reminderInterval: TimeInterval = 30
```

For the intended 30-minute interval:

```swift
private let reminderInterval: TimeInterval = 30 * 60
```

---

## 🚀 Getting Started

### Requirements

* macOS
* Xcode
* Swift
* A Mac capable of running the target macOS version

### Installation

1. Clone the repository:

```bash
git clone https://github.com/YOUR_USERNAME/SpiderSense.git
```

2. Open the project in Xcode:

```text
SpiderSense.xcodeproj
```

3. Select the **SpiderSense** target.

4. Build and run:

```text
⌘ + R
```

5. Use **Test Spider-Sense** to preview the reminder.

---

## 🔐 Permissions

SpiderSense may require appropriate macOS permissions depending on how activity monitoring is implemented.

If macOS requests permission, review:

```text
System Settings
→ Privacy & Security
```

and grant the required permission to SpiderSense.

---

## 🎯 Design Philosophy

SpiderSense intentionally avoids turning hydration into another metric to track.

There are:

* ❌ No glass counters
* ❌ No hydration logs
* ❌ No streaks
* ❌ No accounts
* ❌ No cloud database
* ❌ No unnecessary notifications

The goal is simple:

> **You've been using your Mac for a while. Take a second. Drink some water. 💧**

---

## 🔮 Future Improvements

Potential future additions include:

* ⌨️ More accurate keyboard + mouse activity detection
* 🚀 Launch automatically at login
* ⚙️ Custom reminder intervals
* 🔕 Temporary pause / snooze option
* 🕷️ More spider animation variations
* 🎵 Multiple alert sounds
* 🌙 Better handling of fullscreen applications
* 🎛️ Menu bar controls

---

## 📜 License

This project is intended as a personal learning project.

If you distribute SpiderSense publicly, make sure any bundled audio, images, or other third-party assets are appropriately licensed.

---

## 👩‍💻 Built With

**Swift · SwiftUI · AppKit · AVFoundation · CoreGraphics · Xcode**

Made with 🕷️ + 💧
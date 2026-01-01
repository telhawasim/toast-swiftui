# toast-swiftui

A lightweight, customizable toast notification library for SwiftUI.

## Features

- ✅ Top and bottom positioning
- ✅ Swipe to dismiss
- ✅ Auto-dismiss with configurable timing
- ✅ SF Symbol support
- ✅ Customizable tint colors
- ✅ Stacking multiple toasts
- ✅ iOS 17+ with @Observable

## Installation

### Swift Package Manager

Add this to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/telhawasim/toast-swiftui.git", from: "1.0.0")
]
```

## Usage

### 1. Wrap your root view

```swift
import SwiftUI
import ToastSwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            RootView {
                ContentView()
            }
        }
    }
}
```

### 2. Present toasts anywhere

```swift
import ToastSwiftUI

// Simple toast
Toast.shared.present(title: "Hello World", symbol: "hand.wave")

// Bottom toast (default)
Toast.shared.present(
    title: "Message Sent",
    symbol: "checkmark.circle.fill",
    tint: .green,
    isUserInteractionEnabled: true,
    timing: .medium,
    position: .bottom
)

// Top toast
Toast.shared.present(
    title: "Error",
    symbol: "xmark.circle.fill",
    tint: .red,
    position: .top
)
```

### API

```swift
Toast.shared.present(
    title: "Message Sent",
    symbol: "checkmark.circle.fill",
    tint: .green,
    isUserInteractionEnabled: true,
    timing: .medium,
    position: .bottom
)
```
- `title`: Message which needs to be displayed
- `symbol`: Icon which needs to be displayed using SF Symbols
- `tint`: In order to handle the color of title and icon
- `isUserInteractionEnabled`: `true` = user can swipe dismiss, `false` = user cannot swipe dismiss
- `timing`: `.short`, `.medium`, `.long`
- `position`: `.bottom`, `.top`

## Attribution / Credit

This package is based on the original work/concept demonstrated by Kavsoft:

[Kavsoft Youtube Channel](https://www.youtube.com/@Kavsoft)

> Note: This project is not affiliated with or endorsed by Kavsoft.

## Contribution

Thanks for your interest in contributing!

### Contribution policy (PRs only)

- Please **do not push directly to `main`**.
- All changes must be submitted via a **Pull Request (PR)**.
- Maintainers will review and approve PRs before merging.

GitHub branch protection is enabled on `main`, so direct pushes are blocked.

### How to contribute

1. **Fork** the repository
2. Create a new branch from `main`:

   ```bash
   git checkout -b feature/your-change

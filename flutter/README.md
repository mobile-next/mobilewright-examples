# Flutter Demo

A minimal Flutter app used to test how well mobilecli / mobilewright see Flutter
UIs. Flutter draws everything itself on a single native view, so the OS-level
dumps (`uiautomator` / DeviceKit on Android, DeviceKit on iOS) only see what
Flutter chooses to publish to the accessibility layer — not the widget tree.
Several on-screen elements are invisible or degraded unless mobilecli detects
the app is Flutter and reads the tree from the Dart VM service instead
(debug/profile builds expose it on a WebSocket, logged at app launch).

## What's on screen

- App bar title ("Flutter Demo")
- Intro text, network image
- Empty password `TextField` with `labelText: 'Password'`
- Checkbox, Submit button, status text
- "Premium package (qty: N)" row with an **icon-only "+" button** that
  increments the quantity (repro for
  [mobilewright#234](https://github.com/mobile-next/mobilewright/issues/234))
- A list of items, a profile block, and a `CustomPaint` bar chart

## What each dump misses

| Element | Android accessibility dump | iOS accessibility dump | Flutter VM service |
|---|---|---|---|
| Empty `TextField` (labelText) | hint only — surfaced as `placeholder` (no hint at all on Android ≤ 14 uiautomator) | OK (label) | OK |
| Icon-only "+" button | unlabeled `android.view.View`; was dropped entirely before mobilecli kept clickable nodes | **missing entirely** | OK — tap action + bounds |
| "Premium package" row | OK (content-desc) | **missing entirely** | OK |
| App bar title | OK | **missing entirely** | OK |
| `ListTile` with trailing tap target | merged into one node — the trailing button is not a separate element, even in raw uiautomator | merged | OK |
| `CustomPaint` chart | invisible (no semantics) | invisible | visible in widget/render tree |
| Widget types / `Semantics` identifiers | lost (everything is `android.view.View` etc.) | lost | OK |

Related issues:
[mobile-mcp#127](https://github.com/mobile-next/mobile-mcp/issues/127),
[mobile-mcp#340](https://github.com/mobile-next/mobile-mcp/issues/340),
[mobilewright#234](https://github.com/mobile-next/mobilewright/issues/234).

## Running

```sh
flutter build apk --debug          # Android
flutter build ios --simulator --debug  # iOS simulator
```

Install/launch on a device, then compare `mobilecli dump ui` against the
screen. In debug builds the app logs
`The Dart VM service is listening on http://127.0.0.1:<port>/<token>/` —
that endpoint serves the full semantics/widget tree over WebSocket.

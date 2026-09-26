# mobilewright-examples

Example projects for [mobilewright](https://github.com/mobile-next/mobilewright), end-to-end testing for iOS and Android apps.

| Example | Platform | What it shows |
|---|---|---|
| [android-custom-activity](https://github.com/mobile-next/mobilewright-examples/tree/main/android-custom-activity) | Android | Launching a specific activity directly with `launchApp(..., { activity })` |
| [flutter](https://github.com/mobile-next/mobilewright-examples/tree/main/flutter) | iOS, Android | A Flutter app for checking what mobilewright sees in Flutter UIs (Semantics, keys, icon-only buttons) |
| [sauce-labs-my-demo-app](https://github.com/mobile-next/mobilewright-examples/tree/main/sauce-labs-my-demo-app) | Android | Tests for the Sauce Labs demo app: catalog sorting, cart, login, checkout validation, mocked geolocation |
| [web-tests-on-desktop-and-mobile](https://github.com/mobile-next/mobilewright-examples/tree/main/web-tests-on-desktop-and-mobile) | Web, iOS, Android | One login test shared between Playwright on desktop Chrome and mobilewright on a mobile webview |

Each directory has its own `package.json` (the flutter one is an app, not a test project). To run one:

```sh
cd <example>
npm install
npx mobilewright test
```

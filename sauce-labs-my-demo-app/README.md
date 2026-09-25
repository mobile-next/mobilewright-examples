# sauce-labs-my-demo-app

Mobilewright tests for the [Sauce Labs My Demo App](https://github.com/saucelabs/my-demo-app-android) on Android:
catalog sorting, product details, cart, login and checkout validation.

## Install the app

Download the APK and install it on a running emulator:

```sh
curl -LO https://github.com/saucelabs/my-demo-app-android/releases/download/2.3.0/mda-2.3.0-27.apk
adb install -r mda-2.3.0-27.apk
```

On 16 KB page-size emulators, the first launch shows an "Android App Compatibility"
dialog. Tap "Don't Show Again" once, or the tests can't reach the app.

## Run

```sh
npm install
npx mobilewright test
```

Each test attaches a screenshot to the HTML report (`npx playwright show-report`).

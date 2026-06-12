import { test } from '@mobilewright/test';
import { expect } from 'mobilewright';

const PLAYGROUND_APP = 'com.mobilenext.playground';

test('launching a custom activity directly', async ({ device, screen }) => {
  // launch straight into the .WebView activity instead of the app's default launcher activity.
  await device.terminateApp(PLAYGROUND_APP).catch(() => {});
  await device.launchApp(PLAYGROUND_APP, { activity: '.LoginSuccessfulActivity' });
  await expect(screen.getByText('Web View')).toBeVisible();
});

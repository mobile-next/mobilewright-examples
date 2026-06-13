import { test } from '@mobilewright/test';
import { expect } from 'mobilewright';

const PLAYGROUND_APP = 'com.mobilenext.playground';

test('launching a custom activity directly', async ({ device, screen }) => {
  await device.terminateApp(PLAYGROUND_APP).catch(() => {});
  await device.launchApp(PLAYGROUND_APP, { activity: '.LoginSuccessfulActivity' });
  await expect(screen.getByText('You have successfully logged in', { exact: false })).toBeVisible();
});

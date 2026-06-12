import { test } from '@mobilewright/test';
import { expect } from 'mobilewright';
import type { Device, Screen, Page } from 'mobilewright';
import { submitLoginForm, expectEmptyNameError } from './webview-login.shared.js';

const PLAYGROUND_APP = 'com.mobilenext.playground';

export async function visitLoginPage(device: Device, screen: Screen): Promise<Page> {
  await device.terminateApp(PLAYGROUND_APP).catch(() => {});
  await device.launchApp(PLAYGROUND_APP);

  await screen.getByText('Web View').tap();

  const webview = screen.getByWebView();
  await webview.waitFor({ state: 'visible' });
  return await webview.page();
}

test('webview login: empty name shows the validation error', async ({ device, screen }) => {
  const page = await visitLoginPage(device, screen);
  await expectEmptyNameError(page);
});

test('webview login: submitting the form shows the native success screen', async ({ device, screen }) => {
  const page = await visitLoginPage(device, screen);
  await submitLoginForm(page, 'Diego');

  const successMessage = screen.getByText('You have successfully logged in to the native app, Diego!');
  await expect(successMessage).toBeVisible();
});

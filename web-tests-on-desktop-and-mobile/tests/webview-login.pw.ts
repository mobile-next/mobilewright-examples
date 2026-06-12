import { test, expect } from '@playwright/test';
import { submitLoginForm, expectEmptyNameError } from './webview-login.shared.js';

const LOGIN_URL = 'https://mobilewright.dev/samples/webview/';

test('webview login: empty name shows the validation error', async ({ page }) => {
  await page.goto(LOGIN_URL);
  await expectEmptyNameError(page);
});

test('webview login: submitting the form shows the in-webview success heading', async ({ page }) => {
  await page.goto(LOGIN_URL);
  await submitLoginForm(page, 'Diego');

  const heading = page.getByRole('heading', { 
    name: 'Hello there, Diego. You are still in the webview!' 
  });
  await expect(heading).toBeVisible();
});

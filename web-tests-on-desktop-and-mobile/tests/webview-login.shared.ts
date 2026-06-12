import { expect, type Page } from '@playwright/test';

export async function submitLoginForm(page: Page, name: string): Promise<void> {
  const nameField = page.locator('#name');
  await nameField.fill(name);

  const submitButton = page.getByRole('button', { name: 'Submit' });
  await submitButton.click();
}

export async function expectEmptyNameError(page: Page): Promise<void> {
  // submit with empty name to trigger validation error
  await submitLoginForm(page, '');

  // make sure we have an error message
  const error = page.locator('#error');
  await expect(error).toBeVisible();
  await expect(error).toHaveText('Please enter your name, so we could say Hello');
}

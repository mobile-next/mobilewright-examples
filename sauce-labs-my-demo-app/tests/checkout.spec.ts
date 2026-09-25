import { test, expect } from '@mobilewright/test';

test.afterEach(async ({ screen }, testInfo) => {
  await testInfo.attach('screenshot', { body: await screen.screenshot(), contentType: 'image/png' });
});

test('checkout requires login first', async ({ screen }) => {
  await screen.getByLabel('Product Image').first().tap();
  await screen.getByText('Add to cart').tap();
  await screen.getByLabel('View cart').tap();
  await screen.getByText('Proceed To Checkout').tap();

  await expect(screen.getByText('Select a username and password from the list below', { exact: false })).toBeVisible();
  await expect(screen.getByLabel('Tap to login with given credentials')).toBeVisible();
});

test('locked out user cannot log in', async ({ screen }) => {
  await screen.getByLabel('Product Image').first().tap();
  await screen.getByText('Add to cart').tap();
  await screen.getByLabel('View cart').tap();
  await screen.getByText('Proceed To Checkout').tap();

  await screen.getByText('alice@example.com (locked out)').tap();
  await screen.getByLabel('Tap to login with given credentials').tap();

  await expect(screen.getByText('Sorry this user has been locked out.')).toBeVisible();
});

test('logged in user must fill in the shipping address', async ({ screen }) => {
  await screen.getByLabel('Product Image').first().tap();
  await screen.getByText('Add to cart').tap();
  await screen.getByLabel('View cart').tap();
  await screen.getByText('Proceed To Checkout').tap();

  await screen.getByText('bod@example.com').tap();
  await screen.getByLabel('Tap to login with given credentials').tap();
  await expect(screen.getByText('Enter a shipping address')).toBeVisible();

  await screen.getByText('To Payment').tap();

  await expect(screen.getByText('Please provide your full name.')).toBeVisible();
  await expect(screen.getByText('Please provide your address.')).toBeVisible();
  await expect(screen.getByText('Please provide your city.')).toBeVisible();
});

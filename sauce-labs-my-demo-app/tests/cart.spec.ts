import { test, expect } from '@mobilewright/test';

test.afterEach(async ({ screen }, testInfo) => {
  await testInfo.attach('screenshot', { body: await screen.screenshot(), contentType: 'image/png' });
});

test('adding two backpacks updates the cart badge and total', async ({ screen }) => {
  await screen.getByLabel('Product Image').first().tap();
  await screen.getByLabel('Increase item quantity').tap();
  await screen.getByText('Add to cart').tap();

  await expect(screen.getByTestId('com.saucelabs.mydemoapp.android:id/cartTV')).toHaveText('2');

  await screen.getByLabel('View cart').tap();
  await expect(screen.getByText('My Cart')).toBeVisible();
  await expect(screen.getByText('2 Items')).toBeVisible();
  await expect(screen.getByText('$ 59.98')).toBeVisible();
});

test('removing the only item empties the cart', async ({ screen }) => {
  await screen.getByLabel('Product Image').first().tap();
  await screen.getByText('Add to cart').tap();
  await screen.getByLabel('View cart').tap();
  await expect(screen.getByText('Sauce Labs Backpack')).toBeVisible();

  await screen.getByText('Remove Item').tap();

  await expect(screen.getByText('No Items')).toBeVisible();
  await expect(screen.getByTestId('com.saucelabs.mydemoapp.android:id/cartTV')).toBeHidden();
});

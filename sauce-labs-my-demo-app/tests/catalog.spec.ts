import { test, expect } from '@mobilewright/test';

test.afterEach(async ({ screen }, testInfo) => {
  await testInfo.attach('screenshot', { body: await screen.screenshot(), contentType: 'image/png' });
});

test('catalog shows products with prices', async ({ screen }) => {
  await expect(screen.getByText('Products')).toBeVisible();
  await expect(screen.getByText('Sauce Labs Backpack')).toBeVisible();
  await expect(screen.getByLabel('Product Price').first()).toHaveText('$ 29.99');
});

test('sorting by price ascending shows the cheapest product first', async ({ screen }) => {
  await screen.getByLabel('Shows current sorting order and displays available sorting options').tap();
  await screen.getByText('Price - Ascending').tap();

  await expect(screen.getByLabel('Product Title').first()).toHaveText('Sauce Labs Onesie');
  await expect(screen.getByLabel('Product Price').first()).toHaveText('$ 7.99');
});

test('sorting by name descending shows the t-shirts first', async ({ screen }) => {
  await screen.getByLabel('Shows current sorting order and displays available sorting options').tap();
  await screen.getByText('Name - Descending').tap();

  await expect(screen.getByLabel('Product Title').first()).toHaveText('Test.allTheThings() T-Shirt (yellow)');
});

test('tapping a product opens its details page', async ({ screen }) => {
  await screen.getByLabel('Product Image').first().tap();

  await expect(screen.getByLabel('Displays selected product')).toBeVisible();
  await expect(screen.getByLabel('Displays available colors of selected product')).toBeVisible();
  await expect(screen.getByText('Add to cart')).toBeVisible();
});

import { test, expect } from '@mobilewright/test';

test.afterEach(async ({ device, screen }, testInfo) => {
  await testInfo.attach('screenshot', { body: await screen.screenshot(), contentType: 'image/png' });
  await device.setGeolocation(null);
});

test('geo location screen shows mount fuji coordinates', async ({ device, screen }) => {
  await screen.getByLabel('View menu').tap();
  await screen.getByText('Geo Location').tap();
  await screen.getByText('Start Observing').tap();

  await device.setGeolocation({ latitude: 35.3606, longitude: 138.7274 });

  await expect(screen.getByTestId('com.saucelabs.mydemoapp.android:id/latitudeTV')).toHaveText(/^35\.360/);
  await expect(screen.getByTestId('com.saucelabs.mydemoapp.android:id/longitudeTV')).toHaveText(/^138\.727/);
});

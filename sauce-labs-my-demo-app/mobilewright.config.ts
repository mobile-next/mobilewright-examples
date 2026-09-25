import { defineConfig } from 'mobilewright';

export default defineConfig({
  testDir: "./tests",
  platform: "android",
  bundleId: "com.saucelabs.mydemoapp.android",
  viewTree: 'on-failure',
  reporter: [['html', { open: 'never' }]],
});

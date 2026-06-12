import { defineConfig } from 'mobilewright';

const config = defineConfig({
  testDir: './tests',
  testMatch: ['**/*.test.ts', '**/*.mw.ts'],
  retries: 0,
  trace: 'off',
  timeout: 60_000,
  reporter: [['html']],

  projects: [
    { name: 'ios', use: { platform: 'ios' } },
    { name: 'android', use: { platform: 'android' } },
  ],
});

export default config;

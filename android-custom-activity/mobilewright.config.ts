import { defineConfig } from 'mobilewright';

const config = defineConfig({
  testDir: './tests',
  testMatch: ['**/*.test.ts', '**/*.spec.ts'],
  retries: 0,
  reporter: [['html']],
  viewTree: 'on-failure',
  
  projects: [
    { name: 'android', use: { platform: 'android' } },
  ],
});

export default config;

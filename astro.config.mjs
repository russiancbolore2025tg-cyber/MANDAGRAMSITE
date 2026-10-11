import { defineConfig } from 'astro/config';

// https://astro.build/config
export default defineConfig({
  site: 'https://mandagram.app',
  build: {
    assets: '_a',
    format: 'file',
    inlineStylesheets: 'always'
  },
  prefetch: {
    prefetchAll: false,
    defaultStrategy: 'hover'
  }
});

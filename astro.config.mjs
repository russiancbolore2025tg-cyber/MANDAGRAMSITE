import { defineConfig } from 'astro/config';

// https://astro.build/config
export default defineConfig({
  site: 'https://mandagram.com',
  trailingSlash: 'always',
  build: {
    assets: '_a',
    format: 'directory',
    inlineStylesheets: 'always'
  },
  prefetch: {
    prefetchAll: false,
    defaultStrategy: 'hover'
  }
});

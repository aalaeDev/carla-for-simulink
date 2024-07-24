import createMDX from 'fumadocs-mdx/config';

const withMDX = createMDX();

// Static export for GitHub Pages. NEXT_PUBLIC_BASE_PATH is "/<repo>" in CI and empty locally.
const basePath = process.env.NEXT_PUBLIC_BASE_PATH ?? '';

/** @type {import('next').NextConfig} */
const config = {
  reactStrictMode: true,
  output: 'export',
  basePath,
  trailingSlash: true,
  images: { unoptimized: true },
};

export default withMDX(config);

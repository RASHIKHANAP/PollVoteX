#!/bin/bash

# Step 1: Install Vue CLI (if not already installed)
echo "Installing Vue CLI..."
npm install -g @vue/cli

# Step 2: Create a new Vue.js project
echo "Creating Vue.js project..."
vue create my-advanced-theme
cd my-advanced-theme

# Step 3: Install Tailwind CSS
echo "Installing Tailwind CSS..."
npm install tailwindcss postcss autoprefixer
npx tailwindcss init

# Step 4: Configure Tailwind CSS
echo "Configuring Tailwind CSS..."
cat > src/assets/tailwind.css <<EOL
@tailwind base;
@tailwind components;
@tailwind utilities;
EOL

# Import Tailwind CSS in main.js
echo "import '@/assets/tailwind.css';" >> src/main.js

# Update tailwind.config.js
cat > tailwind.config.js <<EOL
module.exports = {
  content: [
    './public/index.html',
    './src/**/*.{vue,js,ts,jsx,tsx}',
  ],
  theme: {
    extend: {},
  },
  plugins: [],
};
EOL

# Step 5: Configure Vue.js for GitHub Pages
echo "Configuring Vue.js for GitHub Pages..."
cat > vue.config.js <<EOL
module.exports = {
  publicPath: process.env.NODE_ENV === 'production' ? '/my-advanced-theme/' : '/',
  outputDir: 'docs',
};
EOL

# Step 6: Build the project
echo "Building the project..."
npm run build

# Step 7: Initialize Git and commit changes
echo "Initializing Git and committing changes..."
git init
git add .
git commit -m "Initial commit: Vue.js + Tailwind CSS project"

# Step 8: Create a GitHub repository
echo "Creating GitHub repository..."
gh repo create my-advanced-theme --public --source=. --remote=origin

# Step 9: Push to GitHub
echo "Pushing to GitHub..."
git push -u origin main

# Step 10: Enable GitHub Pages
echo "Enabling GitHub Pages..."
gh repo edit --enable-pages --pages-branch=main --pages-source=docs

# Step 11: Open GitHub Pages URL
echo "Your GitHub Pages site is being deployed. Open the following URL in a few minutes:"
echo "https://$(git config user.name).github.io/my-advanced-theme"
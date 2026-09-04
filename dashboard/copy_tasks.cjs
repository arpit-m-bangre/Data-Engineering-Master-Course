const fs = require('fs');
const path = require('path');

try {
  // Read from the root directory
  const src = path.join(__dirname, '..', 'TODAYS_TASKS.txt');
  const destPublic = path.join(__dirname, 'public', 'TODAYS_TASKS.txt');
  const distDir = path.join(__dirname, 'dist');
  const destDist = path.join(distDir, 'TODAYS_TASKS.txt');

  if (fs.existsSync(src)) {
    // Ensure public folder exists
    const publicDir = path.join(__dirname, 'public');
    if (!fs.existsSync(publicDir)) {
      fs.mkdirSync(publicDir, { recursive: true });
    }
    fs.copyFileSync(src, destPublic);
    console.log('Successfully copied TODAYS_TASKS.txt to public folder.');

    // If dist exists, copy to dist as well
    if (fs.existsSync(distDir)) {
      fs.copyFileSync(src, destDist);
      console.log('Successfully copied TODAYS_TASKS.txt to dist folder.');
    }
  } else {
    console.warn('TODAYS_TASKS.txt not found in root. Skipping copy.');
  }
} catch (err) {
  console.error('Error copying file:', err);
}

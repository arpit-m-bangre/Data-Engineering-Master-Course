const fs = require('fs');
const path = require('path');
try {
  // Read from the root directory
  const src = path.join(__dirname, '..', 'TODAYS_TASKS.txt');
  // Copy to the public directory for Vite
  const dest = path.join(__dirname, 'public', 'TODAYS_TASKS.txt');
  
  if (fs.existsSync(src)) {
    fs.copyFileSync(src, dest);
    console.log('Successfully copied TODAYS_TASKS.txt to public folder.');
  } else {
    console.warn('TODAYS_TASKS.txt not found in root. Skipping copy.');
  }
} catch (err) {
  console.error('Error copying file:', err);
}

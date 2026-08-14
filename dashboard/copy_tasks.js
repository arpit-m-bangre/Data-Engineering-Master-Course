const fs = require('fs');
const path = require('path');
try {
  const src = path.join(__dirname, '..', 'TODAYS_TASKS.txt');
  const dest = path.join(__dirname, 'public', 'TODAYS_TASKS.txt');
  fs.copyFileSync(src, dest);
  console.log('Successfully copied TODAYS_TASKS.txt to public folder.');
} catch (err) {
  console.error('Error copying file:', err);
}

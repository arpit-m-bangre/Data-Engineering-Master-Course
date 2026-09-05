const fs = require('fs');
const path = require('path');

try {
  // Check candidate source locations
  const candidates = [
    path.join(__dirname, '..', 'TODAYS_TASKS.txt'),
    path.join(__dirname, 'TODAYS_TASKS.txt'),
    path.join(process.cwd(), '..', 'TODAYS_TASKS.txt'),
    path.join(process.cwd(), 'TODAYS_TASKS.txt'),
    path.join(__dirname, 'public', 'TODAYS_TASKS.txt')
  ];

  let foundSrc = null;
  for (const p of candidates) {
    if (fs.existsSync(p)) {
      foundSrc = p;
      break;
    }
  }

  const publicDir = path.join(__dirname, 'public');
  const destPublic = path.join(publicDir, 'TODAYS_TASKS.txt');
  const distDir = path.join(__dirname, 'dist');
  const destDist = path.join(distDir, 'TODAYS_TASKS.txt');

  if (!fs.existsSync(publicDir)) {
    fs.mkdirSync(publicDir, { recursive: true });
  }

  if (foundSrc) {
    if (foundSrc !== destPublic) {
      fs.copyFileSync(foundSrc, destPublic);
      console.log(`Successfully copied ${foundSrc} to public folder.`);
    }
    if (fs.existsSync(distDir)) {
      fs.copyFileSync(foundSrc, destDist);
      console.log(`Successfully copied ${foundSrc} to dist folder.`);
    }
    // Always sync dashboard root TODAYS_TASKS.txt so git commit carries updated content
    const destDashboardRoot = path.join(__dirname, 'TODAYS_TASKS.txt');
    if (foundSrc !== destDashboardRoot) {
      fs.copyFileSync(foundSrc, destDashboardRoot);
      console.log(`Successfully synced ${foundSrc} to dashboard root.`);
    }
  } else {
    console.warn('TODAYS_TASKS.txt not found. Using fallback.');
  }
} catch (err) {
  console.error('Error copying file:', err);
}

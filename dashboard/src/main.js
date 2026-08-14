import './style.css'

// Configuration
// Replace this with your actual GitHub Raw URL once pushed.
// Example: "https://raw.githubusercontent.com/username/repo/main/TODAYS_TASKS.txt"
const TASKS_URL = "https://raw.githubusercontent.com/arpit-m-bangre/Data-Engineering-Master-Course/main/TODAYS_TASKS.txt";

document.addEventListener('DOMContentLoaded', () => {
  const dateDisplay = document.getElementById('date-display');
  const tasksContainer = document.getElementById('tasks-container');

  // Set today's date
  const today = new Date();
  const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
  dateDisplay.textContent = today.toLocaleDateString('en-US', options);

  async function fetchTasks() {
    try {
      // Vercel build process now copies the file into the public directory
      const cacheBuster = `?t=${new Date().getTime()}`;
      const response = await fetch('/TODAYS_TASKS.txt' + cacheBuster, { cache: "no-store" });
      
      if (!response.ok) {
        throw new Error("Failed to fetch task file. Ensure it is copied to the public directory.");
      }
      
      const text = await response.text();
      renderTasks(text);
      
    } catch (error) {
      tasksContainer.innerHTML = `<div class="error">Failed to load tasks. Check console.</div>`;
      console.error(error);
    }
  }

  function renderTasks(text) {
    // Basic parser for our txt format
    const lines = text.split('\n');
    const tasks = [];
    
    let currentTask = null;
    
    for (let i = 0; i < lines.length; i++) {
      const line = lines[i].trim();
      
      // Match task line: [ ] or [x] Time : Title
      // Added (?:AM|PM) to ensure it doesn't split on the colon inside the time (e.g. 11:15)
      const taskMatch = line.match(/^\[([xX ]?)\]\s*(.*?(?:AM|PM|am|pm))\s*:\s*(.*)$/);
      if (taskMatch) {
        if (currentTask) tasks.push(currentTask);
        currentTask = {
          completed: taskMatch[1].toLowerCase() === 'x',
          time: taskMatch[2].trim(),
          title: taskMatch[3].trim(),
          link: ''
        };
      } 
      // Match link line: -> path
      else if (line.startsWith('->') && currentTask) {
        currentTask.link = line.substring(2).trim();
      }
    }
    if (currentTask) tasks.push(currentTask);
    
    tasksContainer.innerHTML = '';
    
    tasks.forEach((task, index) => {
      const card = document.createElement('div');
      card.className = `task-card ${task.completed ? 'completed' : ''}`;
      
      card.innerHTML = `
        <div class="checkbox-wrapper">
          <div class="checkbox"></div>
        </div>
        <div class="task-content">
          <span class="task-time">${task.time}</span>
          <h3 class="task-title">${task.title}</h3>
          ${task.link ? `<span class="task-link">${task.link}</span>` : ''}
        </div>
      `;
      
      // Interactive toggle for UI only (won't save back to Github automatically)
      card.querySelector('.checkbox').addEventListener('click', () => {
        card.classList.toggle('completed');
      });
      
      tasksContainer.appendChild(card);
    });
  }

  fetchTasks();
});

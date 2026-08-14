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
      let response;
      try {
        // Try fetching the live URL first
        response = await fetch(TASKS_URL, { cache: "no-store" });
        if (!response.ok) throw new Error("Live URL fail");
      } catch (e) {
        // Fallback for local testing if the live URL fails
        console.log("Live URL failed. Trying local file...", e);
        try {
          response = await fetch('/TODAYS_TASKS.txt'); 
          if (!response.ok) throw new Error("Local fail");
        } catch(e2) {
          console.log("Using fallback data for demonstration.");
          const mockData = `====================================================================
                  DAILY MISSION: 14 AUG 2026
====================================================================

[x] 11:15 AM - 11:45 AM : Core Revision (Day 1 Note)
    -> 01_SQL/03_REVISION_NOTES/2026-08-01_REVISION.md
[ ] 11:45 AM - 12:45 PM : Practice Drills (14 Qs)
    -> 01_SQL/05_INDEX_WISE_QUESTIONS/2026-08-01_QUESTIONS.SQL
[ ] 12:45 PM - 02:00 PM : LUNCH & REST
[ ] 02:00 PM - 03:00 PM : Critical Weak Spot Revision 
    -> 01_SQL/03_REVISION_NOTES/2026-08-13_REVISION.md (Focus: Constraints & TRUNCATE)
====================================================================`;
          renderTasks(mockData);
          return;
        }
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
      const taskMatch = line.match(/^\[([xX ]?)\]\s*(.*?)\s*:\s*(.*)$/);
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

/**
 * ============================================================
 *  DE MISSION CONTROL — DASHBOARD ENGINE v3.0
 *  Author  : Arpit Manoj Bangre
 *  Repo    : Data-Engineering-Master-Course
 *
 *  ARCHITECTURE (100% Reliable, 3-Layer Data Strategy):
 *
 *  Layer 1 — INSTANT (0ms, always works, no network needed)
 *    TODAYS_TASKS.txt is baked into the JS bundle at Vite build
 *    time via the `?raw` Vite import. Renders immediately, even
 *    offline. This is the "floor" — it ALWAYS works.
 *
 *  Layer 2 — LIVE STATIC (from the same Vercel deployment)
 *    After instant render, we silently refetch /TODAYS_TASKS.txt
 *    from the Vercel-served public folder. Since GitHub Actions
 *    runs a fresh build on every push, this file is always the
 *    latest version. No GitHub rate-limits.
 *
 *  Layer 3 — FALLBACK LIVE (GitHub Raw CDN)
 *    If Layers 1+2 data match (i.e., no newer version found in
 *    the static folder), we optionally try GitHub Raw as a final
 *    check. Handles edge cases where Vercel cache lags.
 *
 *  AUTO-REDEPLOY:
 *    GitHub Actions (.github/workflows/deploy-dashboard.yml) fires
 *    on every push to main that touches TODAYS_TASKS.txt. This
 *    triggers a Vercel production build which bakes the new file
 *    into the bundle AND into the /public/ static serve path.
 * ============================================================
 */

import './style.css'

// Layer 1: Tasks baked directly into the bundle at build time.
// This is the most reliable source — zero network dependency.
import BUNDLE_TASKS from '../public/TODAYS_TASKS.txt?raw'

const GITHUB_RAW_URL =
  'https://raw.githubusercontent.com/arpit-m-bangre/Data-Engineering-Master-Course/main/TODAYS_TASKS.txt'

// ─── Helpers ──────────────────────────────────────────────────────────────────

/**
 * Normalises task text to remove carriage returns and trim trailing whitespace.
 * This prevents false "new data" detections between CRLF and LF variants.
 */
function normalise(text) {
  return text.replace(/\r\n/g, '\n').replace(/\r/g, '\n').trim()
}

/**
 * Parse the TODAYS_TASKS.txt format into a structured array.
 * Supports: [!] notices, [ ] pending, [x] done, [-] cancelled tasks.
 */
function parseTasks(raw) {
  const lines = raw.split('\n')
  const tasks = []
  let currentTask = null

  for (const rawLine of lines) {
    const line = rawLine.trim()
    if (!line) continue

    // ─── [!] NOTICE LINE
    const noticeMatch = line.match(/^\[!\]\s*(.+)$/)
    if (noticeMatch) {
      if (currentTask) { tasks.push(currentTask); currentTask = null }
      tasks.push({ type: 'notice', title: noticeMatch[1].trim() })
      continue
    }

    // ─── HEADING / SEPARATOR (====, ----)
    if (/^[=\-*]{4,}$/.test(line)) {
      if (currentTask) { tasks.push(currentTask); currentTask = null }
      continue
    }

    // ─── *Note: ... FOOTER LINE
    if (line.startsWith('*Note:') || (line.startsWith('*') && !line.startsWith('**') && !line.includes('['))) {
      if (currentTask) { tasks.push(currentTask); currentTask = null }
      tasks.push({ type: 'note', title: line.replace(/^\*+|\*+$/g, '').trim() })
      continue
    }

    // ─── TASK LINE  [x] / [ ] / [-] 09:00 AM - 10:15 PM : Title
    const taskMatch = line.match(/^\[([xX\s\-]?)\]\s*([\d: APM–\-]+(?:AM|PM))\s*:\s*(.+)$/)
    if (taskMatch) {
      if (currentTask) tasks.push(currentTask)
      const marker = taskMatch[1].trim().toLowerCase()
      currentTask = {
        type: 'task',
        status: marker === 'x' ? 'done' : marker === '-' ? 'cancelled' : 'pending',
        time: taskMatch[2].trim(),
        title: taskMatch[3].trim(),
        details: []
      }
      continue
    }

    // ─── DETAIL BULLET LINE  -> ...
    if (line.startsWith('->') && currentTask) {
      currentTask.details.push(line.slice(2).trim())
    }
  }

  if (currentTask) tasks.push(currentTask)
  return tasks
}

// ─── Renderer ─────────────────────────────────────────────────────────────────

function renderTasks(rawText, container) {
  const tasks = parseTasks(rawText)
  if (tasks.length === 0) {
    container.innerHTML = '<p class="empty-state">No tasks found for today.</p>'
    return
  }

  container.innerHTML = ''

  // Progress summary
  const taskItems = tasks.filter(t => t.type === 'task')
  const doneCount = taskItems.filter(t => t.status === 'done').length
  const totalCount = taskItems.length

  if (totalCount > 0) {
    const pct = Math.round((doneCount / totalCount) * 100)
    const summary = document.createElement('div')
    summary.className = 'progress-bar-wrapper'
    summary.innerHTML = `
      <div class="progress-header">
        <span class="progress-label">Mission Progress</span>
        <span class="progress-count">${doneCount} / ${totalCount} tasks</span>
      </div>
      <div class="progress-track">
        <div class="progress-fill" style="width: ${pct}%"></div>
      </div>
      <div class="progress-pct">${pct}% Complete</div>
    `
    container.appendChild(summary)
  }

  // Task cards
  tasks.forEach(task => {
    const card = document.createElement('div')

    if (task.type === 'notice') {
      card.className = 'notice-card'
      card.innerHTML = `
        <div class="notice-icon">📢</div>
        <div class="notice-content">
          <h3 class="notice-title">${escHtml(task.title)}</h3>
        </div>
      `
    } else if (task.type === 'note') {
      card.className = 'footer-note'
      card.innerHTML = `<span class="note-icon">📌</span> ${escHtml(task.title)}`
    } else {
      // task.type === 'task'
      const statusClass = task.status === 'done'
        ? 'completed'
        : task.status === 'cancelled'
          ? 'cancelled'
          : ''

      const statusIcon = task.status === 'done'
        ? '<span class="check-icon done-icon">✓</span>'
        : task.status === 'cancelled'
          ? '<span class="check-icon cancelled-icon">✕</span>'
          : '<span class="check-icon pending-icon"></span>'

      card.className = `task-card ${statusClass}`
      card.setAttribute('data-status', task.status)
      card.innerHTML = `
        <div class="checkbox-wrapper" title="${task.status === 'pending' ? 'Click to mark done' : ''}">
          <div class="checkbox ${statusClass}">${statusIcon}</div>
        </div>
        <div class="task-content">
          <span class="task-time">${escHtml(task.time)}</span>
          <h3 class="task-title">${escHtml(task.title)}</h3>
          ${task.details && task.details.length > 0 ? task.details.map(d => `<span class="task-link">→ ${escHtml(d)}</span>`).join('') : (task.detail ? `<span class="task-link">→ ${escHtml(task.detail)}</span>` : '')}
        </div>
      `

      // Interactive toggle (UI only — doesn't write back to file)
      if (task.status === 'pending') {
        card.querySelector('.checkbox').addEventListener('click', () => {
          card.classList.toggle('completed')
          const icon = card.querySelector('.check-icon')
          if (card.classList.contains('completed')) {
            icon.textContent = '✓'
            icon.className = 'check-icon done-icon'
          } else {
            icon.textContent = ''
            icon.className = 'check-icon pending-icon'
          }
        })
      }
    }

    container.appendChild(card)
  })
}

/** Escape HTML special chars to prevent XSS */
function escHtml(str) {
  return str.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;')
}

// ─── Boot ─────────────────────────────────────────────────────────────────────

document.addEventListener('DOMContentLoaded', () => {
  const dateDisplay  = document.getElementById('date-display')
  const container    = document.getElementById('tasks-container')
  const refreshBtn   = document.getElementById('refresh-btn')
  const lastUpdated  = document.getElementById('last-updated')

  // Set today's date
  dateDisplay.textContent = new Date().toLocaleDateString('en-US', {
    weekday: 'long', year: 'numeric', month: 'long', day: 'numeric'
  })

  // ─── LAYER 1: Instant render from bundle ──────────────────────────────────
  // Fires in < 1ms. Works 100% offline. Always shows SOMETHING meaningful.
  let currentRaw = normalise(BUNDLE_TASKS)
  renderTasks(currentRaw, container)
  setLastUpdated('Loaded from build bundle (instant)')

  // ─── LAYER 2 & 3: Silent background upgrade ───────────────────────────────
  // Silently tries to get a fresher copy after page paint.
  // If we find newer data, we re-render without any flicker.
  async function tryLiveUpgrade() {
    const cb = `?_=${Date.now()}`

    // Layer 2: /TODAYS_TASKS.txt served by Vercel from public/
    // This is rebuilt fresh on every GitHub push via GitHub Actions.
    try {
      const res = await fetch('/TODAYS_TASKS.txt' + cb, { cache: 'no-store' })
      if (res.ok) {
        const text = normalise(await res.text())
        if (text && text !== currentRaw) {
          currentRaw = text
          renderTasks(currentRaw, container)
          setLastUpdated('Live — from Vercel static ✅')
          return // Job done, no need for Layer 3
        }
      }
    } catch (_) { /* silent */ }

    // Layer 3: GitHub Raw CDN (fallback, rate-limited but fine as last resort)
    try {
      const res = await fetch(GITHUB_RAW_URL + cb, { cache: 'no-store' })
      if (res.ok) {
        const text = normalise(await res.text())
        if (text && text !== currentRaw) {
          currentRaw = text
          renderTasks(currentRaw, container)
          setLastUpdated('Live — from GitHub Raw 🌐')
        } else {
          setLastUpdated('Up to date ✅')
        }
      }
    } catch (_) { /* silent — bundle data already showing */ }
  }

  function setLastUpdated(msg) {
    if (lastUpdated) {
      lastUpdated.textContent = `Last check: ${msg} · ${new Date().toLocaleTimeString()}`
    }
  }

  // Run live upgrade after first paint
  requestAnimationFrame(() => setTimeout(tryLiveUpgrade, 200))

  // Manual refresh button
  if (refreshBtn) {
    refreshBtn.addEventListener('click', async () => {
      refreshBtn.classList.add('spinning')
      refreshBtn.disabled = true
      await tryLiveUpgrade()
      refreshBtn.classList.remove('spinning')
      refreshBtn.disabled = false
    })
  }
})

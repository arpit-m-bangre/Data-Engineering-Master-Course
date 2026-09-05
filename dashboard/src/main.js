/**
 * ============================================================
 *  DE MISSION CONTROL — DASHBOARD ENGINE v4.0 (Pippo & Cap Edition)
 *  Author  : Arpit Manoj Bangre (Cap) & Pippo 🐥
 *  Repo    : Data-Engineering-Master-Course
 *
 *  FEATURES:
 *  - 100% Truthful Mission Progress Engine (Separates Active Sprints, Breaks & Deferred tasks)
 *  - Real-time Interactive Progress Bar Recalculation on Checkbox Click
 *  - Multi-layer Zero-Latency Data Pipeline (Bundle -> Vercel Static -> GitHub Raw)
 * ============================================================
 */

import './style.css'
import BUNDLE_TASKS from '../public/TODAYS_TASKS.txt?raw'

const GITHUB_RAW_URL =
  'https://raw.githubusercontent.com/arpit-m-bangre/Data-Engineering-Master-Course/main/TODAYS_TASKS.txt'

// ─── Helpers ──────────────────────────────────────────────────────────────────

function normalise(text) {
  return text.replace(/\r\n/g, '\n').replace(/\r/g, '\n').trim()
}

/**
 * Extract timestamp from DAILY MISSION: DD MMM YYYY line to prevent stale cache downgrades.
 */
function extractMissionDate(text) {
  if (!text) return 0
  const match = text.match(/DAILY MISSION:\s*(\d{1,2}\s+[A-Za-z]{3}\s+\d{4})/i)
  if (match) {
    const d = new Date(match[1])
    return isNaN(d.getTime()) ? 0 : d.getTime()
  }
  return 0
}

/**
 * Check if a title or description describes a break, recharge, meal, or personal slot.
 */
function isBreakTitle(title) {
  return /break|lunch|dinner|tea|relax|recharge|market|family|nap|sleep|meal|friends|walk|window|buffer|boot|setup|prep|flex|recovery/i.test(title) || /[☕💤🥗🍽️🏃🤝🌿]/.test(title)
}

/**
 * Parse the TODAYS_TASKS.txt format into a structured array.
 * Accurately classifies: target, notice, mustwin, stats, section headers, study tasks (pending/done/deferred), breaks/recharge slots, and notes.
 */
function parseTasks(raw) {
  const lines = raw.split('\n')
  const items = []
  let currentItem = null

  for (const rawLine of lines) {
    const line = rawLine.trim()
    if (!line) continue

    // ─── DAILY MISSION HEADER LINE
    const missionMatch = line.match(/^DAILY MISSION:\s*(.+)$/i)
    if (missionMatch) {
      if (currentItem) { items.push(currentItem); currentItem = null }
      items.push({ type: 'mission_header', text: missionMatch[1].trim() })
      continue
    }

    // ─── [🎯 CURRENT TARGET] OR [TARGET] LINE
    const targetMatch = line.match(/^\[(?:🎯\s*)?(?:CURRENT\s+)?TARGET\]:\s*(.+)$/i) || line.match(/^CURRENT TARGET:\s*(.+)$/i)
    if (targetMatch) {
      if (currentItem) { items.push(currentItem); currentItem = null }
      items.push({ type: 'target', text: targetMatch[1].trim() })
      continue
    }

    // ─── [!] NOTICE / MISSION OBJECTIVE LINE
    const noticeMatch = line.match(/^\[!\]\s*(.+)$/)
    if (noticeMatch) {
      if (currentItem) { items.push(currentItem); currentItem = null }
      items.push({ type: 'notice', title: noticeMatch[1].trim() })
      continue
    }

    // ─── DIVIDERS / SEPARATORS (====, ----)
    if (/^[=\-*]{4,}$/.test(line)) {
      if (currentItem) { items.push(currentItem); currentItem = null }
      continue
    }

    // ─── TOTAL STUDY TIME / STATS LINE
    const statsMatch = line.match(/^TOTAL (?:STUDY|ENGINEERING)[^:]*:\s*(.+)$/i) || line.match(/^TOTAL [^:]*TIME[^:]*:\s*(.+)$/i)
    if (statsMatch) {
      if (currentItem) { items.push(currentItem); currentItem = null }
      items.push({ type: 'stats', text: statsMatch[1].trim() })
      continue
    }

    // ─── *Note: ... FOOTER NOTE LINE
    if (line.startsWith('*Note:') || (line.startsWith('*') && !line.startsWith('**') && !line.includes('['))) {
      if (currentItem) { items.push(currentItem); currentItem = null }
      items.push({ type: 'note', title: line.replace(/^\*+|\*+$/g, '').trim() })
      continue
    }

    // ─── TIME-SLOT CARD LINE  [x] / [ ] / [-] HH:MM AM - HH:MM PM : Title
    const taskMatch = line.match(/^\[([xX\s\-]?)\]\s*([\d: APM–\-]+(?:AM|PM))\s*:\s*(.+)$/)
    if (taskMatch) {
      if (currentItem) items.push(currentItem)
      const marker = taskMatch[1].trim().toLowerCase()
      const time = taskMatch[2].trim()
      const title = taskMatch[3].trim()
      const isBreak = isBreakTitle(title)

      if (marker === 'x') {
        currentItem = {
          type: 'task',
          status: 'done',
          time,
          title,
          details: []
        }
      } else if (marker === '-' || marker === '–') {
        if (isBreak) {
          currentItem = {
            type: 'break',
            status: 'break',
            time,
            title,
            details: []
          }
        } else {
          // Deferred or skipped study sprint
          currentItem = {
            type: 'task',
            status: 'deferred',
            time,
            title,
            details: []
          }
        }
      } else {
        // [ ] Active pending sprint
        currentItem = {
          type: 'task',
          status: 'pending',
          time,
          title,
          details: []
        }
      }
      continue
    }

    // ─── DETAIL BULLET LINE  -> ...
    if (line.startsWith('->') && currentItem) {
      currentItem.details.push(line.slice(2).trim())
      continue
    }

    // ─── MUST-WIN / SHOULD-WIN / BONUS OUTCOMES
    if (/^\[(?:MUST-WIN|SHOULD-WIN|BONUS)[^\]]*\]/i.test(line)) {
      if (currentItem) { items.push(currentItem); currentItem = null }
      items.push({ type: 'mustwin', text: line })
      continue
    }

    // ─── SECTION HEADERS (Between dividers, e.g. MORNING BOOT & HOUSEHOLD RESET)
    if (/^[A-Z0-9\s&—\-_:()]+$/.test(line) && line.length > 3 && !line.startsWith('DAILY MISSION') && !line.startsWith('[STATUS')) {
      if (currentItem) { items.push(currentItem); currentItem = null }
      items.push({ type: 'section', title: line })
      continue
    }
  }

  if (currentItem) items.push(currentItem)
  return items
}

// ─── Renderer ─────────────────────────────────────────────────────────────────

function renderTasks(rawText, container) {
  const items = parseTasks(rawText)
  if (items.length === 0) {
    container.innerHTML = '<p class="empty-state">No tasks found for today.</p>'
    return
  }

  container.innerHTML = ''

  // ─── Update Date Banner with Parsed Mission Date
  const missionHeader = items.find(t => t.type === 'mission_header')
  const dateDisplay = document.getElementById('date-display')
  if (dateDisplay && missionHeader) {
    dateDisplay.textContent = `🗓️ ${missionHeader.text}`
  }

  // ─── Filter Categories
  const tasks = items.filter(t => t.type === 'task')
  const breaks = items.filter(t => t.type === 'break')
  const notices = items.filter(t => t.type === 'notice')

  // Calculate Actionable Mission Progress (Excludes breaks, includes active done + pending)
  function getProgressMetrics() {
    const doneTasks = tasks.filter(t => t.status === 'done')
    const pendingTasks = tasks.filter(t => t.status === 'pending')
    const deferredTasks = tasks.filter(t => t.status === 'deferred')
    const activeTotal = doneTasks.length + pendingTasks.length
    const pct = activeTotal > 0 ? Math.round((doneTasks.length / activeTotal) * 100) : 100

    return {
      doneCount: doneTasks.length,
      pendingCount: pendingTasks.length,
      deferredCount: deferredTasks.length,
      activeTotal,
      pct
    }
  }

  const initialMetrics = getProgressMetrics()

  // ─── 0. Short-Term Target / Weekly Milestone Widget (Render ONLY if active)
  const targetItem = items.find(t => t.type === 'target')
  const targetText = targetItem ? targetItem.text.trim() : ''
  const isTargetActive = targetItem && !/^(?:none|no\s+active|idle|n\/a)$/i.test(targetText) && targetText.length > 0

  if (isTargetActive) {
    const targetCardEl = document.createElement('div')
    targetCardEl.className = 'target-banner-card active'
    targetCardEl.innerHTML = `
      <div class="target-banner-header">
        <div class="target-badge-wrap">
          <span class="target-icon">🎯</span>
          <span class="target-badge badge-active">ACTIVE SHORT-TERM TARGET</span>
        </div>
        <span class="target-status-pill status-active">In Focus 🔥</span>
      </div>
      <div class="target-body">
        <p class="target-text text-active">${escHtml(targetText)}</p>
      </div>
    `
    container.appendChild(targetCardEl)
  }

  // ─── 1. Progress Bar Widget
  let progressBarEl = null
  if (initialMetrics.activeTotal > 0 || initialMetrics.deferredCount > 0) {
    progressBarEl = document.createElement('div')
    progressBarEl.className = 'progress-bar-wrapper'
    updateProgressBarUI(progressBarEl, initialMetrics)
    container.appendChild(progressBarEl)
  }

  function updateProgressBarUI(el, metrics) {
    el.innerHTML = `
      <div class="progress-header">
        <div class="progress-label-wrap">
          <span class="progress-badge">🎯 ACTIVE SPRINT GOAL</span>
          <span class="progress-label">Mission Progress</span>
        </div>
        <span class="progress-count">${metrics.doneCount} / ${metrics.activeTotal} Completed${metrics.deferredCount > 0 ? ` <span class="deferred-pill">(${metrics.deferredCount} Deferred)</span>` : ''}</span>
      </div>
      <div class="progress-track">
        <div class="progress-fill" style="width: ${metrics.pct}%"></div>
      </div>
      <div class="progress-footer-stats">
        <span class="progress-remaining">${metrics.pendingCount === 0 ? '🔥 All Active Sprints Conquered!' : `⚡ ${metrics.pendingCount} Sprint${metrics.pendingCount > 1 ? 's' : ''} Remaining`}</span>
        <span class="progress-pct">${metrics.pct}% Complete</span>
      </div>
    `
  }

  function refreshProgress() {
    if (progressBarEl) {
      updateProgressBarUI(progressBarEl, getProgressMetrics())
    }
  }

  // ─── 2. Render Cards in Chronological Flow
  items.forEach(item => {
    // Skip items that are rendered in top summary widgets
    if (item.type === 'target' || item.type === 'mustwin') {
      return
    }

    const card = document.createElement('div')

    if (item.type === 'section') {
      card.className = 'section-header-card'
      card.innerHTML = `
        <div class="section-divider-line"></div>
        <div class="section-title-wrap">
          <span class="section-title-icon">⚡</span>
          <h2 class="section-heading">${escHtml(item.title)}</h2>
        </div>
        <div class="section-divider-line"></div>
      `
    } else if (item.type === 'notice') {
      card.className = 'notice-card'
      card.innerHTML = `
        <div class="notice-icon">📢</div>
        <div class="notice-content">
          <h3 class="notice-title">${escHtml(item.title)}</h3>
        </div>
      `
    } else if (item.type === 'stats') {
      card.className = 'study-time-card'
      card.innerHTML = `
        <div class="study-time-icon">⏱️</div>
        <div class="study-time-content">
          <span class="study-time-label">Total Study Time Today</span>
          <span class="study-time-value">${escHtml(item.text)}</span>
        </div>
      `
    } else if (item.type === 'note') {
      card.className = 'footer-note'
      card.innerHTML = `<span class="note-icon">📌</span> ${escHtml(item.title)}`
    } else if (item.type === 'break') {
      // ─── RECHARGE / BREAK CARD (Peaceful, non-punitive styling)
      card.className = 'break-card'
      card.innerHTML = `
        <div class="break-icon-wrap">
          <span class="break-icon">☕</span>
        </div>
        <div class="task-content">
          <div class="break-header">
            <span class="break-time">${escHtml(item.time)}</span>
            <span class="break-badge">Recharge Window</span>
          </div>
          <h3 class="break-title">${escHtml(item.title)}</h3>
          ${item.details && item.details.length > 0 ? item.details.map(d => `<span class="task-link break-link">→ ${escHtml(d)}</span>`).join('') : ''}
        </div>
      `
    } else {
      // ─── STUDY TASK CARD (pending / done / deferred)
      const isDone = item.status === 'done'
      const isDeferred = item.status === 'deferred'

      const statusClass = isDone ? 'completed' : isDeferred ? 'deferred' : 'pending'
      const statusIcon = isDone
        ? '<span class="check-icon done-icon">✓</span>'
        : isDeferred
          ? '<span class="check-icon deferred-icon">⏳</span>'
          : '<span class="check-icon pending-icon"></span>'

      card.className = `task-card ${statusClass}`
      card.setAttribute('data-status', item.status)

      card.innerHTML = `
        <div class="checkbox-wrapper" title="${item.status === 'pending' ? 'Click to mark done' : isDone ? 'Click to unmark' : 'Deferred Sprint'}">
          <div class="checkbox ${statusClass}">${statusIcon}</div>
        </div>
        <div class="task-content">
          <div class="task-header-row">
            <span class="task-time">${escHtml(item.time)}</span>
            ${isDeferred ? '<span class="deferred-tag">Deferred</span>' : isDone ? '<span class="done-tag">Done ✓</span>' : ''}
          </div>
          <h3 class="task-title">${escHtml(item.title)}</h3>
          ${item.details && item.details.length > 0 ? item.details.map(d => `<span class="task-link">→ ${escHtml(d)}</span>`).join('') : ''}
        </div>
      `

      // Interactive toggle with live progress bar synchronization
      if (!isDeferred) {
        const checkboxEl = card.querySelector('.checkbox')
        checkboxEl.addEventListener('click', () => {
          if (item.status === 'pending') {
            item.status = 'done'
            card.className = 'task-card completed'
            card.setAttribute('data-status', 'done')
            checkboxEl.className = 'checkbox completed'
            checkboxEl.innerHTML = '<span class="check-icon done-icon">✓</span>'
          } else if (item.status === 'done') {
            item.status = 'pending'
            card.className = 'task-card pending'
            card.setAttribute('data-status', 'pending')
            checkboxEl.className = 'checkbox pending'
            checkboxEl.innerHTML = '<span class="check-icon pending-icon"></span>'
          }
          refreshProgress()
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

// ─── Boot & Zero-Stale Multi-Layer Data Pipeline ──────────────────────────────

function initDashboard() {
  const dateDisplay  = document.getElementById('date-display')
  const container    = document.getElementById('tasks-container')
  const refreshBtn   = document.getElementById('refresh-btn')
  const lastUpdated  = document.getElementById('last-updated')

  if (!container) return

  // Set today's date
  if (dateDisplay) {
    dateDisplay.textContent = new Date().toLocaleDateString('en-US', {
      weekday: 'long', year: 'numeric', month: 'long', day: 'numeric'
    })
  }

  function setLastUpdated(msg) {
    if (lastUpdated) {
      lastUpdated.textContent = `Last check: ${msg} · ${new Date().toLocaleTimeString()}`
    }
  }

  function extractMissionDate(raw) {
    const m = raw.match(/DAILY MISSION:\s*(\d{1,2}\s+[A-Z]{3}\s+\d{4})/i)
    if (m) {
      const d = new Date(m[1])
      if (!isNaN(d.getTime())) return d.getTime()
    }
    return 0
  }

  // ─── LAYER 1: Immediate Render from Build Bundle ──────────────────────────
  let currentRaw = normalise(BUNDLE_TASKS)
  renderTasks(currentRaw, container)
  setLastUpdated('Loaded from bundle ✅')

  // ─── LAYER 2: Immediate Live Zero-Cache Fetch ─────────────────────────────
  async function tryLiveUpgrade(force = false) {
    const cb = `?t=${Date.now()}_${Math.random().toString(36).substring(2, 7)}`

    // Apply upgrade if content is newer than what is currently displayed
    function applyUpgrade(newText, sourceLabel) {
      const clean = normalise(newText)
      if (!clean) return false
      const newDate = extractMissionDate(clean)
      const curDate = extractMissionDate(currentRaw)

      // Always accept newer date OR same date with different content OR forced
      if (newDate > 0 && curDate > 0 && newDate < curDate) {
        console.warn(`[Anti-Stale] Skipping older payload (${newDate} < ${curDate}) from ${sourceLabel}`)
        return false
      }

      if (clean !== currentRaw || force) {
        currentRaw = clean
        renderTasks(currentRaw, container)
        setLastUpdated(`Live — from ${sourceLabel} ✅`)
        return true
      }
      return true
    }

    // ─── LAYER 1: GitHub Raw (public repo — always latest, highest priority) ──
    try {
      const res = await fetch(GITHUB_RAW_URL + cb, {
        cache: 'no-store',
        headers: {
          'Cache-Control': 'no-cache, no-store, must-revalidate',
          'Pragma': 'no-cache'
        }
      })
      if (res.ok) {
        const text = await res.text()
        if (applyUpgrade(text, 'GitHub Raw ⚡')) return
      }
    } catch (_) { /* silent */ }

    // ─── LAYER 2: Vercel server static file (fallback) ────────────────────────
    try {
      const res = await fetch('/TODAYS_TASKS.txt' + cb, {
        cache: 'no-store',
        headers: {
          'Cache-Control': 'no-cache, no-store, must-revalidate',
          'Pragma': 'no-cache',
          'Expires': '0'
        }
      })
      if (res.ok) {
        const text = await res.text()
        if (applyUpgrade(text, 'server')) return
      }
    } catch (_) { /* silent */ }

    // ─── LAYER 3: GitHub API fallback ─────────────────────────────────────────
    try {
      const apiRes = await fetch('https://api.github.com/repos/arpit-m-bangre/Data-Engineering-Master-Course/contents/TODAYS_TASKS.txt', {
        headers: { 'Accept': 'application/vnd.github.v3.raw' }
      })
      if (apiRes.ok) {
        const text = await apiRes.text()
        if (applyUpgrade(text, 'GitHub API ⚡')) return
      }
    } catch (_) { /* silent */ }
  }

  // 1. Instant live fetch on script load
  tryLiveUpgrade(true)

  // 2. Auto-sync on window focus & tab visibility
  window.addEventListener('focus', () => tryLiveUpgrade(true))
  document.addEventListener('visibilitychange', () => {
    if (document.visibilityState === 'visible') {
      tryLiveUpgrade(true)
    }
  })

  // 3. Background periodic auto-refresh every 15 seconds
  setInterval(() => tryLiveUpgrade(false), 15000)

  // 4. Manual Refresh Button Listener
  if (refreshBtn) {
    refreshBtn.addEventListener('click', async () => {
      refreshBtn.classList.add('spinning')
      refreshBtn.disabled = true
      const walleWidget = document.getElementById('walle-widget')
      if (walleWidget) walleWidget.classList.add('scanning')
      await tryLiveUpgrade(true)
      refreshBtn.classList.remove('spinning')
      refreshBtn.disabled = false
      if (walleWidget) setTimeout(() => walleWidget.classList.remove('scanning'), 600)
    })
  }

  // 5. Interactive WALL-E widget click trigger
  const walleWidget = document.getElementById('walle-widget')
  if (walleWidget) {
    walleWidget.addEventListener('click', () => {
      walleWidget.classList.add('scanning')
      const originalText = lastUpdated ? lastUpdated.textContent : ''
      setLastUpdated('🤖 WALL-E Solar Telemetry: Dual-Fleet Operational ⚡')
      setTimeout(() => {
        walleWidget.classList.remove('scanning')
        if (lastUpdated) setLastUpdated(originalText.replace(/^Last check:\s*/, ''))
      }, 2500)
    })
  }
}

// Ensure execution across all browser loading stages
if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', initDashboard)
} else {
  initDashboard()
}



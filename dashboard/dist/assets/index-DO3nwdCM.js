(function(){let e=document.createElement(`link`).relList;if(e&&e.supports&&e.supports(`modulepreload`))return;for(let e of document.querySelectorAll(`link[rel="modulepreload"]`))n(e);new MutationObserver(e=>{for(let t of e)if(t.type===`childList`)for(let e of t.addedNodes)e.tagName===`LINK`&&e.rel===`modulepreload`&&n(e)}).observe(document,{childList:!0,subtree:!0});function t(e){let t={};return e.integrity&&(t.integrity=e.integrity),e.referrerPolicy&&(t.referrerPolicy=e.referrerPolicy),t.credentials=e.crossOrigin===`use-credentials`?`include`:e.crossOrigin===`anonymous`?`omit`:`same-origin`,t}function n(e){if(e.ep)return;e.ep=!0;let n=t(e);fetch(e.href,n)}})();var e=`====================================================================
                  DAILY MISSION: 07 SEP 2026 (MONDAY)
      [STATUS: PIPPO DE COURSE FOCUS | 4.5 HOURS ACADEMIC & CLASS 🔥]
====================================================================

[!] MISSION OBJECTIVE: ETL Foundations (5-Pillar Architecture), 4 Faculty Tasks, 14 Practice Drills, Live Class & Streak Day 34!

[🎯 CURRENT TARGET]: None

TOTAL STUDY TIME TODAY: 4.5 Hours (3.25h Core Engineering + 1.25h Live Class)

--------------------------------------------------------------------
                    PIPPO DE COURSE STUDY SPRINTS
--------------------------------------------------------------------
[ ] 09:00 AM - 10:30 AM : Sprint 1 — ETL Foundations & 5-Pillar Architecture (1.5 Hours) 🚀
    -> Open 03_ETL_DATA_PIPELINES/01_CLASS_AND_REVISION/2026-09-05_ETL_FOUNDATIONS.md.
    -> Master 3 pipeline stages (Extract, Transform, Load) and 4-tier architecture.
    -> Review 5 production traps (TRY_CAST, Idempotency, UTC, CDC).

[-] 10:30 AM - 11:00 AM : Morning Rest & Recharge ☕🌿
    -> Screen-off, hydration, and light stretch.

[ ] 11:00 AM - 12:45 PM : Sprint 2 — Medallion Lakehouse, 4 Class Tasks & 14 Practice Drills (1.75 Hours) 🚀
    -> Open 03_ETL_DATA_PIPELINES/02_TASKS_AND_DRILLS/2026-09-05_TASKS_AND_DRILLS.md.
    -> Solve 4 Faculty Tasks (E-Com Flow, Medallion Specs, Midnight Batch, Idempotency).
    -> Solve all 14 targeted practice drills in Section 2.

[-] 12:45 PM - 02:00 PM : Lunch & Midday Recharge Break 🥗🚶
    -> Nutritious meal, walk, and rest.

--------------------------------------------------------------------
                    EVENING & LIVE CLASS BLOCK
--------------------------------------------------------------------
[ ] 09:00 PM - 10:15 PM : Sprint 3 — LIVE DATA ENGINEERING CLASS (ONLINE BATCH 15) 🎓
    -> Active attendance and real-time raw notes capture.

[ ] 10:15 PM - 10:30 PM : Sprint 4 — System Sync & GitHub Push (Streak Day 34 🔥) 🚀
    -> Update trackers, rebuild dashboard, and push to GitHub.

[-] 10:30 PM - 07:00 AM : Rest & Bio-Paced Recovery Sleep 💤
    -> Wind down and 8 hours restorative sleep.

====================================================================
*Rules: Pure DE Course Focus | All Drills Solved | Finish Before Sleep*
*Daily Quote: "Mastery compounds sprint by sprint."*
====================================================================
`,t=`https://raw.githubusercontent.com/arpit-m-bangre/Data-Engineering-Master-Course/main/TODAYS_TASKS.txt`;function n(e){return e.replace(/\r\n/g,`
`).replace(/\r/g,`
`).trim()}function r(e){return/break|lunch|dinner|tea|relax|recharge|market|family|nap|sleep|meal|friends|walk|window|buffer|boot|setup|prep|flex|recovery/i.test(e)||/[☕💤🥗🍽️🏃🤝🌿]/.test(e)}function i(e){let t=e.split(`
`),n=[],i=null;for(let e of t){let t=e.trim();if(!t)continue;let a=t.match(/^DAILY MISSION:\s*(.+)$/i);if(a){i&&=(n.push(i),null),n.push({type:`mission_header`,text:a[1].trim()});continue}let o=t.match(/^\[(?:🎯\s*)?(?:CURRENT\s+)?TARGET\]:\s*(.+)$/i)||t.match(/^CURRENT TARGET:\s*(.+)$/i);if(o){i&&=(n.push(i),null),n.push({type:`target`,text:o[1].trim()});continue}let s=t.match(/^\[!\]\s*(.+)$/);if(s){i&&=(n.push(i),null),n.push({type:`notice`,title:s[1].trim()});continue}if(/^[=\-*]{4,}$/.test(t)){i&&=(n.push(i),null);continue}let c=t.match(/^TOTAL (?:STUDY|ENGINEERING)[^:]*:\s*(.+)$/i)||t.match(/^TOTAL [^:]*TIME[^:]*:\s*(.+)$/i);if(c){i&&=(n.push(i),null),n.push({type:`stats`,text:c[1].trim()});continue}if(t.startsWith(`*Note:`)||t.startsWith(`*`)&&!t.startsWith(`**`)&&!t.includes(`[`)){i&&=(n.push(i),null),n.push({type:`note`,title:t.replace(/^\*+|\*+$/g,``).trim()});continue}let l=t.match(/^\[([xX\s\-]?)\]\s*([\d: APM–\-]+(?:AM|PM))\s*:\s*(.+)$/);if(l){i&&n.push(i);let e=l[1].trim().toLowerCase(),t=l[2].trim(),a=l[3].trim(),o=r(a);i=e===`x`?{type:`task`,status:`done`,time:t,title:a,details:[]}:e===`-`||e===`–`?o?{type:`break`,status:`break`,time:t,title:a,details:[]}:{type:`task`,status:`deferred`,time:t,title:a,details:[]}:{type:`task`,status:`pending`,time:t,title:a,details:[]};continue}if(t.startsWith(`->`)&&i){i.details.push(t.slice(2).trim());continue}if(/^\[(?:MUST-WIN|SHOULD-WIN|BONUS)[^\]]*\]/i.test(t)){i&&=(n.push(i),null),n.push({type:`mustwin`,text:t});continue}if(/^[A-Z0-9\s&—\-_:()]+$/.test(t)&&t.length>3&&!t.startsWith(`DAILY MISSION`)&&!t.startsWith(`[STATUS`)){i&&=(n.push(i),null),n.push({type:`section`,title:t});continue}}return i&&n.push(i),n}function a(e,t){let n=i(e);if(n.length===0){t.innerHTML=`<p class="empty-state">No tasks found for today.</p>`;return}t.innerHTML=``;let r=n.find(e=>e.type===`mission_header`),a=document.getElementById(`date-display`);a&&r&&(a.textContent=`🗓️ ${r.text}`);let s=n.filter(e=>e.type===`task`);n.filter(e=>e.type===`break`),n.filter(e=>e.type===`notice`);function c(){let e=s.filter(e=>e.status===`done`),t=s.filter(e=>e.status===`pending`),n=s.filter(e=>e.status===`deferred`),r=e.length+t.length,i=r>0?Math.round(e.length/r*100):100;return{doneCount:e.length,pendingCount:t.length,deferredCount:n.length,activeTotal:r,pct:i}}let l=c(),u=n.find(e=>e.type===`target`),d=u?u.text.trim():``;if(u&&!/^(?:none|no\s+active|idle|n\/a)$/i.test(d)&&d.length>0){let e=document.createElement(`div`);e.className=`target-banner-card active`,e.innerHTML=`
      <div class="target-banner-header">
        <div class="target-badge-wrap">
          <span class="target-icon">🎯</span>
          <span class="target-badge badge-active">ACTIVE SHORT-TERM TARGET</span>
        </div>
        <span class="target-status-pill status-active">In Focus 🔥</span>
      </div>
      <div class="target-body">
        <p class="target-text text-active">${o(d)}</p>
      </div>
    `,t.appendChild(e)}let f=null;(l.activeTotal>0||l.deferredCount>0)&&(f=document.createElement(`div`),f.className=`progress-bar-wrapper`,p(f,l),t.appendChild(f));function p(e,t){e.innerHTML=`
      <div class="progress-header">
        <div class="progress-label-wrap">
          <span class="progress-badge">🎯 ACTIVE SPRINT GOAL</span>
          <span class="progress-label">Mission Progress</span>
        </div>
        <span class="progress-count">${t.doneCount} / ${t.activeTotal} Completed${t.deferredCount>0?` <span class="deferred-pill">(${t.deferredCount} Deferred)</span>`:``}</span>
      </div>
      <div class="progress-track">
        <div class="progress-fill" style="width: ${t.pct}%"></div>
      </div>
      <div class="progress-footer-stats">
        <span class="progress-remaining">${t.pendingCount===0?`🔥 All Active Sprints Conquered!`:`⚡ ${t.pendingCount} Sprint${t.pendingCount>1?`s`:``} Remaining`}</span>
        <span class="progress-pct">${t.pct}% Complete</span>
      </div>
    `}function m(){f&&p(f,c())}n.forEach(e=>{if(e.type===`target`||e.type===`mustwin`)return;let n=document.createElement(`div`);if(e.type===`section`)n.className=`section-header-card`,n.innerHTML=`
        <div class="section-divider-line"></div>
        <div class="section-title-wrap">
          <span class="section-title-icon">⚡</span>
          <h2 class="section-heading">${o(e.title)}</h2>
        </div>
        <div class="section-divider-line"></div>
      `;else if(e.type===`notice`)n.className=`notice-card`,n.innerHTML=`
        <div class="notice-icon">📢</div>
        <div class="notice-content">
          <h3 class="notice-title">${o(e.title)}</h3>
        </div>
      `;else if(e.type===`stats`)n.className=`study-time-card`,n.innerHTML=`
        <div class="study-time-icon">⏱️</div>
        <div class="study-time-content">
          <span class="study-time-label">Total Study Time Today</span>
          <span class="study-time-value">${o(e.text)}</span>
        </div>
      `;else if(e.type===`note`)n.className=`footer-note`,n.innerHTML=`<span class="note-icon">📌</span> ${o(e.title)}`;else if(e.type===`break`)n.className=`break-card`,n.innerHTML=`
        <div class="break-icon-wrap">
          <span class="break-icon">☕</span>
        </div>
        <div class="task-content">
          <div class="break-header">
            <span class="break-time">${o(e.time)}</span>
            <span class="break-badge">Recharge Window</span>
          </div>
          <h3 class="break-title">${o(e.title)}</h3>
          ${e.details&&e.details.length>0?e.details.map(e=>`<span class="task-link break-link">→ ${o(e)}</span>`).join(``):``}
        </div>
      `;else{let t=e.status===`done`,r=e.status===`deferred`,i=t?`completed`:r?`deferred`:`pending`,a=t?`<span class="check-icon done-icon">✓</span>`:r?`<span class="check-icon deferred-icon">⏳</span>`:`<span class="check-icon pending-icon"></span>`;if(n.className=`task-card ${i}`,n.setAttribute(`data-status`,e.status),n.innerHTML=`
        <div class="checkbox-wrapper" title="${e.status===`pending`?`Click to mark done`:t?`Click to unmark`:`Deferred Sprint`}">
          <div class="checkbox ${i}">${a}</div>
        </div>
        <div class="task-content">
          <div class="task-header-row">
            <span class="task-time">${o(e.time)}</span>
            ${r?`<span class="deferred-tag">Deferred</span>`:t?`<span class="done-tag">Done ✓</span>`:``}
          </div>
          <h3 class="task-title">${o(e.title)}</h3>
          ${e.details&&e.details.length>0?e.details.map(e=>`<span class="task-link">→ ${o(e)}</span>`).join(``):``}
        </div>
      `,!r){let t=n.querySelector(`.checkbox`);t.addEventListener(`click`,()=>{e.status===`pending`?(e.status=`done`,n.className=`task-card completed`,n.setAttribute(`data-status`,`done`),t.className=`checkbox completed`,t.innerHTML=`<span class="check-icon done-icon">✓</span>`):e.status===`done`&&(e.status=`pending`,n.className=`task-card pending`,n.setAttribute(`data-status`,`pending`),t.className=`checkbox pending`,t.innerHTML=`<span class="check-icon pending-icon"></span>`),m()})}}t.appendChild(n)})}function o(e){return e.replace(/&/g,`&amp;`).replace(/</g,`&lt;`).replace(/>/g,`&gt;`)}function s(){let r=document.getElementById(`date-display`),i=document.getElementById(`tasks-container`),o=document.getElementById(`refresh-btn`),s=document.getElementById(`last-updated`);if(!i)return;r&&(r.textContent=new Date().toLocaleDateString(`en-US`,{weekday:`long`,year:`numeric`,month:`long`,day:`numeric`}));function c(e){s&&(s.textContent=`Last check: ${e} · ${new Date().toLocaleTimeString()}`)}function l(e){let t=e.match(/DAILY MISSION:\s*(\d{1,2}\s+[A-Z]{3}\s+\d{4})/i);if(t){let e=new Date(t[1]);if(!isNaN(e.getTime()))return e.getTime()}return 0}let u=n(e);a(u,i),c(`Loaded from bundle ✅`);async function d(r=!1){let o=`?t=${Date.now()}_${Math.random().toString(36).substring(2,7)}`,s=l(e);function d(e,t){let o=n(e);if(!o)return!1;let d=l(o);return l(u),d>0&&s>0&&d<s?(console.warn(`[Anti-Stale] Rejected older payload (${d} < ${s}) from ${t}`),!1):o!==u||r?(u=o,a(u,i),c(`Live — from ${t} ✅`),!0):!0}try{let e=await fetch(`/TODAYS_TASKS.txt`+o,{cache:`no-store`,headers:{"Cache-Control":`no-cache, no-store, must-revalidate`,Pragma:`no-cache`,Expires:`0`}});if(e.ok&&d(await e.text(),`server`))return}catch{}try{let e=await fetch(t+o,{cache:`no-store`,headers:{"Cache-Control":`no-cache, no-store, must-revalidate`,Pragma:`no-cache`}});if(e.ok&&d(await e.text(),`GitHub Raw`))return}catch{}try{let e=await fetch(`https://api.github.com/repos/arpit-m-bangre/Data-Engineering-Master-Course/contents/TODAYS_TASKS.txt`,{headers:{Accept:`application/vnd.github.v3.raw`}});if(e.ok&&d(await e.text(),`GitHub API ⚡`))return}catch{}}d(!0),window.addEventListener(`focus`,()=>d(!0)),document.addEventListener(`visibilitychange`,()=>{document.visibilityState===`visible`&&d(!0)}),setInterval(()=>d(!1),15e3),o&&o.addEventListener(`click`,async()=>{o.classList.add(`spinning`),o.disabled=!0;let e=document.getElementById(`walle-widget`);e&&e.classList.add(`scanning`),await d(!0),o.classList.remove(`spinning`),o.disabled=!1,e&&setTimeout(()=>e.classList.remove(`scanning`),600)});let f=document.getElementById(`walle-widget`);f&&f.addEventListener(`click`,()=>{f.classList.add(`scanning`);let e=s?s.textContent:``;c(`🤖 WALL-E Solar Telemetry: Dual-Fleet Operational ⚡`),setTimeout(()=>{f.classList.remove(`scanning`),s&&c(e.replace(/^Last check:\s*/,``))},2500)})}document.readyState===`loading`?document.addEventListener(`DOMContentLoaded`,s):s();
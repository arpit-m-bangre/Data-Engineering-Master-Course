# 🌐 DASHBOARD AUTO-DEPLOY SYSTEM — AGENT RULE

This rule documents the live web dashboard system for `d:\DE COURSE\`.  
Every AI session MUST read and follow this rule when touching `TODAYS_TASKS.txt` or `DASHBOARD/`.

---

## 🏗️ System Architecture

```
TODAYS_TASKS.txt (root)              ← Source of Truth. Edit this daily.
        │
        ▼
git push origin main                 ← Triggers GitHub Actions automatically
        │
        ▼
.github/workflows/deploy-dashboard.yml
        │  Steps: checkout → node copy_tasks.cjs → vite build → vercel deploy
        ▼
dashboard/public/TODAYS_TASKS.txt   ← Copied by copy_tasks.cjs at build time
        │
        ▼
dashboard/src/main.js               ← Imports via `?raw` (baked into JS bundle)
        │
        ▼
Vercel Production Site              ← Auto-deployed, always shows latest tasks
```

---

## ⚡ 3-Layer Data Strategy (in main.js)

| Layer | Source | Speed | Notes |
|:--|:--|:--|:--|
| **1 — Bundle** | `?raw` import baked at build | 0ms instant | Always works, even offline |
| **2 — Vercel Static** | `/TODAYS_TASKS.txt` from public/ | ~100ms | Refreshes silently after paint |
| **3 — GitHub Raw** | `raw.githubusercontent.com` | ~300ms | Last resort fallback only |

---

## 📋 Daily Agent Workflow (MANDATORY)

When updating `TODAYS_TASKS.txt`, the agent MUST always run these commands in order:

```powershell
# 1. Make changes to TODAYS_TASKS.txt
# 2. Commit and push — GitHub Actions handles the rest automatically
git add .
git commit -m "docs: update TODAYS_TASKS.txt for [DATE]"
git push origin main
```

**DO NOT manually run `npm run build` for deployment** — GitHub Actions does this automatically when you push. Local builds are only for local testing.

---

## 🔑 Critical Configuration (DO NOT CHANGE)

| File | Purpose |
|:--|:--|
| `dashboard/vercel.json` | Vercel build config — `buildCommand`, `outputDirectory`, cache headers |
| `dashboard/copy_tasks.cjs` | Copies root `TODAYS_TASKS.txt` → `dashboard/public/TODAYS_TASKS.txt` |
| `dashboard/src/main.js` | 3-layer data engine + parser + renderer |
| `.github/workflows/deploy-dashboard.yml` | GitHub Actions CI/CD pipeline |

---

## 🔒 GitHub Secrets (Set Once — Never Touch Again)

| Secret | Value Source |
|:--|:--|
| `VERCEL_TOKEN` | From vercel.com/account/tokens |
| `VERCEL_ORG_ID` | `team_wVAjte9Uk4hktVM3KNRqHy3b` |
| `VERCEL_PROJECT_ID` | `prj_vuKdC3JsHkCdMNuSPZszFiYX7RQU` |

**⚠️ If the `VERCEL_TOKEN` expires or is revoked**, a new token must be created at `vercel.com/account/tokens` and the GitHub Secret updated. The Org ID and Project ID are permanent and never change.

---

## 🚨 Anti-Patterns — Never Do These

- ❌ Never push the `dashboard/dist/` folder to git — it is gitignored and rebuilt by Actions
- ❌ Never fetch tasks directly from GitHub Raw as the primary source (rate-limited, 429 errors)
- ❌ Never create a root-level `vercel.json` — Vercel config lives in `dashboard/vercel.json` only
- ❌ Never skip the git push thinking "I'll do it later" — the streak and site depend on it

---

## 📊 Auto-Deploy Trigger Paths

The GitHub Actions workflow fires on any push to `main` touching:
- `TODAYS_TASKS.txt`
- `dashboard/**`
- `.github/workflows/deploy-dashboard.yml`

Any other file push (e.g. SQL notes) does NOT trigger a dashboard redeploy (by design, saves build minutes).

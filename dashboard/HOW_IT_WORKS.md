# 🌐 Dashboard System — How It Works

**Project:** Data Engineering Master Course  
**Author:** Arpit Manoj Bangre  
**Last Updated:** 2026-08-17

---

## What Is This?

The `DASHBOARD/` folder contains a live web dashboard hosted on Vercel that displays your `TODAYS_TASKS.txt` schedule every day. It auto-updates within 60 seconds of every `git push`.

---

## Daily Usage (All You Do)

```powershell
# Edit TODAYS_TASKS.txt in root, then:
git add .
git commit -m "docs: update daily tasks for [DATE]"
git push origin main
# ✅ Done. Site updates automatically in ~60 seconds.
```

That's it. Nothing else needed.

---

## How It Works Internally

```
You edit TODAYS_TASKS.txt
        ↓
git push to GitHub (main branch)
        ↓
GitHub Actions fires automatically
  ├─ npm install
  ├─ node copy_tasks.cjs  →  copies .txt to public/
  ├─ vite build           →  bakes .txt into JS bundle (?raw)
  └─ vercel deploy        →  pushes to production
        ↓
Live site updates in ~60 seconds ✅
```

### 3-Layer Reliability
The site never shows stale data because of 3 fallback layers:
1. **Instant (0ms):** Tasks baked directly into the JS bundle at build time
2. **Live Static (100ms):** `/TODAYS_TASKS.txt` served from Vercel CDN (rebuilt on every push)
3. **GitHub Raw (300ms):** Last-resort fallback from raw.githubusercontent.com

---

## Key Files

| File | Role |
|:--|:--|
| `../TODAYS_TASKS.txt` | **Source of truth** — edit this daily |
| `copy_tasks.cjs` | Copies .txt to `public/` before build |
| `src/main.js` | 3-layer data engine, parser, renderer |
| `src/style.css` | Full dashboard UI styles |
| `index.html` | App shell with refresh button |
| `vercel.json` | Vercel build config + no-cache headers |
| `../.github/workflows/deploy-dashboard.yml` | Auto-deploy pipeline |

---

## GitHub Secrets (Already Configured — Do Not Touch)

| Secret | Purpose |
|:--|:--|
| `VERCEL_TOKEN` | Auth token for deploying to Vercel |
| `VERCEL_ORG_ID` | `team_wVAjte9Uk4hktVM3KNRqHy3b` |
| `VERCEL_PROJECT_ID` | `prj_vuKdC3JsHkCdMNuSPZszFiYX7RQU` |

**Only action needed:** If your `VERCEL_TOKEN` is revoked (e.g. for security), create a new one at [vercel.com/account/tokens](https://vercel.com/account/tokens) and update the GitHub Secret at:  
`github.com/arpit-m-bangre/Data-Engineering-Master-Course/settings/secrets/actions`

---

## Monitoring & Debugging

- **Watch deployments:** [github.com/arpit-m-bangre/Data-Engineering-Master-Course/actions](https://github.com/arpit-m-bangre/Data-Engineering-Master-Course/actions)
- **Dashboard page "Last check" label** shows which data layer served the content
- **Refresh button (⟳)** on the dashboard manually pulls the latest version

---

## Local Development (Optional)

```powershell
cd "d:\DE COURSE\DASHBOARD"
npm run dev      # Live preview at localhost:5173
npm run build    # Test production build locally (not needed for deployment)
```

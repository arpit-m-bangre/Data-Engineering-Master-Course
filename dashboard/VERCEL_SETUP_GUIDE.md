# 🔑 One-Time Vercel Setup (5 minutes — Do This Once, Works Forever)

## Why do this?
Once these 3 secrets are added to GitHub, the GitHub Actions workflow in
`.github/workflows/deploy-dashboard.yml` will **automatically redeploy your Vercel
website every time you push `TODAYS_TASKS.txt`**. You'll never need to manually
trigger a rebuild again.

---

## Step 1 — Get Your Vercel Token

1. Go to: https://vercel.com/account/tokens
2. Click **"Create Token"**
3. Name it: `GitHub Actions Dashboard`
4. Expiry: **No Expiration**
5. Copy the token — this is your `VERCEL_TOKEN` ✅

---

## Step 2 — Get Your Org ID and Project ID

Run this command locally once (replace `YOUR_TOKEN` with the token from Step 1):

```bash
curl -H "Authorization: Bearer YOUR_TOKEN" https://api.vercel.com/v9/projects
```

Or the easy way — connect via CLI:
1. Install Vercel CLI: `npm i -g vercel`
2. `cd d:\DE COURSE\dashboard`
3. Run: `vercel link`
4. After linking, open `dashboard/.vercel/project.json` — it contains:
   - `"projectId"` → your `VERCEL_PROJECT_ID`
   - `"orgId"` → your `VERCEL_ORG_ID`

---

## Step 3 — Add Secrets to GitHub

1. Go to: https://github.com/arpit-m-bangre/Data-Engineering-Master-Course/settings/secrets/actions
2. Click **"New repository secret"** three times, adding:

| Secret Name         | Value                              |
| :---                | :---                               |
| `VERCEL_TOKEN`      | The token from Step 1              |
| `VERCEL_ORG_ID`     | The `orgId` from Step 2            |
| `VERCEL_PROJECT_ID` | The `projectId` from Step 2        |

---

## Step 4 — Done! Test It

Push any change to `TODAYS_TASKS.txt` and visit:
https://github.com/arpit-m-bangre/Data-Engineering-Master-Course/actions

You'll see the **🚀 Auto-Deploy Dashboard to Vercel** workflow run automatically.
Within ~60 seconds, your live Vercel site will show the updated tasks.

---

## Workflow File Location
`.github/workflows/deploy-dashboard.yml`

## What Triggers the Auto-Deploy
- Any push to `main` that changes `TODAYS_TASKS.txt`
- Any push to `main` that changes files in `dashboard/`
- Any push to `main` that changes the workflow file itself

# Apex HRM — Vercel Deployment Guide

## What's in This Package

```
vercel-deploy/
├── vercel.json        ← Vercel routing (do NOT edit)
├── package.json       ← Runtime dependencies for the API
├── api/
│   └── index.js       ← Bundled Express API (serverless function)
├── index.html         ← React app entry point
├── assets/            ← JS / CSS bundles
├── schema.sql         ← Database schema (run once to set up tables)
├── .env.example       ← Copy of required environment variables
└── DEPLOY_GUIDE.md    ← This file
```

---

## Step 1 — Create a Free PostgreSQL Database

1. Go to **https://neon.tech** → Sign up (free tier is enough for most teams)
2. Create a new **Project** → give it any name (e.g. "apex-hrm")
3. Copy the **Connection String** — it looks like:
   ```
   postgresql://user:password@ep-xxx.us-east-2.aws.neon.tech/neondb?sslmode=require
   ```
4. In the Neon dashboard → **SQL Editor** → paste the entire contents of `schema.sql` and click **Run**
   - This creates all the required tables (employees, payroll, attendance, etc.)

---

## Step 2 — Deploy to Vercel

### Option A — Vercel Dashboard (easiest, no terminal needed)

1. Go to **https://vercel.com** → Log in / Sign up
2. Click **"Add New Project"**
3. Choose **"Upload"** (or connect a GitHub repo if you push the files there)
   - Drag and drop the entire `vercel-deploy/` folder
4. In the **"Configure Project"** screen:
   - **Framework Preset**: Other (leave as-is)
   - **Build Command**: *(leave blank)*
   - **Output Directory**: *(leave blank)*
5. Click **"Environment Variables"** and add these:

   | Name | Value |
   |------|-------|
   | `DATABASE_URL` | your Neon connection string from Step 1 |
   | `SESSION_SECRET` | any random string (e.g. `xK9#mP2!qR7nL4vW`) |
   | `ADMIN_PASSWORD` | your chosen admin password |
   | `NODE_ENV` | `production` |

6. Click **Deploy** — it takes about 30 seconds
7. Your app is live at `https://your-project.vercel.app` 🎉

---

### Option B — Vercel CLI (for developers)

```bash
# 1. Install Vercel CLI
npm install -g vercel

# 2. Go to this folder
cd vercel-deploy

# 3. Deploy
vercel --prod

# Follow the prompts, then set env vars in the Vercel dashboard:
# Project → Settings → Environment Variables
```

---

## Step 3 — Log In to Your App

| | |
|--|--|
| **URL** | `https://your-project.vercel.app/login` |
| **Username** | `admin` (or value of ADMIN_USERNAME env var) |
| **Password** | `admin123` (or value of ADMIN_PASSWORD env var) |

> **Security tip:** Go to Settings → Security after first login and change the admin password.

---

## Environment Variables Reference

| Variable | Required | Default | Description |
|----------|:--------:|---------|-------------|
| `DATABASE_URL` | ✅ | — | PostgreSQL connection string from Neon/Supabase |
| `SESSION_SECRET` | ✅ | (insecure default) | Random secret for session encryption |
| `ADMIN_USERNAME` | — | `admin` | Master admin username |
| `ADMIN_PASSWORD` | — | `admin123` | Master admin password — **change this!** |
| `NODE_ENV` | — | `development` | Always set to `production` on Vercel |

---

## Troubleshooting

**App shows "Application Error" or blank page**
→ Check Vercel's "Deployments" → click your latest deploy → "Functions" tab → check logs for errors
→ Most common cause: `DATABASE_URL` is missing or wrong

**Login doesn't work**
→ Make sure `DATABASE_URL` points to a database where `schema.sql` has been run
→ Default login is `admin` / `admin123` (or whatever you set in env vars)

**API returns 500 errors**
→ Open Vercel dashboard → your project → "Functions" → click the `/api` function → view real-time logs

---

## Need Help?

Email: info@apexhr.cloud

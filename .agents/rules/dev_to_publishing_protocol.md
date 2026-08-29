# 📰 PERMANENT DEV.TO PUBLISHING & ARTICLE VAULT PROTOCOL
### *Single Source of Truth for Dev.to Syndication across Pippo & Captain Arpit Manoj Bangre*

This rule governs every single Dev.to post generation, file storage structure, and call-to-action standard across all current and future sessions.

---

## 🏛️ 1. DIRECTORY VAULT ARCHITECTURE
All Dev.to assets MUST be created and archived strictly in:
`PERSONAL_BRANDING/DEV_TO_ARTICLES/`

For EVERY Dev.to article created, Pippo MUST create two dedicated files:
1. **The Comprehensive Article File:**
   - Path: `PERSONAL_BRANDING/DEV_TO_ARTICLES/YYYY-MM-DD_<TOPIC_NAME>.md`
   - Contains: Metadata header (Platform, Author, Canonical URL, Tags), Topic overview, and full documented markdown body.
2. **The 1-Click Raw Copy-Paste File:**
   - Path: `PERSONAL_BRANDING/DEV_TO_ARTICLES/YYYY-MM-DD_DEV_TO_POST_RAW_COPY.txt`
   - Contains: Pure plain-text markdown with double spacing and NO outer markdown code fences, allowing Cap to press `Ctrl + A` ➔ `Ctrl + C` ➔ `Ctrl + V` directly into Dev.to without any formatting breakage.

---

## 💼 2. MANDATORY CLOSING CALL-TO-ACTION (CTA) STANDARD
- Every Dev.to/public post MUST end ONLY with Cap's **LinkedIn profile link** as the sole networking anchor:
  ```markdown
  ---
  💡 *What's your favorite SQL execution order quirk? Drop your thoughts below!*  
  💼 *Let's connect:* [linkedin.com/in/arpitmbangre](https://www.linkedin.com/in/arpitmbangre/)
  ```
- 🔴 **STRICT PRIVACY LAW:** NEVER include `data-engineering-master-course.vercel.app` or any internal study tracker URLs in public blog posts or articles. The Vercel Mission Control is Cap's private course dashboard only.

---

## 📊 3. AUTOMATED TRACKER SYNCHRONIZATION
Whenever a new Dev.to article is generated:
1. Increment the count and mark status as `✅ Published` in `PERSONAL_BRANDING/DEV_TO_ARTICLES/00_DEV_TO_MASTER_TRACKER.md`.
2. Update the 4-week streak progress bar.
3. Commit and push atomically to GitHub.

# 🐚 Unix Scripting Tools 

This project contains three practical shell scripts written for the ** Unix Shell Scripting ** at the University of Tasmania. Each script automates real-world system administration tasks such as file management, user login monitoring, and recordkeeping.

> 👨‍💻 Author: Duc Vinh Vu  
> ⚠️ This was developed as a learning exercise, so there may be mistakes, omissions, or areas for improvement.

---

## 📁 Contents

### 📦 `cp2.sh` – Directory Sync Script
Copies files from two directories (`dir1`, `dir2`) into a new directory `dir3`, preserving timestamps. Handles:
- 🗂️ Creating `dir3` if it doesn’t exist
- 📑 Copying all files from `dir1`
- 🔁 Adding only new or updated files from `dir2`
- 🧹 Clean structure and clear output

### 👥 `mlog.sh` – User Login Monitor
Monitors users listed in `user.deny` and:
- ⏱️ Checks every 3 seconds for users with multiple logins
- 🔍 Displays a warning with the user’s full name if found
- 🧾 Continues running until manually stopped

### 🧑‍💼 `menu.sh` – Employee Record Manager
Maintains a `records` file for Dominion Consulting. Supports:
- 📋 Viewing all employee records
- 🔍 Searching (case-insensitive)
- ➕ Adding new validated records (e.g., phone, name, department)
- ❌ Deleting records based on phone number
- 🔁 Menu-driven interface with validation

---

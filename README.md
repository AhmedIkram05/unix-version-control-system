# Unix Version Control System

**A Git-like version control system built entirely in Bash — file tracking, diffs, versioned backups, and activity logging with zero external dependencies.**

[![Shell](https://img.shields.io/badge/Shell-Bash-green?style=flat-square&logo=gnu-bash)](https://www.gnu.org/software/bash/)
[![Platform](https://img.shields.io/badge/Platform-Unix%20%2F%20macOS%20%2F%20WSL-lightgrey?style=flat-square)](https://en.wikipedia.org/wiki/Unix)

---

## What It Does

A fully menu-driven version control system that mirrors the core mechanics of Git — without using Git. Built as a single Bash script using only native Unix utilities (`diff`, `zip`, `cp`, `mv`, `nano`).

It supports multiple isolated repositories, file check-in/check-out with locking, timestamped backup versioning, automatic diff generation, and a filterable activity log. All stored as plain files and directories in the local filesystem.

---

## Features

**Repository Management**
- Create, select, and switch between multiple repositories
- Archive any repository to a `.zip` for backup or distribution

**File Operations**
- Check out files for editing (with lock + timestamp logging)
- Check in changes with automatic diff generation and optional comment
- Restore any previous version from timestamped backups
- Rename/move tracked files while preserving their backup history
- Safe delete with backup retention for recovery

**Tracking & Logging**
- Every check-in/check-out is logged with timestamp and user
- View logs filtered by: all entries, specific file, check-ins only, check-outs only
- Diff shown at check-in time so you can review changes before committing

**Status & Viewing**
- Status summary: last check-in time, currently locked files, deleted files with backups
- List and view file contents from within the menu

---

## How to Run

```bash
git clone https://github.com/AhmedIkram05/unix-version-control-system.git
cd unix-version-control-system
chmod +x VersionControl.sh
./VersionControl.sh
```

**Requirements:** Any Unix/macOS system or WSL on Windows. Bash, `diff`, `zip`, and `nano` (or substitute your preferred editor).

---

## Basic Workflow

```
1. Create repository      → Menu: 1 → 1
2. Add a file to track    → Menu: 2 → 1
3. Check out for editing  → Menu: 2 → 2  (opens in nano, logs checkout)
4. Check in changes       → Menu: 2 → 3  (shows diff, creates backup, logs checkin)
5. View change history    → Menu: 3 → 4  (filter by file, type, or show all)
6. Restore previous ver.  → Menu: 2 → 4  (restores from latest timestamped backup)
```

---

## Backup System

Every check-in creates a timestamped copy:

```
repository/
├── backups/
│   ├── myfile_2025-03-01_14-22-10.txt
│   ├── myfile_2025-03-15_09-45-33.txt
│   └── myfile_2025-04-02_17-11-05.txt
├── myfile.txt
└── activity.log
```

Deleted files retain their backups and can be recovered at any time.

---

## Key Functions

| Function | Description |
|---|---|
| `createRepository()` | Initialise new repo with backup directory |
| `checkOut()` | Lock file for editing, log to activity log |
| `checkIn()` | Save changes, generate diff, create timestamped backup |
| `restore()` | Revert file to most recent backup |
| `viewLog()` | Display activity log with filtering options |
| `archiveRepository()` | Compress entire repo to `.zip` |
| `statusSummary()` | Show repo health: locked files, last check-in, deleted backups |

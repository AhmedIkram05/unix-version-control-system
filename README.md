# Unix Version Control System

## 🚀 Overview
A lightweight, Git-like version control system built entirely in Bash, designed to run natively on Unix/Mac terminals.  This project demonstrates core version control concepts including repository management, file tracking, check-out/check-in workflows, version restoration, and automated backup systems—all without relying on external version control tools.

## 🧠 Tech Stack
- **Shell Scripting**: Bash (Shell)
- **Unix Utilities**: `diff`, `zip`, `cp`, `mv`, `ls`, `nano`, `less`
- **File System Operations**: Directory and file management through native Unix commands
- **Version Control Architecture**: Custom-built change tracking and backup system

## 📊 Features
### Repository Management
- **Create Repository**: Initialize new version-controlled repositories with automatic backup directory setup
- **Select Repository**: Switch between multiple repositories with content preview
- **Archive Repository**: Create compressed `.zip` archives of entire repositories for backup or distribution

### File Operations
- **Add File**: Create and track new files within the repository
- **Check Out**:  Lock files for editing with timestamp logging and user tracking
- **Check In**: Save changes with automatic diff generation, backup creation, and optional comments
- **Restore Version**:  Roll back to previous file versions using timestamped backups
- **Delete File**:  Safely remove files with automatic backup retention for recovery

### Tracking & Logging
- **Change Tracking**: Automatic `diff` generation between file versions
- **Activity Log**: Comprehensive logging of all check-out, check-in, and modification events with timestamps
- **User Attribution**: Track which user made changes and when
- **Comment System**: Add contextual comments to check-ins for better change documentation

### Backup System
- **Automated Backups**:  Timestamped backups created on every check-in
- **Version History**:  Multiple backup versions maintained with `YYYY-MM-DD_HH-MM-SS` naming
- **Deleted File Recovery**: Restore accidentally deleted files from backup directory

## 📈 Results
- **Zero Dependencies**: Pure Bash implementation requiring no external version control tools
- **Real-time Diff Tracking**: Instant change visualization using Unix `diff` utility
- **Efficient Storage**: Only modified versions are backed up, reducing storage overhead
- **Multi-Repository Support**: Manage multiple isolated repositories from a single interface
- **Intuitive Interface**: Clear menu-driven system with organized submenus for different operations

## 🧪 How to Run

### Prerequisites
- Unix-based system (macOS, Linux, WSL on Windows)
- Bash shell (typically pre-installed)
- Basic Unix utilities (`zip`, `diff`, `nano` or another text editor)

### Installation & Execution

1. **Clone the repository**
   ```bash
   git clone https://github.com/AhmedIkram05/unix-version-control-system.git
   cd unix-version-control-system
   ```

2. **Make the script executable**
   ```bash
   chmod +x VersionControl.sh
   ```

3. **Run the version control system**
   ```bash
   ./VersionControl.sh
   ```

### Basic Usage Workflow

1. **Create a new repository** (Menu:  1 → 1)
   - Enter a repository name when prompted
   - A directory with backup folder will be created

2. **Add files to your repository** (Menu: 2 → 1)
   - Enter the filename you want to track

3. **Check out a file for editing** (Menu: 2 → 2)
   - Select the file to edit
   - The file will open in `nano` editor
   - Make your changes and save (Ctrl+O, then Ctrl+X)

4. **Check in your changes** (Menu: 2 → 3)
   - Enter the filename you edited
   - View the automatic diff of your changes
   - Add an optional comment describing your modifications
   - A timestamped backup is automatically created

5. **View change history**
   - Check the `log.txt` file in your repository folder
   - Review all check-ins, check-outs, and changes with diffs

6. **Restore previous versions** (Menu: 2 → 4)
   - Enter the filename to restore
   - The most recent backup will be restored

## 🛠️ Key Functions
- `createRepository()` - Initialize new version control repositories
- `selectRepository()` - Switch active repository context
- `addFile()` - Add files to version tracking
- `checkOut()` - Lock files for editing with logging
- `checkIn()` - Save changes with diff generation and backup
- `restore()` - Revert to previous file versions
- `archiveRepository()` - Create compressed repository archives
- `deleteFile()` - Safe file deletion with backup retention

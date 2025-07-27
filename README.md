# Auto File Organizer

A Bash script that organizes files in a specified folder into subfolders based on file type. It uses both file extensions and MIME types to determine where a file belongs.

This was built as a hands-on project while learning Bash and exploring DevOps tools. The goal was to create something useful and improve it incrementally.

## Features

- Organizes files based on their extension or detected MIME type
- Creates destination folders automatically if they don't exist
- Basic logging to track what was moved and where
- Works on macOS (requires Bash 4+)

## Usage

By default, the script organizes the Downloads folder, but you can pass any target folder as an argument.

```bash
/opt/homebrew/bin/bash organise.sh [target-folder]
# Example:
bash /opt/homebrew/bin/bash organise.sh ~/test_organiser

Requirements
Bash 4 or higher (macOS ships with Bash 3 by default)

On macOS, you can install a newer version using Homebrew:

bash
Copy
Edit
brew install bash
file command (comes with most Unix systems)

Logging
All activity is logged in a file named organise.log in the same folder as the script. This includes timestamps, file names, and destination folders.

File Type Support
The script currently supports the following categories:

Images: jpg, jpeg, png, gif, bmp, webp

Documents: pdf, docx, txt, csv

Audio: mp3

Video: mp4

Archives: zip

Others: fallback for anything not matched

You can add more types by editing the FILE_TYPES and MIME_TYPES mappings in the script.

To Do
Add a dry-run option

Add CLI flags for more control (--help, --dry-run, etc.)

Refactor into a more flexible CLI tool

Package for easier installation and reuse

Why I Built This
This script is part of my ongoing journey into DevOps. I wanted to create a small, focused tool that helps automate repetitive tasks while getting hands-on practice with Bash, Git, and scripting best practices.


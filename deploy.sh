#!/bin/bash

# Step 1: Replace URLs in the new static files
echo "Replacing URLs (wp.patrickcoombe.com -> patrickcoombe.com) in /var/www/static-new..."
find /var/www/static-new -type f -exec sed -i 's|https://wp.patrickcoombe.com|https://patrickcoombe.com|g' {} +
find /var/www/static-new -type f -exec sed -i 's|http://wp.patrickcoombe.com|https://patrickcoombe.com|g' {} +

# Step 2: Remove old files in /root/static
echo "Removing old files in /root/static..."
rm -rf /root/static/*

# Step 3: Copy new files to /root/static
echo "Copying new files from /var/www/static-new to /root/static..."
cp -r /var/www/static-new/* /root/static/

# Step 4: Run Git commands interactively
echo "Navigating to /root/static and running Git commands..."
cd /root/static

# Stage all changes
git add .

# Show status and prompt to continue
echo "Here are the changes to be committed:"
git status
read -p "Press Enter to continue with the commit, or Ctrl+C to cancel..."

# Interactive commit (prompt for commit message)
echo "Enter your commit message (e.g., 'Updated static site with new content'):"
read commit_message
git commit -m "$commit_message"

# Show the push command and prompt to proceed
echo "Ready to push changes to GitHub (git push -u origin master)."
read -p "Press Enter to push to GitHub, or Ctrl+C to cancel..."
git push -u origin master

echo "Done! Changes have been pushed to GitHub and will deploy to Cloudflare Pages automatically."

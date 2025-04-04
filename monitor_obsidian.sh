
#!/bin/bash

echo "$(date): monitor_obsidian.sh started" >> ~/monitor_obsidian.log

# Check if Obsidian is running
if pgrep -x "obsidian" > /dev/null; then
  # If Obsidian is running, add the cron job to sync every minute
  (crontab -l 2>/dev/null | grep -v "git_sync.sh"; echo "*/1 * * * * pgrep -x 'obsidian' > /dev/null && ~/git_sync.sh") | crontab -
else
  # If Obsidian is not running, remove the cron job that syncs the repo
  crontab -l | grep -v "git_sync.sh" | crontab -
fi

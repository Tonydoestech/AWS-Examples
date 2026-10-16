#!/usr/bin/env bash
# =============================================================================
#  Linux Commands Reference for IT Professionals
#  Author: Antonio Hernandez (github.com/Tonydoestech)
#
#  A categorized cheat sheet of the commands I use most for system
#  administration, troubleshooting, and cloud work (AWS EC2, Codespaces).
#
#  HOW TO USE THIS FILE
#    - This is a REFERENCE, not a script to run. The line below exits right
#      away so nothing executes if someone runs it by accident.
#    - Copy a command into your terminal and swap the PLACEHOLDERS.
#    - Add your own commands at the bottom using the TEMPLATE section.
#
#  Placeholders (swap in your own values):  FILE  DIR  USER  GROUP  PID  HOST  PORT  PKG
# =============================================================================

echo "This is a reference file. Open it in an editor and copy the commands you need."
exit 0


# =============================================================================
# 1. NAVIGATION
# =============================================================================
pwd                         # print the current (working) directory
ls                          # list files
ls -la                      # list ALL files (incl. hidden) with permissions, owner, size
ls -lh                      # sizes in human-readable form (K, M, G)
ls -lt                      # sort by last modified, newest first
cd DIR                      # change directory
cd ..                       # go up one level
cd ~                        # go to your home directory
cd -                        # go back to the previous directory
tree -L 2                   # show folder structure 2 levels deep (may need: apt install tree)


# =============================================================================
# 2. FILES & FOLDERS
# =============================================================================
touch FILE                  # create an empty file (or update its timestamp)
mkdir DIR                   # create a folder
mkdir -p a/b/c              # create nested folders in one step
cp FILE DEST                # copy a file
cp -r DIR DEST              # copy a folder and everything in it
mv OLD NEW                  # move or rename
rm FILE                     # delete a file  (no recycle bin!)
rm -r DIR                   # delete a folder and its contents
rm -i FILE                  # ask before deleting (safer)
rmdir DIR                   # delete an EMPTY folder
ln -s TARGET LINK           # create a shortcut (symbolic link)
file FILE                   # tell what kind of file it is
stat FILE                   # detailed info: size, permissions, timestamps


# =============================================================================
# 3. VIEWING & EDITING FILES
# =============================================================================
cat FILE                    # print a whole file
less FILE                   # scroll through a large file (q = quit, / = search)
head -n 20 FILE             # first 20 lines
tail -n 20 FILE             # last 20 lines
tail -f /var/log/syslog     # follow a log live as new lines are written (Ctrl+C to stop)
nano FILE                   # simple editor (Ctrl+S save, Ctrl+X exit)
vim FILE                    # advanced editor (i = insert, Esc then :wq = save & quit)
diff FILE1 FILE2            # show differences between two files


# =============================================================================
# 4. SEARCHING
# =============================================================================
grep "error" FILE             # find lines containing "error"
grep -i "error" FILE          # case-insensitive
grep -r "TODO" DIR            # search every file in a folder
grep -rn "TODO" DIR           # ...and show line numbers
grep -v "debug" FILE          # show lines that do NOT match
find DIR -name "*.log"        # find files by name
find DIR -type f -size +100M  # find files larger than 100 MB
find DIR -mtime -7            # files modified in the last 7 days
which COMMAND                 # where a command lives (e.g. which aws)
history | grep ssh            # search your own command history


# =============================================================================
# 5. PERMISSIONS & OWNERSHIP
# =============================================================================
#   Permission string:  -rwxr-xr--
#                        |  |  |
#                      owner group others     r=4  w=2  x=1
#
chmod +x FILE               # make a script executable
chmod u+x FILE              # executable for the owner (user) only
chmod 755 FILE              # rwx for owner, r-x for group and others (scripts, folders)
chmod 644 FILE              # rw- for owner, r-- for everyone else (normal files)
chmod 600 FILE              # owner only (SSH keys, .pem files)
chmod -R 755 DIR            # apply to a folder recursively
chown USER FILE             # change the owner
chown USER:GROUP FILE       # change owner and group
chown -R USER:GROUP DIR     # change owner and group for a whole folder

# --- Example: make a script executable and run it ---------------------------
#
#   1. Create a small script
#        nano hello.sh
#
#      Put these two lines in it, then save (Ctrl+S) and exit (Ctrl+X):
#        #!/usr/bin/env bash
#        echo "Hello from $(hostname)!"
#
#   2. Try to run it -- it fails because it isn't executable yet
#        ./hello.sh
#        bash: ./hello.sh: Permission denied
#
#   3. Check the permissions -- no "x" anywhere
#        ls -l hello.sh
#        -rw-r--r-- 1 antonio antonio 51 Oct 16 10:55 hello.sh
#
#   4. Add execute permission for the owner
#        chmod u+x hello.sh
#
#   5. Check again -- the owner now has "x"
#        ls -l hello.sh
#        -rwxr--r-- 1 antonio antonio 51 Oct 16 10:55 hello.sh
#
#   6. Run it
#        ./hello.sh
#        Hello from codespaces-abc123!
#
#   Tip: "bash hello.sh" runs a script even WITHOUT the x permission,
#        because you're handing the file to bash directly.
#   Tip: chmod +x  = executable for everyone (owner, group, others)
#        chmod u+x = executable for the owner only (safer default)


# =============================================================================
# 6. USERS, GROUPS & SUDO
# =============================================================================
whoami                       # which user am I?
id                           # my user ID and the groups I'm in
sudo COMMAND                 # run one command as root (admin)
sudo -i                      # open a root shell (use sparingly)
sudo useradd -m USER         # create a user with a home directory
sudo passwd USER             # set or reset a password
sudo usermod -aG GROUP USER  # add a user to a group (-a = append, don't replace)
sudo userdel -r USER         # delete a user and their home directory
groups USER                  # list a user's groups
who                          # who is logged in right now
last                         # recent logins


# =============================================================================
# 7. PROCESSES
# =============================================================================
ps aux                      # every running process
ps aux | grep NAME          # find a specific process
top                         # live CPU/memory view (q = quit)
htop                        # friendlier version of top (may need: apt install htop)
kill PID                    # ask a process to stop
kill -9 PID                 # force-stop a process that won't quit
pkill NAME                  # stop processes by name
COMMAND &                   # run a command in the background
jobs                        # list background jobs
nohup COMMAND &             # keep running after you log out


# =============================================================================
# 8. SYSTEM INFORMATION
# =============================================================================
uname -a                    # kernel and OS details
cat /etc/os-release         # which Linux distribution and version
hostname                    # this machine's name
uptime                      # how long it's been running + load average
free -h                     # memory (RAM) usage
lscpu                       # CPU details
nproc                       # number of CPU cores
date                        # current date and time
timedatectl                 # time zone and clock sync status

# --- Version checks ----------------------------------------------------------
# Which Linux am I on?
cat /etc/os-release         # distribution name and version (works almost everywhere)
lsb_release -a              # same info, Ubuntu/Debian style (may need: apt install lsb-release)
hostnamectl                 # OS, kernel, architecture, and whether it's a VM/container
uname -r                    # kernel version only
uname -m                    # architecture (x86_64 = Intel/AMD, aarch64 = ARM / AWS Graviton)

# Which version of a tool is installed?
bash --version              # Bash shell
git --version               # Git
python3 --version           # Python
aws --version               # AWS CLI
node --version              # Node.js
docker --version            # Docker
TOOL --version              # most tools support --version (a few use -v or -V)


# =============================================================================
# 9. DISK & STORAGE
# =============================================================================
df -h                       # free space on each drive
du -sh DIR                  # total size of a folder
du -sh * | sort -h          # size of everything here, smallest to largest
lsblk                       # list disks and partitions (useful for EBS volumes)
mount                       # what is mounted where
sudo mount /dev/DISK DIR    # mount a disk to a folder


# =============================================================================
# 10. NETWORKING
# =============================================================================
ip a                        # IP addresses of every network interface
ip route                    # routing table / default gateway
ping -c 4 HOST              # is the host reachable? (4 attempts)
curl -I https://HOST        # fetch only the HTTP headers (status code, server)
curl -O https://URL         # download a file
wget https://URL            # download a file (alternative)
nslookup HOST               # DNS lookup
dig HOST                    # detailed DNS lookup
traceroute HOST             # every hop between you and the host
ss -tulpn                   # which ports are open and what's listening on them
sudo lsof -i :PORT          # which process is using a port
curl ifconfig.me            # your public IP address


# =============================================================================
# 11. REMOTE ACCESS (SSH) & FILE TRANSFER
# =============================================================================
ssh USER@HOST                     # connect to a remote server
ssh -i key.pem ec2-user@HOST      # connect to an EC2 instance with a key pair
ssh-keygen -t ed25519 -C "EMAIL"  # create a new SSH key pair
ssh-copy-id USER@HOST             # install your public key on a server
scp FILE USER@HOST:/path/         # copy a file TO a server
scp USER@HOST:/path/FILE .        # copy a file FROM a server
rsync -avz DIR/ USER@HOST:/path/  # sync a folder (only sends changes)


# =============================================================================
# 12. PACKAGES
# =============================================================================
# Debian / Ubuntu (Codespaces, most cloud images)
sudo apt update             # refresh the list of available packages
sudo apt upgrade -y         # install all updates
sudo apt install PKG        # install a package
sudo apt remove PKG         # uninstall a package
apt list --installed        # what's installed

# Amazon Linux / RHEL / Fedora
sudo dnf update -y
sudo dnf install PKG        # (older versions use yum instead of dnf)


# =============================================================================
# 13. SERVICES & LOGS (systemd)
# =============================================================================
systemctl status SERVICE    # is it running? (e.g. nginx, sshd, httpd)
sudo systemctl start SERVICE
sudo systemctl stop SERVICE
sudo systemctl restart SERVICE
sudo systemctl enable SERVICE  # start automatically at boot
systemctl list-units --type=service --state=running
journalctl -u SERVICE            # logs for one service
journalctl -u SERVICE -f         # follow those logs live
journalctl --since "1 hour ago"  # everything from the last hour
ls /var/log/                     # classic log files live here


# =============================================================================
# 14. ARCHIVES & COMPRESSION
# =============================================================================
tar -czvf backup.tar.gz DIR  # create a compressed archive
tar -xzvf backup.tar.gz      # extract it
tar -tzvf backup.tar.gz      # list what's inside without extracting
zip -r archive.zip DIR       # create a zip
unzip archive.zip            # extract a zip


# =============================================================================
# 15. TEXT PROCESSING (great for logs and CSVs)
# =============================================================================
wc -l FILE                      # count lines
sort FILE                       # sort lines
sort FILE | uniq -c | sort -rn  # count duplicates, most common first
cut -d',' -f1,3 data.csv        # columns 1 and 3 of a CSV
awk '{print $1}' access.log     # first field of each line
awk -F',' '$3 > 100' data.csv   # rows where column 3 is over 100
sed 's/old/new/g' FILE          # replace text (prints result)
sed -i 's/old/new/g' FILE       # replace text in the file itself
# Example: top 10 IP addresses hitting a web server
awk '{print $1}' access.log | sort | uniq -c | sort -rn | head -10


# =============================================================================
# 16. PIPES, REDIRECTS & VARIABLES
# =============================================================================
COMMAND > out.txt           # write output to a file (overwrites)
COMMAND >> out.txt          # append to a file
COMMAND 2> errors.txt       # save only errors
COMMAND > all.txt 2>&1      # save output AND errors
COMMAND1 | COMMAND2         # send output of one command into another
COMMAND | tee out.txt       # show output AND save it
echo "$HOME"                # print a variable
export AWS_REGION=us-west-1 # set an environment variable for this session
env                         # list all environment variables
echo $?                     # exit code of the last command (0 = success)
CMD1 && CMD2                # run cmd2 only if cmd1 succeeded
CMD1 || CMD2                # run cmd2 only if cmd1 failed


# =============================================================================
# 17. SCHEDULED TASKS (cron)
# =============================================================================
crontab -l                  # list my scheduled jobs
crontab -e                  # edit them
# Format:  minute  hour  day-of-month  month  day-of-week  command
#   0 2 * * *     /home/user/backup.sh    -> every day at 2:00 AM
#   */15 * * * *  /home/user/check.sh     -> every 15 minutes
#   0 8 * * 1-5   /home/user/report.sh    -> weekdays at 8:00 AM


# =============================================================================
# 18. TERMINAL SHORTCUTS
# =============================================================================
#   Tab        auto-complete a command or file name
#   Ctrl+C     stop the running command
#   Ctrl+L     clear the screen (same as: clear)
#   Ctrl+R     search previous commands
#   Ctrl+A/E   jump to start / end of the line
#   !!         repeat the last command      (sudo !! = repeat it with sudo)
#   man CMD  full manual for a command    (CMD --help for a quick summary)


# =============================================================================
# 19. TROUBLESHOOTING CHECKLIST
# =============================================================================
#   Server slow?          uptime  ->  top  ->  free -h  ->  df -h
#   Disk full?            df -h   ->  du -sh /* | sort -h  ->  find / -size +500M
#   Service down?         systemctl status SVC  ->  journalctl -u SVC -n 50
#   Can't connect?        ping  ->  nslookup  ->  ss -tulpn  ->  check firewall / security group
#   Permission denied?    ls -la FILE  ->  whoami / id  ->  chmod / chown / sudo


# =============================================================================
# TEMPLATE: add your own commands below
# =============================================================================
#   Copy this block for each new section.
#
# -----------------------------------------------------------------------------
# SECTION_NAME
# -----------------------------------------------------------------------------
# COMMAND                 # what it does
# COMMAND OPTIONS       # what the options change
# Example:
# REAL_EXAMPLE_YOU_RAN
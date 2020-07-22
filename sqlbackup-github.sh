#!/bin/bash
# Script Version
ver="1.0.1"

######################################################
###             Backup Module Settings             ###
######################################################

# Backup directory path
directory="/etc/mysql/backups"
# Date format for file names
dateformat="-$(date +%d-%m-%Y-%H:%M:%S)"
# Backup files extension
ext="sql"
# Credentails for auth in MySQL
user="root"
password="password"
# Specific Databases Vars
# Add the database name as a variable and use it (optional, this is for convenience).
DATABASE1="database1"

######################################################
###              Clean Module Settings             ###
######################################################

# Enable clean module? 0 - no, 1 - yes
enable_clean="1"
# Directory that will be cleaned
clean_directory="/etc/mysql/backups"
# Age of files to clean
days="5"

#######################################################
###             Custom Message Config               ###
#######################################################

# Text format codes
# You can add new one if you want
C='\033[0;36m'   #CYAN
G='\033[0;37m'   #GRAY
B='\033[1m'      #BOLD
GN='\033[0;32m'  #GREEN
Y='\033[0;33m'   #YELLOW

# Status Placeholders
OK="[  ${GN}OK  ${G}]"
INFO="[ ${C}INFO ${G}]"

# Startup Message
echo "${C}${B}   ________    __     ___           __               ______       ____"
echo "${C}${B}  / __/ __ \  / /    / _ )___ _____/ /____ _____    / __/ /  ___ / / /"
echo "${C}${B} _\ \/ /_/ / / /__  / _  / _  / __/   _/ // / _ \  _\ \/ _ \/ -_) / / "
echo "${C}${B}/___/\___\_\/____/ /____/\_,_/\__/_/\_\ _,_/ .__/ /___/_//_/\__/_/_/  "
echo "${G}${B}Script by Feniksovich                     ${C}/_/                ${G}v${ver}"

echo "\n${INFO} Running Backup Script..."
echo "${OK} SQL backup process initialized successfully."
echo "${INFO} Processing databases backup..."

#######################################################
###              Backup Script Body                 ###
#######################################################

# Use this command if your user have password
/usr/bin/mysqldump -u ${user} -p ${password} ${DATABASE1} > $directory/${DATABASE1}/${DATABASE1}$dateformat.$ext
echo "${OK} ${DATABASE1} saved (1/4)."

# Use this command if your user have NOT password (root as usually)
/usr/bin/mysqldump -u ${user} ${DATABASE1} > $directory/${DATABASE1}/${DATABASE1}$dateformat.$ext
echo "${OK} ${DATABASE1} saved (1/4)."

#######################################################
###               Clean Script Body                 ###
#######################################################

if [ $enable_clean -eq "1" ];
    then
    echo "\n${INFO} Running Clean Module..."
    echo "${INFO} Processing clean action..."
    # DANGER: CHECKUP YOUR CLEAN_DIRECTORY VAR BEFORE STARTING THAT SCRIPT #
    find ${clean_directory}/ -type f -mtime +${days} -exec rm -rf {} \;
    ########################################################################
    echo "${OK} All backups files older than ${days} day(s) successfully cleared."
  else
    echo "\n${INFO} ${Y}Clean Module is disabled in your script. No cleaning action will be taken."
  fi

echo "${OK} SQLBackup Script successfully processed."
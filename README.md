<img src="https://i.imgur.com/Dd1YdnT.png"></img>

## About This Little Script
SQLBackup is a powerful and easy customizeable **shell script** (.sh) that helps you to make SQL databases backups and clean old backups automatically.
The backup functionality is implemented using the commands of the **mysqldump** program.

## Questions & Answers
**Q:** Do I need to install **mysqldump** for this script?
<br>**A:** Yes. Otherwise, the script will not perform backups, because it use commands of them.

**Q:** Will I be able to automate the execution of the script?
<br>**A:** Of course, like any other shell script, it can be called automatically by the system or programs.
<br> *You can use **cron** as an ideal solution to this question.*

**Q:** Can I track the execution of a script in specific log file?
<br>**A:** Currently, no. But I have already planned to implement this ;)

## Installation
1. Install **mysqldump**.
2. Download **sqlbackup.sh** on your machine and put in the desired directory ```/etc/mysql/ for example```
3. Open **sqlbackup.sh** file and move to 64 line. There are the mysqldump commands to perform backups.
<br> Follow my instructions in comments and choose the option you need.
```sh
#######################################################
###              Backup Script Body                 ###
#######################################################

# Use this command if your user have password
/usr/bin/mysqldump -u ${user} -p ${password} ${DATABASE1} > $directory/${DATABASE1}$dateformat.$ext
echo "${OK} ${DATABASE1} saved."

# Use this command if your user have NOT password (root as usually)
/usr/bin/mysqldump -u ${user} ${DATABASE1} > $directory/${DATABASE1}$dateformat.$ext
echo "${OK} ${DATABASE1} saved."
```

4. Move to the top of the file and set the required values in **Backup Module Settings**.
<br>If your user does not have a password and you chose the second option in step 3, the `password` field can be left unchanged.
5. If you want to perform cleanup after script execution, set `enable_clean` to `1` and set the required parameters below.
<br>**DANGER: CHECKUP YOUR `CLEAN_DIRECTORY` VAR BEFORE STARTING CLEAN MODULE**
6. Move to the directory where the script is located and run it:
```sh
cd /path/to/script && sh sqlbackup.sh
```
7. Check up backup files directory to make sure everything is set up correctly.

## Setup cron task
If you need to run this script automatically, you can add the following task:
```sh
* * * * * cd /path/to/script && sh sqlbackup.sh
```
You can edit this rule to change the start interval.
<br>The rule below runs the script every 6 hours at 00 minutes.
```sh
0 */6 * * * cd /path/to/script && sh sqlbackup.sh
```

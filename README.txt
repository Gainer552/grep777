                grep777 - World-Writable Permission Scanner for Linux Systems 

DESCRIPTION

grep777 is a lightweight, high-visibility Bash script that scans your 
Linux system for world-writable files or directories (permissions 777 or similar).  

This tool is built for sysadmins, incident responders, and red-teamers 
who want fast visibility into potentially dangerous permission misconfigs.  

The scan results are displayed in a color-coded terminal output and 
saved to a timestamped .txt report for auditing or triage.

FEATURES

✔ Scans core system directories: /bin, /sbin, /usr, /etc, /var, /lib, /home.  
✔ Flags all files and directories with world-writable permissions (-0002).
✔ Displays full contextual info: path, owner, type, size, modified date.
✔ Color-coded terminal output for quick triage.
✔ Writes full results to timestamped .txt logs. 
✔ No dependencies — pure Bash + coreutils
✔ Fast and safe — Read-only analysis.

USAGE

1. Make the script executable: chmod +x grep777.sh

2. Run the scanner: sudo ./grep777.sh

   (sudo recommended for full filesystem visibility)

3. Output will be saved to: grep777-log-YYYY-MM-DDTHH-MM-SSZ.txt

4. Example: grep777-log-2025-11-06T16-10-33Z.txt

SAMPLE OUTPUT (TERMINAL)

[ALERT] /etc/unlocked.conf  
  Type:     File  
  Owner:    root:root  
  Perms:    -rwxrwxrwx  
  Size:     921 bytes  
  Modified: 2025-11-06 15:04:52.000000000 +0000  

[!] Scan complete. 1 potentially unsafe entries detected.  
[INFO] Log saved to: grep777-log-2025-11-06T16-10-33Z.txt  

LIMITATIONS

- grep777 performs a point-in-time scan — it does not monitor in real-time.
- Only paths defined in SCAN_DIRS[] are checked.
- No automatic remediation is performed (scan-only).  

RECOMMENDED USE CASES

- Security audits.
- Forensic triage during incident response.
- Hardening system images.
- CI/CD pipeline integration for security baselines. 
- Daily cron-based snapshot of permission drift.

DISCLAIMER

This tool is provided for lawful and authorized security auditing, 
administration, and forensic purposes only. 

Unauthorized scanning, monitoring, or deployment of this script 
on systems you do not own or have explicit permission to assess 
may violate laws, policies, or agreements.

By using grep777, you agree that the author assumes no responsibility 
for damage, misuse, or legal consequences resulting from its use. Use at your own risk.
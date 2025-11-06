#!/usr/bin/env bash
# grep777 / perm777scan.sh
# Scans for files or directories with world-writable (777/other -0002) permissions.
# Logs results to a timestamped .txt file and displays in color-coded output.

# --- Colors for terminal output ---
RED="\033[1;31m"
YELLOW="\033[1;33m"
GREEN="\033[1;32m"
CYAN="\033[1;36m"
RESET="\033[0m"

# --- Output log file ---
TIMESTAMP="$(date -u +'%Y-%m-%dT%H-%M-%SZ')"
LOGFILE="grep777-log-${TIMESTAMP}.txt"

# --- Target directories ---
SCAN_DIRS=("/bin" "/sbin" "/usr" "/etc" "/var" "/lib" "/home")

# --- Header ---
{
echo "========================================"
echo "       grep777 - Permission Scanner     "
echo "========================================"
echo "# Scan Time: ${TIMESTAMP}"
echo "# Target Dirs: ${SCAN_DIRS[*]}"
echo
} | tee "$LOGFILE"

FOUND=0

# --- Scan ---
for dir in "${SCAN_DIRS[@]}"; do
  if [ -d "$dir" ]; then
    while IFS= read -r path; do
      [ -z "$path" ] && continue
      ((FOUND++))
      PERMS=$(stat -c "%A" "$path")
      OWNER=$(stat -c "%U:%G" "$path")
      SIZE=$(stat -c "%s" "$path")
      MTIME=$(stat -c "%y" "$path")
      TYPE=$( [ -d "$path" ] && echo "Directory" || echo "File" )

      # Terminal output
      echo -e "${RED}[ALERT]${RESET} $path"
      echo -e "  ${YELLOW}Type:${RESET}   $TYPE"
      echo -e "  ${YELLOW}Owner:${RESET}  $OWNER"
      echo -e "  ${YELLOW}Perms:${RESET}  ${RED}$PERMS${RESET}"
      echo -e "  ${YELLOW}Size:${RESET}   $SIZE bytes"
      echo -e "  ${YELLOW}Modified:${RESET} $MTIME"
      echo

      # Log file output (no color codes)
      {
        echo "[ALERT] $path"
        echo "  Type:     $TYPE"
        echo "  Owner:    $OWNER"
        echo "  Perms:    $PERMS"
        echo "  Size:     $SIZE bytes"
        echo "  Modified: $MTIME"
        echo
      } >> "$LOGFILE"

    done < <(find "$dir" -perm -0002 2>/dev/null)
  fi
done

# --- Summary ---
if [ "$FOUND" -eq 0 ]; then
  echo -e "${GREEN}[OK]${RESET} No world-writable files or directories (777) found."
  echo "[OK] No world-writable files or directories (777) found." >> "$LOGFILE"
else
  echo -e "${RED}[!]${RESET} Scan complete. ${FOUND} potentially unsafe entries detected."
  echo "[!] Scan complete. ${FOUND} potentially unsafe entries detected." >> "$LOGFILE"
fi

echo -e "${CYAN}[INFO] Log saved to:${RESET} $LOGFILE"

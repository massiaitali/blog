#!/bin/sh
# Zed external formatter wrapper for vp fmt
# Zed pipes buffer content via stdin; vp fmt only works on files,
# so we write to a temp file with the correct extension, format it, then output it.
EXT="${1##*.}"
TMPFILE=$(mktemp /tmp/zed-fmt.XXXXXX."$EXT")
trap 'rm -f "$TMPFILE"' EXIT
cat > "$TMPFILE"
vp fmt --write "$TMPFILE" 2>/dev/null
vp lint --fix "$TMPFILE" 2>/dev/null
cat "$TMPFILE"

#!/bin/awk -f

BEGIN { FS = "=" }

$1 == "[Paths]" {
    inPaths = 1
    next
}

inPaths {
    # Skip comments & empty lines
    if ( /^\s*#/ || /^\s*$/ ) { next } else if ( /^\[.*\]/ ) { exit }

    # Get paths
    key = $1;
    val = $2;
    gsub(/^[[:space:]]+|[[:space:]]+$/, "", key)
    gsub(/^[[:space:]]+|[[:space:]]+$/, "", val)
    print key "=" val;

}

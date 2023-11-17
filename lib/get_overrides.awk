#!/bin/awk -f

BEGIN { FS = "=" }

$1 == "[Overrides]" {
    inOverrides = 1
    next
}

inOverrides {
    # Skip comments & empty lines
    # TODO: exit at end of section(?)
    if ( /^\s*#/ || /^\s*$/ ) { next } else if ( /^\[.*\]/ ) { exit }

    # Get override
    key = $1;
    val = $2;
    gsub(/^[[:space:]]+|[[:space:]]+$/, "", key)
    gsub(/^[[:space:]]+|[[:space:]]+$/, "", val)
    print key "=" val;

}

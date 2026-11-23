# Follow the shared IX recipe includes without evaluating any Makefile code.
$1 == "include" && $2 ~ /^\/lib\/ix\/(borrow|port)\.mk$/ && !queued[$2]++ {
    ARGV[ARGC++] = $2
}
/^[a-zA-Z][a-zA-Z0-9_-]*:/ {
    name = $0
    sub(/:.*/, "", name)
    if (names) {
        if (index(name, prefix) == 1 && !seen[name]++) print name
    } else if ($0 ~ /## / && !seen[name]++) {
        sub(/^.*## /, "")
        printf "  make %-15s %s\n", name, $0
    }
}

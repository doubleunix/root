# Tab completion follows literal port includes without evaluating Make code.
names && $1 == "include" && $2 ~ /^\/lib\/ix\/(borrow|port)\.mk$/ && !queued[$2]++ {
    ARGV[ARGC++] = $2
}
/^[a-zA-Z][a-zA-Z0-9_.-]*:.*## / {
    name = $0
    sub(/:.*/, "", name)
    if (seen[name]++) next
    if (names) {
        if (index(name, prefix) == 1) print name
    } else {
        sub(/^.*## /, "")
        printf "  make %-15s %s\n", name, $0
    }
}

# modules.dep already lists each module's dependencies in load order.
function include_module(path, fields, count, i) {
    if (seen[path]++ || !(path in deps)) return
    print deps[path]
    count = split(deps[path], fields)
    for (i = 2; i <= count; i++) include_module(fields[i])
}
BEGIN {
    count = split(modules, names)
    for (i = 1; i <= count; i++) want[names[i]] = 1
}
{
    path = $1
    sub(/:$/, "", path)
    deps[path] = $0
    name = path
    sub(/^.*\//, "", name)
    sub(/\.ko(\..*)?$/, "", name)
    if (want[name]) selected[++n] = path
}
END {
    for (i = 1; i <= n; i++) include_module(selected[i])
}

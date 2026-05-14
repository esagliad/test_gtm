#!/bin/bash
TARGET_IP=$1

if [[ -z "$TARGET_IP" ]]; then
    exit 1
fi

awk -v ip="$TARGET_IP" '
/^\$ORIGIN/ {
    o = $2
}
/^[^\t ]/ && $1 !~ /^\$/ {
    ch = $1
}
$0 ~ ip && /[[:space:]]+A[[:space:]]+/ {
    name = ($1 == "A") ? ch : $1;
    sub(/\.$/, "", name);
    f = (o == ".") ? name : name "." o;
    print f
}' /var/named/config/namedb/*

#Di seguito il comando intero:
#awk -v ip="$TARGET_IP" ' /^\$ORIGIN/ { o = $2 } /^[^\t ]/ && $1 !~ /^\$/ { ch = $1 } $0 ~ ip && /[[:space:]]+A[[:space:]]+/ { name = ($1 == "A") ? ch : $1; sub(/\.$/, "", name); f = (o == ".") ? name : name "." o; print f }' /var/named/config/namedb/*

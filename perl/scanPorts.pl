#!/usr/bin/perl
# first parameter: IP range; second parameter: PORT(S)
$command = sprintf("nmap %s -p %s --open | awk '/is up/ {print up}; {gsub (/\(|\)/,\"\"); up = $NF}'", $ARGV[0], $ARGV[1]);
$find = `$command`;

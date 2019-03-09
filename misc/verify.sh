#!/bin/bash

missing=""

verify(){
    which "$1" &> /dev/null || { missing="$missing $1"; return 1; }
    return 0;
}

REQUIRED_COMMANDS="
curl
jq
pandoc
dillo
fmt
sqlite3
w3m
lwp-request
numfmt
units
pdftotext
csvtool
xmllint
"

for cmd in $REQUIRED_COMMANDS
do
    verify "$cmd"
done


if [[ ! -z "$missing" ]]
then
    echo "Missing the following programs:"
    echo "$missing"
    echo "Please install and run the script again."
    exit 1
fi

die() {
    echo "$1" >&2
    exit 1
}

# example checking single command:
verify asdfasdf || die "asdfasdf missing. Please install."

echo "running the actual script here..."

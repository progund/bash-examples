#!/bin/bash

FILE=$1

if [ "$FILE" = "" ] || [ ! -f "$FILE" ]
then
    echo "File \"$FILE\" missing or not readable"
    exit
fi

content()
{
    cat "$FILE"
}

# do your best
find_file_type()
{
    FILE_NAME="$(basename "$FILE" | tr A-Z a-z])"
    FILE_SUFF="$(echo "$FILE_NAME" | sed 's,.*\.,,g')"
#    echo $FILE_NAME
#    echo $FILE_SUFF

    case "$FILE_SUFF" in
        "json")
            TYPE="application/json";
            ;;
        "png")
            TYPE="image/png";
            ;;
        "html")
            TYPE="text/html; charset=utf-8"
            ;;
        *)
            echo "Unknown file type"
            exit 1
            ;;
    esac
}

header()
{
    echo "HTTP/1.0 200 OK"
    echo "Connection: close"
    echo "Date: $(date)"
    echo "Server: netcat special deal"
    echo "Content-Length: $LENGTH"
    echo "Content-Type: '$TYPE'"
    echo "Cache-Control: max-age=60"
    echo ""
    echo ""
    echo ""
}

find_file_type

LENGTH=$(wc -c "$FILE")

header
content

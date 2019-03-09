#!/bin/bash

SITES="www.nytimes.com www.mirror.co.uk www.daily-sun.com www.washingtonpost.com www.chicagotribune.com www.theguardian.com/us timesofindia.indiatimes.com www.dailymail.co.uk"
REGEXP=!!

EXPIRATION_MINUTES=1

TMP_DIR="/tmp/$USER/dwgrep-tmp"
mkdir -p "$TMP_DIR"

CSV=false

exit_on_error()
{
    RET="$1"
    MSG="$2"

    if [ "$RET" -ne 0 ]
    then
        if [ "$MSG" != "" ]
        then
            echo "$MSG"
        fi
        exit $RET
    fi
}

err() {
    if [ "$QUIET" = "true" ]
    then
        :
    else
        echo -e "$*" 1>&2
    fi
}

errn() {
    if [ "$QUIET" = "true" ]
    then
        :
    else
        echo -n -e "$*" 1>&2
    fi
}

REGEXP=""
#
# parse user args
#
while [ "$1" != "" ]
do
    case "$1" in
        "--site")
            SITES="$SITES $2"
            shift
            ;;
        "--expiration")
            EXPIRATION_MINUTES=$2
            shift
            ;;
        "--no-cache")
            EXPIRATION_MINUTES=0
            ;;
        "--csv")
            CSV=true
            ;;
        "--sites")
            echo "$SITES"
            exit 0
            ;;
        "--quiet")
            QUIET=true
            ;;
        *)
            REGEXP="$REGEXP $1"
            ;;
    esac
    shift
done

if [ "$REGEXP" = "" ]
then
    echo "Missing search term"
    exit 1
fi


#
# Add sites
#
#for site in $*
#do
#    SITES="$SITES $site"
#done

#
# Check tools
#
which w3m >/dev/null  2>&1
exit_on_error $? "w3m not found"

for site in $SITES
do
    STR="Getting $site"
    errn "$STR"
    TMP_FILE="$TMP_DIR/$(echo "$site" | sed 's,[/.],_,g').txt"
    if [ ! -f "$TMP_FILE" ] || [ "$(find "$TMP_FILE" -mmin +$EXPIRATION_MINUTES)" != "" ] 
    then
        w3m -dump "$site" 2>/dev/null > "$TMP_FILE"
        exit_on_error $? "Failed downloading $site"
    fi
    errn "\r"
    for i in $(seq 1 ${#STR}) ; do printf " "; done
    errn "\r"
done
err ""


for reg in $REGEXP
do
    if [ "$CSV" = "true" ]
    then
        echo -e -n "\r"
    else
        echo "$reg"
    fi
    TOT=0
    for site in $SITES
    do
        TMP_FILE="$TMP_DIR/$(echo "$site" | sed 's,[/.],_,g').txt"
        CNT=$(grep -o $reg "$TMP_FILE" | wc -l)
        if [ "$CSV" = "true" ]
        then
            echo "$reg,$site,$CNT"
        else
            printf " * %30s: " "$site"
            echo "$CNT"
        fi
        TOT=$(( TOT + CNT ))
    done
    if [ "$CSV" = "true" ]
    then
        :
    else
        echo " * total: $TOT"
    fi
done

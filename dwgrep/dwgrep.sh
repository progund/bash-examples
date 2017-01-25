#!/bin/bash

SITES="www.nytimes.com www.mirror.co.uk www.daily-sun.com www.washingtonpost.com www.chicagotribune.com www.theguardian.com/us timesofindia.indiatimes.com www.dailymail.co.uk"
REGEXP=!!

EXPIRATION_MINUTES=1

TMP_DIR=/tmp/$USER/dwgrep-tmp
mkdir -p $TMP_DIR

exit_on_error()
{
    RET=$1
    CMD="$2"

    if [ $RET -ne 0 ]
    then
        if [ "$MSG" != "" ]
        then
            echo "$MSG"
        fi
        exit $RET
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
for site in $*
do
    SITES="$SITES $site"
done

#
# Check tools
#
which w3m >/dev/null  2>&1
exit_on_error $? "w3m not found"

for site in $SITES
do
    STR="Getting $site"
    echo -n "$STR"
    TMP_FILE=$TMP_DIR/$(echo $site | sed 's,[/.],_,g').txt
    if [ ! -f $TMP_FILE ] || [ "$(find $TMP_FILE -mmin +$EXPIRATION_MINUTES)" != "" ] 
    then
        w3m -dump $site 2>/dev/null > $TMP_FILE
        exit_on_error $? "Failed downloading $site"
    fi
    printf "\r"
    for i in $(seq 1 ${#STR}) ; do printf " "; done
    printf "\r"
done

for reg in $REGEXP
do
    echo "$reg"
    TOT=0
    for site in $SITES
    do
        printf " * %30s: " $site
        TMP_FILE=$TMP_DIR/$(echo $site | sed 's,[/.],_,g').txt
        CNT=$(grep -c $reg $TMP_FILE)
        echo "$CNT"
        TOT=$(( $TOT + $CNT ))
    done
    echo " * total: $TOT"
done

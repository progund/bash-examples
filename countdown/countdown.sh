#!/bin/bash

if [ "$1" = "" ]
then
    echo "Missing arg"
    exit
fi

MSG="We'll begin in"
SEC_MSG="seconds"
CMD=""
CENTER=false
while [ "$1" != "" ]
do
    case "$1" in
        "--command")
            CMD=$2
            shift
            ;;
        "--message")
            MSG=$2
            shift
            ;;
        "--seconds-message")
            SEC_MSG=$2
            shift
            ;;
        "--center")
            CENTER=true
            ;;
        "--time")
            #"2004-02-29 16:21:42"
            #"friday"
            #          echo ljsdljsdljf
            STOP_TIME=$(date "+%s" --date "$2")
            CURR_TIME=$(date "+%s")
            SECS=$(( STOP_TIME - CURR_TIME))
 #           echo " $2 ==> " $SECS
            shift
            ;;
        *)
            SECS=$1
            break;
    esac
    shift
done
            


#echo "$SECS | $MSG | $CMD"
if [ "$SECS" -le 0 ]
then
    echo "Faulty time set"
    exit 1
fi
#exit
CTR=$SECS

#echo "$CTR - $SECS"
tput init


clear
COLS=0
ROWS=0
while [ 0 -le "$CTR" ]
do
#    date
    SEC=$(printf '%.4d' "$CTR")
    STR="$MSG $SEC $SEC_MSG"
    SIZE=${#STR}
#    echo loop $(date)
    if [  "$CENTER" = "true" ]
    then
        LAST_COLS=$COLS
        LAST_ROWS=$ROWS
        export COLS=$(( ($(tput cols) - "$SIZE")  / 2  ))
        export ROWS=$(( $(tput lines) / 2 ))
        if [ $LAST_COLS -ne $COLS ] || [ $LAST_ROWS -ne $ROWS ]
        then
            clear
        fi
           

        
        tput cup $ROWS $COLS
        echo "$STR"
        sleep 1
    else
        echo -n "$STR"
        sleep 1
        for i in $(seq 1 "$SIZE")
        do
            echo -en "\b"
        done
    fi
    CTR=$(( CTR - 1 ))

done

#echo ""
#clear
echo "  NOW!                         "
if [ "$CMD" != "" ]
then
    echo "Launching \"$CMD\""
    $CMD &
fi

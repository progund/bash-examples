#!/bin/bash


BASE_URL="https://www.gutenberg.org"
TOP_URL="$BASE_URL/browse/scores/top"

BASE_DIR=/tmp/dload100
FILE=$BASE_DIR/tmp-top.html

if [ ! -d $BASE_DIR ]
then
    mkdir -p $BASE_DIR
fi

if [ ! -f $FILE  ]
then
    curl "$TOP_URL" -o $FILE
fi

EBOOK_IDS=$(cat $FILE | grep -A 110 "id=\""books-last1\""" | sed 's,\",\n,g' | grep ebooks)

dload_txt() {
    FILE=$1
#    grep "Plain Text" $FILE 
    TXT_URL=$(grep "Plain Text" $FILE | sed 's, ,\n,g' | grep href | sed -e 's,href=,,' -e 's,\",,g')
    FILE_NAME=$(echo $TXT_URL | sed 's,/,\n,g' | tail -1)
    pushd $BASE_DIR
    if [ ! -f $FILE_NAME ]
    then
	curl -LJO $BASE_URL/$TXT_URL
    fi
    popd
}

for id in $EBOOK_IDS
do
    echo "id: $id | $BASE_URL/$id"
    ID_NR=$(echo $id | sed 's,/ebooks,,g')
    ID_FILE=$BASE_DIR/$ID_NR.html
    if [ ! -f $ID_FILE ]
    then
	curl -o $ID_FILE $BASE_URL/$id
    fi
    dload_txt $ID_FILE
done

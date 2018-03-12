#!/bin/bash

if [ "$1" = "" ]
then
    echo "Missing name"
    exit 1
fi

DB=students.db
SQLITE=sqlite3

sql()
{
    echo "$*" | $SQLITE $DB
}

sql "INSERT INTO students (name) VALUES('$1')";


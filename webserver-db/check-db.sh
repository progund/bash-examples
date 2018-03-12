#!/bin/bash

DB=students.db
SQLITE=sqlite3

sql()
{
    echo "$*" | $SQLITE $DB
}


sql "SELECT * FROM students"

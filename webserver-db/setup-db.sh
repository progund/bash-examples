#!/bin/bash

DB=students.db
SQLITE=sqlite3

rm -f $DB
$SQLITE $DB < students-backup.sql


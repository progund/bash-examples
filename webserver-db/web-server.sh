#!/bin/bash



DB=students.db
SQLITE=sqlite3

sql()
{
    echo "$*" | $SQLITE $DB
}



content()
{
    echo "<!DOCTYPE html>"
    echo "<html>"
    echo ""
    echo "<head>"
    echo "<title>Students</title>"
    echo "</head>"
    sql "SELECT name FROM students" |
            while read LINE
            do
                echo "$LINE <br>"
            done
    echo ""
    echo "<body>"
    echo "</body>"
    echo ""
    echo "</html>"
}

header()
{
    echo "HTTP/1.1 200 OK"
    echo "Connection: close"
    echo "Date: $(date)"
    echo "Server: netcat special deal"
    echo "Content-Length: $LENGTH"
    echo "Content-Type: text/html; charset=utf-8"
    echo "Cache-Control: max-age=60"
    echo ""
    echo ""
    echo ""
}


serve()
{
    LENGTH=$(content | wc -c)
    header
    content
}

while (true);
do
    serve | nc -l -p 8080;
    sleep 1
done


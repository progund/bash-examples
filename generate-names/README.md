# gen_person.sh - script to generate files with name (and email)

gen_persons.sh is a bash script that can generate names.

* given name
* family name
* email (optional)

This might be useful if you want to a list of random names. As
teachers we have found a need for this and perhaps you have too.

The names are Swedish names.

License: GPLv3

# Manual

~~~
NAME
    gen-person.sh [OPTIONS] [NR] 

SYNOPSIS
    Generate one or many (Swedish) names male or female.
    If you specify  number, that many names are
    generated. Names are generated with or without
    an email address.

    Supported output formats: see below

    The names generated are based on the most common
    names in Sweden.

    Text formats are printed to stdout. For other formats
    a file is created

OPTIONS

  --help, -h 
     print help text, that is this text :) 

  --male, -m 
     generate male name(s).

  --email, -e 
     generate email addesses as well

  --female, -f 
     generate male name(s)

  --mixed 
     generate mixed male and female name(s). Default.

  --demo 
     shows examples of printouts

  FORMAT OPTIONS

  --sql 
     output in SQL

  --db 
     creates a database (SQLite) with persons.

  --json 
     output in JSON format

  --xml 
     output in XML format

  --java 
     output in Java format (a method returning a List<Person>).

  --txt 
     output in txt format (default).

  --xls 
     output in xls format (using LibreOffice).

  --ods 
     output in ods (Open Document) format (using LibreOffice).

  --html 
     output in HTML format (using LibreOffice).

  --pdf 
     output in pdf format (using LibreOffice).

EXAMPLES

  gen-person.sh
     generates one male and one female name

  gen-person.sh 2
     generates two male and two female name

  gen-person.sh --male
     generates one male name

  gen-person.sh --female
     generates one female name

  gen-person.sh --female 10
     generates 10 female names

  gen-person.sh --male 100
     generates 100 female names

  gen-person.sh --mixed 10
     generates 5 female names and 5 male names

  gen-person.sh --sql 1000
     creates a database (SQLite) with 2000 persons (mixed male/female)

  gen-person.sh --sql --email 1000
     creates a database (SQLite) with 2000 persons (incl email)

  gen-person.sh --json --email 1000
     outputs 2000 persons (incl email) in JSON format

~~~

The above is copied from ```gen_persons.sh --help```.


#!/bin/bash

declare -a GIRL_NAMES=(
        "Maria" 
        "Anna" 
        "Margareta" 
        "Elisabeth" 
        "Eva" 
        "Birgitta" 
        "Kristina" 
        "Karin" 
        "Elisabet" 
        "Marie" 
        "Ingrid" 
        "Christina" 
        "Linnéa" 
        "Marianne" 
        "Sofia" 
        "Kerstin" 
        "Lena" 
        "Helena" 
        "Inger" 
        "Johanna" 
        "Emma" 
        "Linnea" 
        "Cecilia" 
        "Sara" 
        "Ulla" 
        "Anita" 
        "Elin" 
        "Viola" 
        "Gunilla" 
        "Louise" 
        "Linda" 
        "Susanne" 
        "Ida" 
        "Katarina" 
        "Malin" 
        "Hanna" 
        "Jenny" 
        "Irene" 
        "Carina" 
        "Barbro" 
        "Elsa" 
        "Monica" 
        "Ulrika" 
        "Viktoria" 
        "Astrid" 
        "Siv" 
        "Ingegerd" 
        "Britt" 
        "Åsa" 
        "Matilda" 
        "Yvonne" 
        "Therese" 
        "Camilla" 
        "Julia" 
        "Amanda" 
        "Agneta" 
        "Alice" 
        "Ann" 
        "Caroline" 
        "Lisa" 
        "Lovisa" 
        "Berit" 
        "Inga" 
        "Anette" 
        "Ingeborg" 
        "Charlotte" 
        "Sandra" 
        "Frida" 
        "Sofie" 
        "Margaretha" 
        "Charlotta" 
        "Birgit" 
        "Emelie"
        )
declare -a BOY_NAMES=(
        "Erik" 
        "Lars" 
        "Karl" 
        "Anders" 
        "Johan" 
        "Per" 
        "Nils" 
        "Jan" 
        "Carl" 
        "Mikael" 
        "Lennart" 
        "Hans" 
        "Olof" 
        "Gunnar" 
        "Peter" 
        "Sven" 
        "Bengt" 
        "Fredrik" 
        "Bo" 
        "Åke" 
        "Göran" 
        "Daniel" 
        "Gustav" 
        "Magnus" 
        "Alexander" 
        "Martin" 
        "Stefan" 
        "Andreas" 
        "Leif" 
        "John" 
        "Bertil" 
        "Mats" 
        "Ulf" 
        "Arne" 
        "Björn" 
        "Ingemar" 
        "Henrik" 
        "Thomas" 
        "Christer" 
        "Jonas" 
        "Stig" 
        "Axel" 
        "Robert" 
        "Kjell" 
        "Rolf" 
        "Håkan" 
        "David" 
        "Emil" 
        "Mattias" 
        "Roland" 
        "Oskar" 
        "Tommy" 
        "Ingvar" 
        "Gustaf" 
        "Patrik" 
        "Michael" 
        "Roger" 
        "Joakim" 
        "William" 
        "Christian" 
        "Simon" 
        "Marcus" 
        "Olov" 
        "Sebastian" 
        "Anton" 
        "Tomas" 
        "Ove" 
        "Eric" 
        "Rune" 
        "Oscar" 
        "Kent" 
        "Johannes" 
        "Tobias" 
        "Viktor" 
        "Niklas"
)
declare -a FAMILY_NAMES=(
        "Johansson" 
        "Andersson" 
        "Karlsson" 
        "Nilsson" 
        "Eriksson" 
        "Larsson" 
        "Olsson" 
        "Persson" 
        "Svensson" 
        "Gustafsson" 
        "Pettersson" 
        "Jonsson" 
        "Jansson" 
        "Hansson" 
        "Bengtsson" 
        "Jönsson" 
        "Carlsson" 
        "Petersson" 
        "Lindberg" 
        "Magnusson" 
        "Lindström" 
        "Gustavsson" 
        "Olofsson" 
        "Lindgren" 
        "Axelsson" 
        "Lundberg" 
        "Bergström" 
        "Jakobsson" 
        "Lundgren" 
        "Berg" 
        "Berglund" 
        "Fredriksson" 
        "Mattsson" 
        "Sandberg" 
        "Henriksson" 
        "Sjöberg" 
        "Forsberg" 
        "Lindqvist" 
        "Lind" 
        "Engström" 
        "Håkansson" 
        "Danielsson" 
        "Eklund" 
        "Lundin" 
        "Gunnarsson" 
        "Holm" 
        "Samuelsson" 
        "Bergman" 
        "Fransson" 
        "Johnsson" 
        "Nyström" 
        "Lundqvist" 
        "Holmberg" 
        "Arvidsson" 
        "Björk" 
        "Isaksson" 
        "Nyberg" 
        "Söderberg" 
        "Wallin" 
        "Mårtensson" 
        "Pettsson"
)



GIRL_SIZE=${#GIRL_NAMES[@]}
BOY_SIZE=${#BOY_NAMES[@]}
FAM_SIZE=${#FAMILY_NAMES[@]}
EMAIL=false

#echo "$GIRL_SIZE $BOY_SIZE $FAM_SIZE"

gen_name() {
    FAM_IDX=$(( $RANDOM % $FAM_SIZE))
    FAM=${FAMILY_NAMES[$FAM_IDX]}

    if [ "$BOY_" = "true" ]
    then
	BOY_IDX=$(( $RANDOM % $BOY_SIZE))
	BOY=${BOY_NAMES[$BOY_IDX]}
    else
	BOY=""
    fi

    if [ "$GIRL_" = "true" ]
    then
	GIRL_IDX=$(( $RANDOM % $GIRL_SIZE))
	GIRL=${GIRL_NAMES[$GIRL_IDX]}
    else
	GIRL=""
    fi
}

print_person_sub_java()
{
    GIV_=$1
    FAM_=$2

    if [ "$GIV_" != "" ]
    then
	echo -n "    persons.add(new Person(\"$GIV_ $FAM_\""
	if [ "$EMAIL" = "true" ]
	then
	    echo -n ",\"${GIV_}@${FAM_}.com\"" | \
		awk '{ printf "%s", tolower($0) } '| \
		sed -e 's,[åä],a,g' -e 's,ö,o,g'
	fi
	echo ");"
    fi
}

print_person_sub_xml()
{
    GIV_=$1
    FAM_=$2

    if [ "$GIV_" != "" ]
    then
	echo -e "  <person>\n    <name>$GIV_ $FAM_</name>"
	if [ "$EMAIL" = "true" ]
	then
	    echo "    <email>${GIV_}@${FAM_}.com</email>" | \
		awk '{ printf "%s\n", tolower($0) } '| \
		sed -e 's,[åä],a,g' -e 's,ö,o,g'
	fi
	echo "  </person>"
    fi
}

print_person_sub_json()
{
    GIV_=$1
    FAM_=$2

    if [ "$GIV_" != "" ]
    then
	echo -n " { \"name\": \"$GIV_ $FAM_\""
	if [ "$EMAIL" = "true" ]
	then
	    echo -n ", \"email\": \"${GIV_}@${FAM_}.com\"" | \
		awk '{ printf "%s", tolower($0) } '| \
		sed -e 's,[åä],a,g' -e 's,ö,o,g'
	fi
	echo -n "}"
    fi
}

print_person_sub_sql()
{
    GIV_=$1
    FAM_=$2

    if [ "$GIV_" != "" ]
    then
	echo -n " ('$GIV_ $FAM_'"
	if [ "$EMAIL" = "true" ]
	then
	    echo -n ", '${GIV_}@${FAM_}.com'" | \
		awk '{ printf "%s", tolower($0) } '| \
		sed -e 's,[åä],a,g' -e 's,ö,o,g'
	fi
	echo -n ")"
    fi
}

print_person_sub_txt()
{
    GIV_=$1
    FAM_=$2

    if [ "$GIV_" != "" ]
    then
	echo -n "$GIV_ $FAM_"
	if [ "$EMAIL" = "true" ]
	then
	    echo ", ${GIV_}@${FAM_}.com" | \
		awk '{ printf "%s", tolower($0) } '| \
		sed -e 's,[åä],a,g' -e 's,ö,o,g'
	fi
    fi
}

print_person(){
    gen_name
#    echo "FORMAT: $FORMAT"
    print_person_sub_$FORMAT "$BOY" "$FAM"
    if [ "$BOY" != "" ] &&  [ "$GIRL" != "" ];
    then
	if [  "$FORMAT" = "sql" ] 
	then
	    echo -n ", "
	elif [  "$FORMAT" = "json" ] 
	then
	    echo ", "
	elif [  "$FORMAT" = "xml" ] 
	then
	    :
	elif [  "$FORMAT" = "java" ] 
	then
	    :
	else
	    echo
	fi
    fi
    print_person_sub_$FORMAT "$GIRL" "$FAM"
}

usage()
{
    PROG=$(basename $0)
    echo "NAME"
    echo "    $PROG [OPTIONS] [NR] "
    echo 
    echo "SYNOPSIS"
    echo "    Generate one or many (Swedish) names male or female."
    echo "    If you specify  number, that many names are"
    echo "    generated. Names are generated with or without"
    echo "    an email address."
    echo 
    echo "    Supported output formats: see below"
    echo 
    echo "    The names generated are based on the most common"
    echo "    names in Sweden."
    echo 
    echo "OPTIONS"
    echo 
    echo "  --help, -h " 
    echo "     print help text, that is this text :) " 
    echo 
    echo "  --male, -m " 
    echo "     generate male name(s)."
    echo 
    echo "  --email, -e " 
    echo "     generate email addesses as well"
    echo 
    echo "  --female, -f " 
    echo "     generate male name(s)"
    echo ""
    echo "  --mixed " 
    echo "     generate mixed male and female name(s). Default."
    echo ""
    echo "  --sql " 
    echo "     output in SQL"
    echo ""
    echo "  --db " 
    echo "     creates a database (SQLite) with students."
    echo ""
    echo "  --json " 
    echo "     output in JSON format"
    echo ""
    echo "  --xml " 
    echo "     output in XML format"
    echo ""
    echo "  --java " 
    echo "     output in Java format (a method returning a List<Person>)."
    echo ""
    echo "EXAMPLES"
    echo ""
    echo "  $PROG"
    echo "     generates one male and one female name"
    echo ""
    echo "  $PROG 2"
    echo "     generates two male and two female name"
    echo ""
    echo "  $PROG --male"
    echo "     generates one male name"
    echo ""
    echo "  $PROG --female"
    echo "     generates one female name"
    echo ""
    echo "  $PROG --female 10"
    echo "     generates 10 female names"
    echo ""
    echo "  $PROG --male 100"
    echo "     generates 100 female names"
    echo ""
    echo "  $PROG --mixed 10"
    echo "     generates 5 female names and 5 male names"
    echo ""
    echo "  $PROG --sql 1000"
    echo "     creates a database (SQLite) with 2000 students (mixed male/female)"
    echo ""
    echo "  $PROG --sql --email 1000"
    echo "     creates a database (SQLite) with 2000 students (incl email)"
    echo ""
    echo "  $PROG --json --email 1000"
    echo "     outputs 2000 students (incl email) in JSON format"
    echo ""
}

FORMAT=txt
NR=1
GIRL_=true
BOY_=true
DB_NAME=student
NAME_COL=name
EMAIL_COL=email
while [ "$1" != "" ]
      do
          case "$1" in
              "--female"|"-f")
                  GIRL_=true
                  BOY_=false
#                  echo "$GIRL $FAM"
                  ;;
              "--male"|"-m")
                  GIRL_=false
                  BOY_=true
#                  echo "$BOY $FAM"
                  ;;
              "--mixed")
                  GIRL_=true
                  BOY_=true
#                  echo "$BOY $FAM"
                  ;;
              "--sql")
                  FORMAT=sql
                  ;;
              "--db")
                  FORMAT=db
                  ;;
              "--json")
                  FORMAT=json
                  ;;
              "--xml")
                  FORMAT=xml
                  ;;
              "--java")
                  FORMAT=java
                  ;;
              "--help"|"-h")
                  usage
                  exit 0
                  ;;
              "--email"|"-e")
                  EMAIL=true
                  ;;
              *)
                  NR=$1
                  ;;
          esac    
              shift
done          

pre_print_txt() {
    :
}

pre_print_java() {
    echo "  public static List<Person> personList() { "
    echo "    List<Person> persons = new ArrayList<>(); "
}

pre_print_json() {
    echo "["
}

pre_print_xml() {
    echo '<?xml version="1.0" encoding="UTF-8" standalone="no"?>'
    echo "<persons>"
}

pre_print_sql() {
    echo -n "CREATE TABLE student(id integer primary key not null, name text not null"
    if [ "$EMAIL" = "true" ]
    then
	echo -n ", email text not null"
    fi
    echo ");"
    
    echo -n "INSERT INTO $DB_NAME (name"
    if [ "$EMAIL" = "true" ]
    then
	echo -n ", email"
    fi
    echo -n ") VALUES "
}

print_persons() {

    while [ $NR -gt 0 ]
    do
	print_person
	NR=$(( $NR - 1 ))
	if [ $NR -gt 0 ]
	then
	    if [  "$FORMAT" = "sql" ] 
	    then
		echo -n ", "
	    elif [  "$FORMAT" = "json" ] 
	    then
		echo ", "
	    elif [  "$FORMAT" = "xml" ] 
	    then
		:
	    elif [  "$FORMAT" = "java" ] 
	    then
		:
	    else
		echo
	    fi
	fi
	
    done
}

post_print_sql() {
    echo ";"
}

post_print_txt() {
    echo
}

post_print_json() {
    echo -e "\n]"
}

post_print_xml() {
    echo -e "</persons>"
}

post_print_java() {
    echo "    return persons;"
    echo "  }"
}

print_all() {
    pre_print_$FORMAT
    print_persons
    post_print_$FORMAT
}

if [  "$FORMAT" = "db" ]
then
    if [ -f ${DB_NAME}.db ]
    then
	echo "Moving old ${DB_NAME}.db to ${DB_NAME}-backup.db"
	mv "${DB_NAME}.db" "${DB_NAME}-backup.db"
    fi
    FORMAT=sql
    echo -n "Creating SQLite database: "
    print_all | sqlite3 ${DB_NAME}.db
    echo  "${DB_NAME}.db    - with" $(sqlite3 ${DB_NAME}.db "SELECT COUNT(*) FROM student;") "students in it"
    
else
    print_all 
fi

exit 0

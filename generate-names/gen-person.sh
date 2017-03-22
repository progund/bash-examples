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

#echo "$GIRL_SIZE $BOY_SIZE $FAM_SIZE"

gen_name() {

    GIRL_IDX=$(( $RANDOM % $GIRL_SIZE))
    BOY_IDX=$(( $RANDOM % $BOY_SIZE))
    FAM_IDX=$(( $RANDOM % $FAM_SIZE))
    
    GIRL=${GIRL_NAMES[$GIRL_IDX]}
    BOY=${BOY_NAMES[$BOY_IDX]}
    FAM=${FAMILY_NAMES[$FAM_IDX]}
}

print_person(){
    gen_name
    if [ "$GIRL_" = "true" ]
    then
        echo "$GIRL $FAM"
    else
        echo "$BOY $FAM"
    fi

}

NR=1
while [ "$1" != "" ]
      do
          case "$1" in
              "--girl")
                  GIRL_=true
                  BOY_=false
#                  echo "$GIRL $FAM"
                  ;;
              "--boy")
                  GIRL_=false
                  BOY_=true
#                  echo "$BOY $FAM"
                  ;;
              *)
                  NR=$1
                  ;;
          esac    
              shift
done          
if [ "$NR" != "1" ]
then
    while [ $NR -gt 0 ]
    do
        print_person
        NR=$(( $NR -1 ))
    done
else
    print_person
fi

exit 0

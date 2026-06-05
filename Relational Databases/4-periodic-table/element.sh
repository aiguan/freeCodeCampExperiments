#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

MAIN_PRINT() {
  if [[ -z $1 ]]
  then 
    echo "Please provide an element as an argument."
  else
    ELEMENT_INFO $1
  fi
}

ELEMENT_INFO() {
  # look for element
  if [[ $1 =~ [0-9]+ ]]
  then
    ATOMIC_NUMBER=$($PSQL "
      SELECT atomic_number FROM elements 
      WHERE atomic_number=$1;
    ")
  else
    ATOMIC_NUMBER=$($PSQL "
      SELECT atomic_number FROM elements 
      WHERE name='$1' OR symbol='$1';
    ")
  fi

  # if not found
  if [[ -z $ATOMIC_NUMBER ]]
  then 
    echo "I could not find that element in the database."
  else
    $PSQL "
      SELECT symbol, name, atomic_mass, melting_point_celsius, boiling_point_celsius, type 
      FROM elements 
        INNER JOIN properties USING (atomic_number) 
        INNER JOIN types USING (type_id) 
      WHERE atomic_number=$ATOMIC_NUMBER
    " | 
    while IFS="|" read -r SYMBOL NAME ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE
    do 
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    done
  fi
}

MAIN_PRINT $1
#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=salon --tuples-only -c"

# Menu for service booking at hair salon

echo -e "
~~~~      Welcome to       ~~~~
~~~~     CURL & STYLE      ~~~~
~~~~ your local hair salon ~~~~

We offer the following services:
"

MAIN_MENU() {
  # print arguument if exists
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  # list services
  SERVICES=$($PSQL "SELECT * FROM services")
  echo "$SERVICES" | while read SERVICE_ID BAR SERVICE_NAME
  do
    echo "$SERVICE_ID) $SERVICE_NAME"
  done
  
  # user to select service
  echo -e '\nPlease select the number of the service you would like today:'
  read SERVICE_ID_SELECTED
  SERVICE_SELECTED=$($PSQL "
    SELECT name 
    FROM services 
    WHERE service_id = $SERVICE_ID_SELECTED
  ")
  if [[ -z $SERVICE_SELECTED ]]
  then
    MAIN_MENU "Please enter a valid service number from the menu below:"
  else
    # ask for phone number
    echo -e '\nPlease enter your phone number:'
    read CUSTOMER_PHONE
    CUSTOMER_NAME=$($PSQL "
      SELECT name
      FROM customers 
      WHERE phone = '$CUSTOMER_PHONE'
    ")
    # if phone number does not exist
    if [[ -z $CUSTOMER_NAME ]]
    then 
      # ask for customer name
      echo -e '\nPlease enter your name:'
      read CUSTOMER_NAME
      INSERT_CUSTOMER=$($PSQL "
        INSERT INTO customers (phone, name) 
        VALUES ('$CUSTOMER_PHONE', '$CUSTOMER_NAME')
      ")

      # ask for appointment time
      echo -e "\nThanks for choosing us $CUSTOMER_NAME! What time would you like your$SERVICE_SELECTED?"
    else 
      echo -e "\nWelcome back$CUSTOMER_NAME! What time would you like your$SERVICE_SELECTED?"
    fi
    
    # fix appointment
    read SERVICE_TIME
    CUSTOMER_ID=$($PSQL "
      SELECT customer_id
      FROM customers 
      WHERE phone = '$CUSTOMER_PHONE'
    ")
    INSERT_APPOINTMENT=$($PSQL "
      INSERT INTO appointments (customer_id, service_id, time)
      VALUES ($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')
    ")
    echo -e "\nI have put you down for a$SERVICE_SELECTED at $SERVICE_TIME, $CUSTOMER_NAME."
  fi
}

MAIN_MENU


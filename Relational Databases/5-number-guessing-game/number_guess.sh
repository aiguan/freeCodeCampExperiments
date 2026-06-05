#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

# Number Guessing Game

# prompt for username
GREET_USER() {
  # prompt for username
  echo "Enter your username:"
  read USER

  # ensure username is at most 22 characters
  if [[ ! ${#USER} -le 22 ]] || [[ -z $USER ]]
  then
    echo "Please enter a username between 1–22 characters."
    GREET_USER
  else
    # lookup user_id
    USER_ID=$($PSQL "
      SELECT user_id FROM users WHERE username='$USER';
    ")

    if [[ -z $USER_ID ]]
    then
      # if not found
      echo "Welcome, $USER! It looks like this is your first time here."
      # add to database
      INSERT_USER=$($PSQL "
        INSERT INTO users (username) VALUES ('$USER');
      ")
      # get new user_id
      USER_ID=$($PSQL "
        SELECT user_id FROM users WHERE username='$USER';
      ")
    else 
      # get user history from database if found
      GAMES_PLAYED=$($PSQL "
        SELECT COUNT(*) FROM games WHERE user_id=$USER_ID;
      ")
      BEST_GUESS=$($PSQL "
        SELECT MIN(number_of_guesses) FROM games WHERE user_id=$USER_ID;
      ")
      echo "Welcome back, $USER! You have played $GAMES_PLAYED games, and your best game took $BEST_GUESS guesses."
    fi 
  fi

  # generate number and initialize number of guesses
  TARGET=$(( $RANDOM % 1000 + 1 ))
  NUMBER_OF_GUESSES=0
  GUESSING_LOGIC
}

INPUT_GUESS() {
  echo $1
  read CURRENT_GUESS
  GUESSING_LOGIC
}

GUESSING_LOGIC() {
  # if game has just begun 
  if [[ -z $CURRENT_GUESS ]]
  then 
    INPUT_GUESS "Guess the secret number between 1 and 1000:"
  # if guess not an integer
  elif [[ ! $CURRENT_GUESS =~ ^[0-9]+$ ]]
  then
    INPUT_GUESS "That is not an integer, guess again:"
  else
    # for valid guesses
    (( NUMBER_OF_GUESSES++ )) # increment
    # compare numbers
    if [[ $CURRENT_GUESS -lt $TARGET ]]
    then
      INPUT_GUESS "It's higher than that, guess again:"
    elif [[ $CURRENT_GUESS -gt $TARGET ]]
    then
      INPUT_GUESS "It's lower than that, guess again:"
    else
      SAVE_GAME
      echo "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $TARGET. Nice job!"
    fi
  fi
}

SAVE_GAME() {
  ADD_GAME=$($PSQL "
    INSERT INTO games (user_id, number_of_guesses) VALUES ($USER_ID,$NUMBER_OF_GUESSES);
  ")
}

GREET_USER
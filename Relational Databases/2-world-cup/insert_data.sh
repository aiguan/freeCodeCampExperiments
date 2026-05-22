#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# clear existing database
# echo $($PSQL "TRUNCATE games,teams")

cat games.csv | while IFS=',' read YEAR ROUND WINNER OPP WINNER_GOALS OPP_GOALS
do
  # omit header 
  if [[ $YEAR != year ]]
  then
    # BUILD TEAMS TABLE
    # winning teams first
    # find team_id
    WIN_TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    # if not found
    if [[ -z $WIN_TEAM_ID ]]
    then
      # add team
      INSERT_TEAM_RESULT=$($PSQL "INSERT INTO teams (name) VALUES ('$WINNER')")
    fi
    # other teams
    # find team_id
    OPP_TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPP'")
    # if not found
    if [[ -z $OPP_TEAM_ID ]]
    then
      # add team
      INSERT_TEAM_RESULT=$($PSQL "INSERT INTO teams (name) VALUES ('$OPP')")
    fi

    # BUILD GAMES TABLE
    # get new team_ids
    WIN_TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    OPP_TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPP'")
    # insert into games table
    INSERT_GAME_RESULT=$($PSQL "
      INSERT INTO games (year,round,winner_id,opponent_id,winner_goals,opponent_goals)
      VALUES ($YEAR,'$ROUND',$WIN_TEAM_ID,$OPP_TEAM_ID,$WINNER_GOALS,$OPP_GOALS)
    ")
  fi
done
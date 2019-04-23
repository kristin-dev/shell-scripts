#!/bin/bash

# Author: Kristin Bradham - UCSC

# This script searches for all the people sites on this machine. 

# This set command stops the execution of a script if command or pipeline has an
# error - which is the opposite of the default shell behaviour, which is to 
# ignore errors in scripts. 
set -e

# Create a log file
timeRun=$(date '+%Y-%m-%d-%H:%M:%S')
logFile="logs/list-sites-people-$timeRun.txt"

# Create a log file that has one name for most recent log.
secondLogFile="logs/people-sites-most-recent.txt"

echo > $logFile
echo > $secondLogFile

# Find all the directories where we're searching that have an html file in them,
# this identifies each directory as containing a drupal site.
directories=( a b c d e f g h i j k l m n o p q r s t u v w x y z )

for i in "${directories[@]}"
do
  for file in $(find /afs/cats.ucsc.edu/users/$i/*/ -maxdepth 1 -not -empty -type d -name "public_html"); do

        siteNumber=$((siteNumber + 1))

        # Write which directories were updated to log file. 
        # echo $siteNumber $file >> $logFile
        # echo $siteNumber $file >> $secondLogFile
        string2=${file#"/afs/cats.ucsc.edu/users/$i/"}
        string2=${string2%"/public_html"}
        echo $string2@ucsc.edu >> $logFile
        echo $string2@ucsc.edu >> $secondLogFile

        # Spit everything out so we can see what we're working with.
        # echo "Site: $siteNumber $file"
  done
done


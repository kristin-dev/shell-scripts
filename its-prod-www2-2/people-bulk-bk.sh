#!/bin/bash

# Author: Kristin Bradham - UCSC

# This script searches for all the people sites on this machine. 
# It takes one argument - the full path of a log file with a list of sites to
# skip. It must also have logs/blank.txt file existing.

# This set command stops the execution of a script if command or pipeline has an
# error - which is the opposite of the default shell behaviour, which is to 
# ignore errors in scripts. 
set -e

# Start in the directory to be searched.
searchLocation="/afs/cats.ucsc.edu/users/"

# Create a log file
timeRun=$(date '+%Y-%m-%d-%H:%M:%S')
logFile="logs/list-sites-people-$timeRun.txt"

# Create a log file that has one name for most recent log.
secondLogFile="logs/people-sites-most-recent.txt"

echo > $logFile
echo > $secondLogFile

# Find all the directories where we're searching that have an html file in them,
# this identifies each directory as containing a drupal site.
for file in $(find /afs/cats.ucsc.edu/users/$1/*/ -maxdepth 1 -not -empty -type d -name "public_html"); do

        siteNumber=$((siteNumber + 1))

        # Write which directories were updated to log file. 
        echo $siteNumber $file >> $logFile
        echo $siteNumber $file >> $secondLogFile

        # Spit everything out so we can see what we're working with.
        echo "Site: $siteNumber $file"
done


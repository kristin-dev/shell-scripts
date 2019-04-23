#!/bin/bash

# Loop through the php apacheconfig file and list sites with php access
# 3 files are at: /opt/app/apache9001/conf/php-people/php-people-prod, -dev, -stage

#!/bin/bash
PATTERN='"/~'
FILE='php-people-prod'

touch logfile.txt

if grep -q $PATTERN $FILE;
 then
     echo "Here are the Strings with the Pattern '$PATTERN':"
     echo -e "$(grep $PATTERN $FILE)\n"
     echo -e "$(grep $PATTERN $FILE)\n" >> logfile.txt
 else
     echo "Error: The Pattern '$PATTERN' was NOT Found in '$FILE'"
     echo "Exiting..."
     #exit 0
fi

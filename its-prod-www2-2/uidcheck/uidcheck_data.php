<?php

// get the uidcheck_check
require('uidcheck_check.php');

// get the usernames from the data file
$file_lines = file('/afs/cats.ucsc.edu/www/its2/prod/cgi-data/webpublish/data');

//put a date on the log file
date_default_timezone_set('America/Los_Angeles');
$contents = date("l jS \of F Y h:i:s A") . "\n";

$data_contents = "";
$redirect_non_affiliated = "";

foreach ($file_lines as $line) {
    // echo $line;
    $arr = explode(":", $line, 2);
    $username = $arr[0];
    //echo $username . "\n";
   
    // check if the person is affiliated 
    $affiliation = uidcheck_check($username);

    if ($affiliation == "None") {
      // if the person isn't affiliated add them to the log of people removed
      $contents = $contents . $username . "\n";      

      // if the person isn't affiliated add them to the redirect list
      $redirect_non_affiliated = "Redirect permanent /~" . $username . "/ https://its.ucsc.edu/web/people-site-archived.html\n";
      file_put_contents("/opt/app/apache9001/conf/vhosts/redirect_non_affiliated",$redirect_non_affiliated,FILE_APPEND);

      // if the person isn't affiliated, this will the data list by not including in $data_contents

    } else {
      // if their affiliation isn't "None", add them to the new data file.
      $data_contents .= $line;
    }
}

file_put_contents("/home/kbradham/scripts/uidcheck/data_log.txt",$contents,FILE_APPEND);
file_put_contents("/afs/cats.ucsc.edu/www/its2/prod/cgi-data/webpublish/data",$data_contents);

?>

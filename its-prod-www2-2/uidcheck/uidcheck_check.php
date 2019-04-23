<?php
function uidcheck_check($uid) {

    // Check that our connection is valid
    $ds=ldap_connect("ldap://ldap-blue.ucsc.edu/");  // must be a valid LDAP server!

    // UID entry search
    $sr=ldap_search($ds, "ou=people,dc=ucsc,dc=edu", "(uid=$uid)");
    //echo "Active person: " . ldap_count_entries($ds, $sr);

    // Get entry information for this search
    $info = ldap_get_entries($ds, $sr);

    // If they have an affiliation return it, if not keep going
    if (!isset($info[0]['ucscpersonpubaffiliation'])) { 
      return "None"; 
    } else {
      return $info[0]["ucscpersonpubaffiliation"][0];
    }
    ldap_close($ds);
}

//Testing each type
//echo uidcheck_check('kbarad') . "\n";
//echo uidcheck_check('mbaynokr') . "\n";
//echo uidcheck_check('kbradham') . "\n";
//echo uidcheck_check('gbalvara') . "\n";
//echo uidcheck_check('laknlrnepairalnflasnf') . "\n";
?>

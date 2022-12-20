<?php
$ip             = @$_SERVER[REMOTE_ADDR];
$referrer       = @$_SERVER[HTTP_REFERER];
$remote_host    = @$_SERVER[REMOTE_HOST];


//$Page       = $PHP_SELF;
$Page         = $_SERVER['PHP_SELF'];
//print($Page);
$p              = explode("/", $Page);
//print_r($p);
$Page           = $p[sizeof($p)-1];
$Folder         = $p[sizeof($p)-2];
//print($Folder);

//if($Folder == "seed")
//    $Folder = "";

$Site = $_SERVER['HTTP_HOST'];


//////////////////////////////////////////////////////////////////
//          THERE IS ANOTHER MODULE FOR COUNTING USERS          //
//          IT SHOULD BE INSTALLED SEPARATELLY IF NEEDED        //
//////////////////////////////////////////////////////////////////


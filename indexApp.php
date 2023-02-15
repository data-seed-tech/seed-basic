<?php
require_once("./connection.inc");
require_once("./counter.inc");

/////////////////////////////////////
//            appCode              //
/////////////////////////////////////
$appCode  =	@$_POST['app'];
if($appCode == "")
    $appCode  = @$_GET['app'];
//print($appCode);

$table = "";

$query = "SELECT seed_apps.appCode, seed_apps.appName, seed_apps.appDescription, seed_apps.icon
                        FROM seed_apps WHERE appCode = '".$appCode."';";
$result = $conn -> query($query);
$row = $result -> fetch_object();

$appCode = $row->appCode;
$appDenumire = $row->appName;
$appDescriere = $row->appDescription;
$appIcon = $row->icon;



?>

<html>
<head>
    <title><?php print($appCode); ?></title>
    <link rel="stylesheet" type="text/css" href="./styles.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
</head>
<body>
<div class="header">
    <h1><a href="./" class="header">&#127968; <?php print($Site); ?></a>&nbsp;&nbsp;>&nbsp; <?php print($appIcon); ?> <?php print($appDenumire); ?></h1>
</div>

<div class="container">
    <?php require_once("./menu.inc"); ?>
    <?php require_once("./menu_left.inc"); ?>
    
    
    
    <div class="right">
        <div class='descriere'><?php print($appIcon . " " . $appDescriere); ?></div><br/>
        
        <?php
        $query_menu = "SELECT seed_apps.appCode, seed_apps.appName, seed_apps.appDescription, seed_apps.icon,
                                seed_menus.tableName, seed_menus.menuText
                        FROM seed_apps
                        INNER JOIN seed_menus ON seed_apps.appCode = seed_menus.appCode
                        WHERE seed_apps.appCode = '".$appCode."';";
        $result_menu = $conn -> query($query_menu);
            
        while($row_menu = $result_menu -> fetch_object())
        {
            $appCode = $row_menu->appCode;
            $tableName = $row_menu->tableName;
            $menuText = $row_menu->menuText;
            $icon = $row_menu->icon;
            ?>
            <div class="appCardMenu" onclick="javascript:location.href='./entityView.php?app=<?php print($appCode); ?>&table=<?php print($tableName); ?>';" title="Editare <?php print($tableName); ?>">
                <div class='valoare_buna'><?php print ($icon); ?> <?php print ($menuText); ?></div><br/>
            
                <?php
                /////////////////////////////////////
                //         table description       //
                /////////////////////////////////////
                $query_table = "SELECT TABLE_COMMENT
                            FROM information_schema.tables 
                            WHERE table_name = '" . $tableName . "';";
                $result_table = $conn -> query($query_table);
                $row_table = $result_table -> fetch_object();
                print(substr($row_table->TABLE_COMMENT, 0, 30) . "...");
                ?>
            </div>&nbsp;&nbsp;&nbsp;&nbsp;
        <?php
        }
        ?>
            
            
            
        
    </div>
    
</div>
    
</body>
</html>



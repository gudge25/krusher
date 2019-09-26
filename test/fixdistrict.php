<?php

/* Attempt MySQL server connection. Assuming you are running MySQL
    server with default setting (user 'root' with no password) */
    //$link = mysqli_connect("192.168.1.131", "proxyuser", "s3cret", "testing");
    //$link = mysqli_connect("192.168.1.131", "root", "s3cret", "testing", '32768');
    //$link = mysqli_connect("144.76.173.45", "proxyuser", "s3cret", "testing");
    $link = mysqli_connect("176.111.58.193", "tralala", "tralala33tralala33", "region");
    //$link = mysqli_connect("176.111.58.193", "proxyuser", "s3cret", "testing");
    mysqli_set_charset('utf8', $link);
    $query  = "SET NAMES utf8";
    mysqli_query($link, $query);
    // Check connection
    if($link === false){
        die("ERROR: Could not connect. " . mysqli_connect_error());
    }



    $query = 'SELECT raID, raName, rcID, GMT, rdID, rkSocr, rkCode, isCIS 
                FROM reg_area
                ORDER BY raName;';
    $result = mysqli_query($link, $query);
    while ($row = mysqli_fetch_row($result)) {
        $queryIns = '';
        if(strlen($row[5])>0)
        {
            $query_ = 'SELECT rsID, rsName FROM reg_socr
                          WHERE rsSocr="'.$row[5].'";';
            echo $query_."\r\n";
            $result_ = mysqli_query($link, $query_);
            unset($row2);
            $row2 = mysqli_fetch_row($result_);
            if(count($row2)>0)
            {
                $queryIns = 'INSERT INTO krusher.reg_district (countryID, nameDistrict, languageID, regType) 
                          VALUES ('.$row[2].', "'.$row[1].'", 2, '.$row2[0].');';
                mysqli_query($link, $queryIns);
            }
            else
            {
                echo '=========================================';
                print_r($row);
                print_r($query_);
                echo '=========================================';
            }
        }
        else
        {
            $queryIns = 'INSERT INTO krusher.reg_district (countryID, nameDistrict, languageID, regType) 
                          VALUES ('.$row[2].', "'.$row[1].'", 2, NULL);';
            mysqli_query($link, $queryIns);
        }

        echo $queryIns."\r\n";

        /*print_r($row);
        print_r($row2);
        print_r($queryIns);
        exit();*/
    }



    // Close connection
    mysqli_close($link);

?>


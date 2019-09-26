<?php

/* Attempt MySQL server connection. Assuming you are running MySQL
server with default setting (user 'root' with no password) */
//$link = mysqli_connect("192.168.1.131", "proxyuser", "s3cret", "testing");
//$link = mysqli_connect("192.168.1.131", "root", "s3cret", "testing", '32768');
$link = mysqli_connect("144.76.173.45", "proxyuser", "s3cret", "testing");
//$link = mysqli_connect("176.111.58.193", "proxyuser", "s3cret", "testing");

// Check connection
if($link === false){
    die("ERROR: Could not connect. " . mysqli_connect_error());
}

// Attempt insert query execution

for($i = 1; $i <= 1000000; $i++)
{
    $sql = "INSERT INTO incoming (num, info) VALUES ($i, '".$i."')";
    //echo $sql."\r\n";
    mysqli_query($link, $sql);
}

if(mysqli_query($link, $sql)){
    echo "Records inserted successfully.";
} else{
    echo "ERROR: Could not able to execute $sql. " . mysqli_error($link);
}
// Close connection
mysqli_close($link);

?>


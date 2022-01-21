<?php
error_reporting(0);
include_once("dbconnect.php");
$email = $_GET['email'];
$otp = $_GET['otp'];

$sqlverify = "SELECT * FROM tbl_users WHERE user_email = '$email' AND otp = '$otp'";
$result = $conn->query($sqlverify);

if ($result->num_rows > 0)
{
   $newotp = '1';
   $sqlupdate = "UPDATE tbl_users SET otp = '$newotp' WHERE user_email = '$email'";
  if ($conn->query($sqlupdate) === TRUE){
        echo "success";
  }else{
      echo "failed";;
  }
}
 
?>
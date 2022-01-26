<?php

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require '/home8/slumber6/public_html/PHPMailer/src/Exception.php';
require '/home8/slumber6/public_html/PHPMailer/src/PHPMailer.php';
require '/home8/slumber6/public_html/PHPMailer/src/SMTP.php';


if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

$name = $_POST['name'];
$email = $_POST['email'];
$password = sha1($_POST['password']);
$otp = rand(10000, 99999);
$na = "na";
$credit = 10;
$sqlinsert = "INSERT INTO tbl_users (user_email,user_name,user_password,user_phone,user_address,otp,user_credit) VALUES('$email','$name','$password','$na','$na',$otp,$credit)";
if ($conn->query($sqlinsert) === TRUE) {
    $response = array('status' => 'success', 'data' => null);
    sendEmail($email,$otp);
    sendJsonResponse($response);
} else {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
}


function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}

function sendEmail($email,$otp)
{
    //send email function here
    $mail = new PHPMailer(true);
    $mail->SMTPDebug = 0;                                               //Disable verbose debug output
    $mail->isSMTP();                                                    //Send using SMTP
    $mail->Host       = 'mail.slumberjer.com';                          //Set the SMTP server to send through
    $mail->SMTPAuth   = true;                                           //Enable SMTP authentication
    $mail->Username   = '';  
    $mail->Password   = '';
    $mail->SMTPSecure = 'tls';         
    $mail->Port       = 587;
    
    $from = "";
    $to = $email;
    $subject = 'MyPasar - Please verify your account';
    $message = "<h2>Welcome to MyPasar App</h2> <p>Thank you for registering your account with MyPasar. To complete your registration please click the following.<p>
    <p><button><a href ='https://slumberjer.com/mypasarv2/php/verifyaccount.php?email=$email&otp=$otp'>Verify Here</a></button>";
    
    $mail->setFrom($from,"SlumberSoft");
    $mail->addAddress($to);                                             //Add a recipient
    
    //Content
    $mail->isHTML(true);                                                //Set email format to HTML
    $mail->Subject = $subject;
    $mail->Body    = $message;
    $mail->send();
    
    
}
?>
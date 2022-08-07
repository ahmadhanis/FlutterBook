<?php
error_reporting(0);
include_once("dbconnect.php");
$email = $_GET['userid'];
$name = $_GET['name'];
$mobile = $_GET['mobile'];
$amount = $_GET['amount'];
$curcredit = $_GET['curcredit'];

$data = array(
    'id' =>  $_GET['billplz']['id'],
    'paid_at' => $_GET['billplz']['paid_at'] ,
    'paid' => $_GET['billplz']['paid'],
    'x_signature' => $_GET['billplz']['x_signature']
);

$paidstatus = $_GET['billplz']['paid'];
if ($paidstatus=="true"){
    $paidstatus = "Success";
}else{
    $paidstatus = "Failed";
}
$receiptid = $_GET['billplz']['id'];
$signing = '';
foreach ($data as $key => $value) {
    $signing.= 'billplz'.$key . $value;
    if ($key === 'paid') {
        break;
    } else {
        $signing .= '|';
    }
}
 
 
$signed= hash_hmac('sha256', $signing, 'S-wzNn8FTL0endIB4wgi728w');
if ($signed === $data['x_signature']) {
    if ($paidstatus == "Success"){ //payment success
        $newcredit = ($amount) + $curcredit;
        $updatecrsql = "UPDATE `tbl_users` SET `user_credit`='$newcredit' WHERE user_email = '$email'";
        $conn->query($updatecrsql);
        $message = "Payment completed. Return back to the application by pressing the back button on the app task bar.";
        $amount = number_format((float)$amount, 2, '.', '');
        printTable($receiptid,$name,$email,$amount,$paidstatus,$message); 
    }
    else 
    {
         $message = "Payment incompleted. Return back to the application by pressing the back button on the app task bar and perform the payment again.";
         printTable('Failed',$name,$email,$amount,$paidstatus,$message);
    }
}


function printTable($receiptid,$name,$email,$amount,$paidstatus,$message){
   echo "
        <html>
        <head>
            <meta name='viewport' content='width=device-width, initial-scale=1'>
            <link rel='stylesheet' href='https://www.w3schools.com/w3css/4/w3.css'>
        </head>
        <div = class='w3-padding'> <h4>Thank you for your payment</h4>
        <p>The following is your receipt</p></div>
        <div class='w3-container w3-padding'>
            <table class='w3-table w3-striped w3-bordered'>
            <tr><th>Receipt ID</th><td>$receiptid<td></tr>
            <tr><th>Paid By</th><td>$name<td></tr>
            <tr><th>Email</th><td>$email<td></tr>
            <tr><th>Amount </th><td>RM $amount<td></tr>
            <tr><th>Payment Status</th><td>$paidstatus<td></tr>
            </table>
        <hr>
        <div class='w3-container w3-round w3-block w3-green'>$message</div>
        </div>
        </body></html> 
        ";
}

?>
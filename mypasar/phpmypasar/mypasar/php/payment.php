<?php
error_reporting(0);

$email = $_GET['email']; //email
$mobile = $_GET['mobile']; 
$name = $_GET['name']; 
$amount = $_GET['amount']; 
$curcredit = $_GET['curcredit'];

$api_key = 'b47704d6-dd30-4143-a4b1-27eb88e8f906';
$collection_id = 'wprsfj_3';
$host = 'https://www.billplz-sandbox.com/api/v3/bills';


$data = array(
          'collection_id' => $collection_id,
          'email' => $email,
          'mobile' => $mobile,
          'name' => $name,
          'amount' => ($amount + 1) * 100, // RM20
		  'description' => 'Payment for order by '.$name,
          'callback_url' => "https://slumberjer.com/mypasar/return_url",
          'redirect_url' => "https://slumberjer.com/mypasar/php/payment_update.php?name=$name&userid=$email&mobile=$mobile&amount=$amount&curcredit=$curcredit" 
);


$process = curl_init($host );
curl_setopt($process, CURLOPT_HEADER, 0);
curl_setopt($process, CURLOPT_USERPWD, $api_key . ":");
curl_setopt($process, CURLOPT_TIMEOUT, 30);
curl_setopt($process, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($process, CURLOPT_SSL_VERIFYHOST, 0);
curl_setopt($process, CURLOPT_SSL_VERIFYPEER, 0);
curl_setopt($process, CURLOPT_POSTFIELDS, http_build_query($data) ); 

$return = curl_exec($process);
curl_close($process);

$bill = json_decode($return, true);
header("Location: {$bill['url']}");
?>
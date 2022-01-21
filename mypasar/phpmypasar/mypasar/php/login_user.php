<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    echo "failed";
    die();
}
include_once("dbconnect.php");

$email = $_POST['email'];
$password = sha1($_POST['password']);
$otp = '1';
$sqllogin = "SELECT * FROM tbl_users WHERE user_email = '$email' AND user_password = '$password' AND otp = '$otp'";

$result = $conn->query($sqllogin);
if ($result->num_rows > 0) {
while ($row = $result->fetch_assoc()) {
        $userlist = array();
        $userlist['id'] = $row['user_id'];
        $userlist['name'] = $row['user_name'];
        $userlist['email'] = $row['user_email'];
        $userlist['phone'] = $row['user_phone'];
        $userlist['address'] = $row['user_address'];
        $userlist['regdate'] = $row['user_datereg'];
        $userlist['otp'] = $row['otp'];
        $userlist['credit'] = $row['users_credit'];
        echo json_encode($userlist);
        $conn->close();
        return;
    }
}else{
    echo "failed";
}
?>
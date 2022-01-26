<?php

include_once("dbconnect.php");

$email = $_POST['email'];
$sqluser = "SELECT * FROM tbl_users WHERE user_email = '$email'";

$result = $conn->query($sqluser);
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
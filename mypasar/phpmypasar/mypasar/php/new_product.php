<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

$ownerid = $_POST['pridowner'];
$owneremail = $_POST['premail'];
$prname = $_POST['prname'];
$prdesc = $_POST['prdesc'];
$prprice = $_POST['prprice'];
$prqty = $_POST['prqty'];
$prdel = $_POST['prdel'];
$prstate = $_POST['prstate'];
$prloc = $_POST['prloc'];
$prlat = $_POST['prlat'];
$prlong = $_POST['prlong'];
$encoded_string = $_POST['image'];

$sqlinsert = "INSERT INTO tbl_products (pridowner,prname,prdesc,prprice,prqty,prdel,prstate,prloc,prlat,prlong) VALUES('$ownerid','$prname','$prdesc','$prprice','$prqty','$prdel','$prstate','$prloc','$prlat','$prlong')";
if ($conn->query($sqlinsert) === TRUE) {
    $response = array('status' => 'success', 'data' => null);
    $filename = mysqli_insert_id($conn);
    $decoded_string = base64_decode($encoded_string);
    $path = '../images/products/'.$filename.'.png';
    $is_written = file_put_contents($path, $decoded_string);
    $sqlupdcredit = "UPDATE tbl_users SET users_credit = users_credit - 1 WHERE user_email = '$owneremail'";
    $conn->query($sqlupdcredit);
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

?>
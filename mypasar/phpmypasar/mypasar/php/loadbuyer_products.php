<?php

if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");
$email = $_POST['email'];
$sqlloadproduct = "SELECT * FROM tbl_products INNER JOIN tbl_users ON tbl_products.user_email = tbl_users.user_email WHERE tbl_products.user_email != '$email'  ORDER BY tbl_products.product_date DESC";
$result = $conn->query($sqlloadproduct);
if ($result->num_rows > 0) {
    $products["products"] = array();
while ($row = $result->fetch_assoc()) {
        $prlist = array();
        $prlist['user_name'] = $row['user_name'];
        $prlist['user_email'] = $row['user_email'];
        $prlist['user_phone'] = $row['user_phone'];
        $prlist['product_id'] = $row['product_id'];
        $prlist['product_name'] = $row['product_name'];
        $prlist['user_email'] = $row['user_email'];
        $prlist['product_desc'] = $row['product_desc'];
        $prlist['product_price'] = $row['product_price'];
        $prlist['product_qty'] = $row['product_qty'];
        $prlist['product_state'] = $row['product_state'];
        $prlist['product_loc'] = $row['product_loc'];
        $prlist['product_lat'] = $row['product_lat'];
        $prlist['product_long'] = $row['product_long'];
        $prlist['product_date'] = $row['product_date'];

        array_push($products["products"],$prlist);
    }
    $response = array('status' => 'success', 'data' => $products);
    sendJsonResponse($response);
}else{
    $response = array('status' => 'failed', 'data' => $sqlloadproduct);
    sendJsonResponse($response);
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}

?>
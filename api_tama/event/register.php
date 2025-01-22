<?php
include 'database.php';

$data = json_decode(file_get_contents("php://input"), true);

$username = $data['username'];
$email = $data['email'];
$password = password_hash($data['password'], PASSWORD_BCRYPT);

$sql = "INSERT INTO users (username, email, password) VALUES ('$username', '$email', '$password')";

if ($conn->query($sql) === TRUE) {
    echo json_encode(["success" => true, "message" => "User registered successfully"]);
} else {
    echo json_encode(["success" => false, "message" => "Error: " . $conn->error]);
}
?>

<?php
$host = 'teknologi22.xyz';
$user = 'teky6584_api_tegar';
$pass = 'Tegar260804';
$db = 'teky6584_api_tama';

$conn = new mysqli($host, $user, $pass, $db);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>

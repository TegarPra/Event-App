<?php
header("Content-Type: application/json");
include 'database.php';

$sql = "SELECT * FROM events";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $events = array();
    while ($row = $result->fetch_assoc()) {
        $events[] = array(
            "title" => $row['title'],
            "description" => $row['description'],
            "date_time" => $row['date_time'],
            "location" => $row['location'],
            "img_url" => $row['img_url'],
            "refund_policy" => $row['refund_policy'],
            "price" => $row['price'],
            "status" => $row['status'],
            "category" => $row['category'],
            "created_at" => $row['created_at'],
            "updated_at" => $row['updated_at']
        );
    }
    echo json_encode($events);
} else {
    echo json_encode([]);
}

$conn->close();
?>

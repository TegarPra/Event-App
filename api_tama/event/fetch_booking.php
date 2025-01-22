<?php
header('Content-Type: application/json');

// Konfigurasi database
$host = 'teknologi22.xyz';
$username = 'teky6584_api_tegar';
$password = 'Tegar260804';
$dbname = 'teky6584_api_tama';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Query untuk mengambil semua data pemesanan
    $stmt = $pdo->query("SELECT * FROM pemesanan");
    $bookings = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode($bookings);
} catch (PDOException $e) {
    echo json_encode(['success' => false, 'message' => 'Kesalahan pada server: ' . $e->getMessage()]);
}
?>

<?php
header('Content-Type: application/json');

// Konfigurasi database
$host = 'teknologi22.xyz';
$username = 'teky6584_api_tegar';
$password = 'Tegar260804';
$dbname = 'teky6584_api_tama';

try {
    // Koneksi ke database
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Memeriksa apakah parameter 'email' diterima
    if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['email'])) {
        $email = $_POST['email'];

        // Query untuk menghapus data berdasarkan email
        $stmt = $pdo->prepare("DELETE FROM pemesanan WHERE email = :email");
        $stmt->bindParam(':email', $email);

        if ($stmt->execute()) {
            echo json_encode(['success' => true, 'message' => 'Pesanan berhasil dibatalkan']);
        } else {
            echo json_encode(['success' => false, 'message' => 'Gagal menghapus pesanan']);
        }
    } else {
        echo json_encode(['success' => false, 'message' => 'Email tidak ditemukan atau metode tidak valid']);
    }
} catch (PDOException $e) {
    echo json_encode(['success' => false, 'message' => 'Kesalahan pada server: ' . $e->getMessage()]);
}

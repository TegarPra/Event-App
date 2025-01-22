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

    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = $_POST['email'] ?? null;
    $field = $_POST['field'] ?? null;
    $value = $_POST['value'] ?? null;

    if (!$email || !$field || !$value) {
        error_log("Parameter tidak lengkap: email=$email, field=$field, value=$value");
        echo json_encode(['success' => false, 'message' => 'Parameter tidak lengkap']);
        exit;
    }

        $stmt = $pdo->prepare("UPDATE pemesanan SET $field = :value WHERE email = :email");
        $stmt->bindParam(':value', $value);
        $stmt->bindParam(':email', $email);

        if ($stmt->execute()) {
            echo json_encode(['success' => true, 'message' => 'Data berhasil diperbarui']);
        } else {
            echo json_encode(['success' => false, 'message' => 'Gagal memperbarui data']);
        }
    } else {
        echo json_encode(['success' => false, 'message' => 'Parameter tidak lengkap']);
    }
} catch (PDOException $e) {
    echo json_encode(['success' => false, 'message' => 'Kesalahan server: ' . $e->getMessage()]);
}

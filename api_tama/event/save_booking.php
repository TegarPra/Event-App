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

    // Mendapatkan data dari request
    $data = json_decode(file_get_contents('php://input'), true);

    if (!isset($data['name'], $data['email'], $data['phone_number'], $data['address'],  $data['payment_method'], $data['event_title'], $data['ticket_price'])) {
        echo json_encode(['success' => false, 'message' => 'Data tidak lengkap']);
        exit;
    }

    

    // Menyimpan data ke database
    $stmt = $pdo->prepare("INSERT INTO pemesanan (name, email, phone_number, address, payment_method, event_title, ticket_price) VALUES (?, ?, ?, ?, ?, ?, ?)");
    $stmt->execute([
        $data['name'],
        $data['email'],
        $data['address'],
        $data['phone_number'],
        $data['payment_method'],
        $data['event_title'],
        $data['ticket_price']
    ]);

    echo json_encode(['success' => true, 'message' => 'Pemesanan berhasil disimpan']);
} catch (PDOException $e) {
    echo json_encode(['success' => false, 'message' => 'Kesalahan pada server: ' . $e->getMessage()]);
}
?>

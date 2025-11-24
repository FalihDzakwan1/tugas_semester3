<?php
require 'DB.php';

// Inisialisasi Object Database
$db = new DB();

// --- FUNGSI BANTUAN UNTUK TAMPILAN (BONUS) ---
function tampilkanTabel($judul, $data) {
    echo "<h3>$judul</h3>";
    if (empty($data)) {
        echo "<p>Tidak ada data.</p><hr>";
        return;
    }
    // Cek apakah data multidimensi (banyak baris) atau single (1 baris dari find)
    if (isset($data['id'])) { $data = [$data]; } 

    echo "<table border='1' cellpadding='10' cellspacing='0' style='border-collapse: collapse; width: 80%; margin-bottom: 20px;'>";
    echo "<tr style='background-color: #f2f2f2;'><th>ID</th><th>Nama Produk</th><th>Kategori</th><th>Stok</th><th>Harga</th></tr>";
    foreach ($data as $row) {
        echo "<tr>";
        echo "<td>{$row['id']}</td>";
        echo "<td>{$row['nama_produk']}</td>";
        echo "<td>{$row['kategori']}</td>";
        echo "<td>{$row['stok']}</td>";
        echo "<td>Rp " . number_format($row['harga'], 0, ',', '.') . "</td>";
        echo "</tr>";
    }
    echo "</table><hr>";
}
?>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Uji Coba Query Builder</title>
    <style>body { font-family: sans-serif; padding: 20px; }</style>
</head>
<body>

    <h1>Query Builder (OOP)</h1>

    <?php
    // Menghapus semua data dulu agar ID tidak terus bertambah saat refresh
    $db->pdo->query("TRUNCATE TABLE produk"); 


    $db->insert('produk', [
        'nama_produk' => 'Laptop ASUS Vivobook 14',
        'kategori' => 'Laptop',
        'stok' => 10,
        'harga' => 8500000
    ]);
    $db->insert('produk', [
        'nama_produk' => 'Smartphone Samsung A55',
        'kategori' => 'Handphone',
        'stok' => 25,
        'harga' => 6500000
    ]);
    $db->insert('produk', [
        'nama_produk' => 'Headphone Sony WH-CH520',
        'kategori' => 'Aksesoris',
        'stok' => 15,
        'harga' => 750000
    ]);

    // Tampilkan Hasil Insert (READ)
    $semua_produk = $db->all('produk');
    tampilkanTabel("1. Insert Data Baru (READ)", $semua_produk);


    // Mengubah stok Samsung (ID 2) menjadi 50 dan Harga jadi 6.400.000
    $db->update('produk', [
        'stok' => 50,
        'harga' => 6400000
    ], 2); // ID 2

    $update_produk = $db->all('produk');
    tampilkanTabel("2. Update Data (Update)", $update_produk);


    // Menghapus Laptop Asus (ID 1)
    $db->delete('produk', 1);


    // Tampilkan Data Akhir
    $data_akhir = $db->all('produk');
    tampilkanTabel("3. Hapus (DELETE)", $data_akhir);


    // Mencari produk yang mengandung kata 'Sony'
    $hasil_cari = $db->search('produk', 'Sony');
    tampilkanTabel("4. Pencarian Keyword (SEARCH)", $hasil_cari);
    ?>

</body>
</html>
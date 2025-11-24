<?php
// DB.php

class DB {
    // Properti untuk konfigurasi database
    private $host = 'localhost';
    private $dbname = 'tokoelektronik';
    private $username = 'root';
    private $password = ''; // Sesuaikan dengan password DB Anda
    public $pdo;

    // Constructor: Dijalankan otomatis saat class dipanggil (new DB())
    public function __construct() {
        try {
            $dsn = "mysql:host={$this->host};dbname={$this->dbname}";
            $this->pdo = new PDO($dsn, $this->username, $this->password);
            
            // Set error mode ke Exception agar mudah debugging
            $this->pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            
            // Default fetch mode ke Associative Array
            $this->pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            die("Koneksi Gagal: " . $e->getMessage());
        }
    }

    // --- METHOD CRUD & QUERY BUILDER ---

    // 1. CREATE: Menambahkan data baru
    public function insert($table, $data) {
        if (isset($data['stok']) && $data['stok'] < 0) {
            die("Error: Stok tidak boleh kurang dari 0!");
        }

        // Mengambil keys (nama kolom) dan values (isi data)
        $keys = array_keys($data);
        $cols = implode(', ', $keys); // nama_produk, kategori, ...
        $placeholders = ':' . implode(', :', $keys); // :nama_produk, :kategori, ...

        // Merakit Query SQL
        $sql = "INSERT INTO $table ($cols) VALUES ($placeholders)";
        
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute($data);
        
        return $this->pdo->lastInsertId();
    }

    // 2. READ (All): Mengambil semua data
    public function all($table) {
        $stmt = $this->pdo->query("SELECT * FROM $table");
        return $stmt->fetchAll();
    }

    // 3. UPDATE: Mengubah data
    public function update($table, $data, $id) {
        if (isset($data['stok']) && $data['stok'] < 0) {
            die("Error: Stok tidak boleh kurang dari 0!");
        }

        // Merakit string update (contoh: nama_produk=:nama_produk, stok=:stok)
        $setPart = [];
        foreach ($data as $key => $value) {
            $setPart[] = "$key = :$key";
        }
        $setString = implode(', ', $setPart);

        $sql = "UPDATE $table SET $setString WHERE id = :id";

        // Tambahkan ID ke dalam array data untuk binding
        $data['id'] = $id;

        $stmt = $this->pdo->prepare($sql);
        $stmt->execute($data);
    }

    // 4. DELETE: Menghapus data
    public function delete($table, $id) {
        $stmt = $this->pdo->prepare("DELETE FROM $table WHERE id = :id");
        $stmt->execute(['id' => $id]);
    }

    // 5    . SEARCH (Bonus): Mencari berdasarkan keyword
    public function search($table, $keyword) {
        $sql = "SELECT * FROM $table WHERE nama_produk LIKE :keyword OR kategori LIKE :keyword";
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute(['keyword' => "%$keyword%"]);
        return $stmt->fetchAll();
    }
}
?>

---

# ToDoList App – Laravel & Flutter

## Deskripsi Aplikasi

Aplikasi ini adalah sistem manajemen to-do list yang dikembangkan menggunakan Laravel versi 11 sebagai backend dan Flutter sebagai frontend. Setiap pengguna dapat melakukan registrasi akun dan memiliki daftar tugas pribadi.

Aplikasi ini menggunakan pendekatan microservices yang memisahkan frontend dan backend.

* **Backend:** Laravel menyediakan API RESTful untuk CRUD data to-do, registrasi, dan login menggunakan Laravel Sanctum sebagai pengaman token autentikasi.
* **Frontend:** Dibuat dengan Flutter untuk menampilkan dan mengelola to-do dari API.
* **Database:** MySQL digunakan sebagai basis data. Struktur tabel sudah tersedia dalam file migrasi Laravel, cukup menjalankan perintah migrasi.
* **API:** Flutter menggunakan REST API untuk berkomunikasi dengan server Laravel.

## Software yang Digunakan

* Laravel 11
* PHP 8.3 ke atas
* MySQL
* Flutter SDK
* Git dan Visual Studio Code (opsional)

## Cara Instalasi

### Backend (Laravel)

1. Clone repository dari GitHub.
2. Masuk ke folder backend Laravel.
3. Jalankan `composer install` untuk menginstal dependensi.
4. Salin file `.env.example` menjadi `.env`.
5. Ubah konfigurasi database pada file `.env` sesuai pengaturan lokal.
6. Jalankan `php artisan key:generate` untuk membuat application key.
7. Jalankan `php artisan migrate` untuk membuat tabel di database.
8. Jalankan server Laravel dengan `php artisan serve`.

### Frontend (Flutter)

1. Masuk ke folder proyek Flutter.
2. Jalankan `flutter pub get` untuk mengambil dependensi.
3. Jalankan aplikasi menggunakan `flutter run -d chrome --web-port=59106`.

Catatan: Jika menggunakan port yang berbeda dari 59106, pastikan menyesuaikan bagian `allowed_origins` pada file `config/cors.php` di Laravel. Jika tidak, bisa terjadi error CORS saat Flutter mengakses API.

## Cara Menjalankan Aplikasi

* Pastikan server Laravel berjalan terlebih dahulu agar API dapat diakses.
* Jalankan Flutter web untuk memulai aplikasi antarmuka.
* Flutter akan berkomunikasi dengan API Laravel secara langsung.

## Demo



https://github.com/user-attachments/assets/101f6744-bdff-42f0-91f1-72f7285f97a2



## Dibuat oleh

Lutfi Faisal Nur Arkarna/19/XI RPL 2

---

Jika kamu ingin versi satu halaman (one-page readme) atau versi bahasa Inggris juga, tinggal minta!

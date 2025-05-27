
# ToDoList Laravel-Flutter

---

## Deskripsi Aplikasi  
Aplikasi to do list ini dikembangkan dengan laravel 11 sebagai backend dan futter sebagai frontend. Aplikasi ini memiliki fitur CRUD Todolist dan dapat melakukan registrasi memungkinkan setiap akun memiliki list yang berbeda.
Aplikasi microservices untuk manajemen ToDoList yang terdiri dari:  
- **Backend:** Laravel service yang menyediakan API RESTful untuk CRUD ToDoList, registrasi pengguna, dan autentikasi. menggunkan laravel sanctum untuk menjaga keamanan API yang digunakan oleh laravel dan flutter.  
- **Frontend:** Flutter untuk menampilkan dan mengelola ToDoList dari backend.  
- **Database:** MySQL digunakan sebagai database penyimpanan data pengguna dan to-do. db sudah ada dalam file migration hanya perlu menjalankan "php artisan migrate" dalam folder laravel 11
- **API:** REST API pada Laravel yang digunakan Flutter untuk komunikasi data.

---

## Software yang Digunakan  
- Laravel 11  
- PHP 8.3 (disarankan diatas 8.2) 
- MySQL  
- Flutter SDK  
- Visual Studio Code (opsional)  
- Git  

---
## Cara Instalasi  

### Backend (Laravel)  
1. Clone repo  
   git clone https://github.com/daymouse/todolist-laravel-flutter_.git
   
3. Masuk ke folder laravel
   cd laravel_service

4. Install dependencies Laravel  
   composer install
  
5. Copy file environment  
   cp .env.example .env 
6. Sesuaikan konfigurasi database di `.env`  
7. Generate app key  
   php artisan key:generate

8. Jalankan migrasi database  (db sudah ada dalam file migration)
   php artisan migrate
  
9. Jalankan server Laravel  
   php artisan serve

### Frontend (Flutter)  
1. Masuk folder flutter app (sesuaikan path)  
3. Jalankan  
   flutter pub get
   
   flutter run -d chrome --web-port=59106
   
   (flutter akan berjalan sebagai fluter web dengan port 59106, jika anda ingin merubah port anda perlu merubah bagian 'allowed_origins' pada 'laravel_service\config\cors.php'.
   jika port berbeda akan terjadi XMLHttpRequest eror)

---

## Cara Menjalankan  
- Jalankan backend Laravel terlebih dahulu agar API aktif  
- Jalankan aplikasi Flutter yang akan berkomunikasi dengan API Laravel  

---

## Demo  



https://github.com/user-attachments/assets/2d793487-97d2-474d-a6a3-7ad6a458e514


---

## by Dzulfikar Lintang/8/XI RPL 2/05.2025

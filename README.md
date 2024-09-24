Penjelasan  Menu awal/home

1.	Impor Paket:

•	package:flutter/material.dart: Mengimpor widget Material Design dari Flutter.

•	package:tugas3/side_menu.dart: Mengimpor file side_menu.dart yang berisi widget SideMenu.

2.	Kelas HomePage:

•	StatelessWidget: Kelas ini tidak memiliki state yang berubah.

•	build(): Fungsi yang membangun UI halaman.

3.	Scaffold:

•	Struktur dasar halaman Flutter dengan AppBar (judul halaman) dan drawer (menu samping dari SideMenu).

•	Body: Teks "selamat datang" ditampilkan di tengah halaman.
 

Penjelasan  menu Login :

1.	Paket yang Diimpor

•	package:flutter/material.dart: Paket untuk menggunakan widget Material Design dari Flutter.

•	package:shared_preferences/shared_preferences.dart: Paket untuk menyimpan data kecil secara lokal di perangkat (dalam hal ini, untuk menyimpan username).

•	package:tugas3/home_page.dart: Mengimpor halaman HomePage yang akan ditampilkan setelah login berhasil.

2.	Kelas LoginPage

•	StatefulWidget: LoginPage adalah widget yang dapat berubah status (misalnya, setelah login berhasil).
 
•	_LoginPageState: Menyimpan state (keadaan) dari LoginPage, termasuk kontrol input dan penyimpanan username.

3.	_LoginPageState Components:

•	Controller Input: _usernameController dan _passwordController menangani teks yang dimasukkan ke field username dan password.

•	_buatInput(): Fungsi untuk membuat TextField dengan controller dan placeholder (hint).

4.	SharedPreferences

•	_saveUsername(): Menyimpan username ke penyimpanan lokal menggunakan SharedPreferences.

•	_loadUsername(): Memuat username yang disimpan dari penyimpanan lokal dan memperbarui tampilan dengan setState().

5.	Login Logic

•	Login Button: Memeriksa apakah username dan password yang dimasukkan benar (Lala dan LALA12345).

•	Jika Benar:

o	Username disimpan, lalu dimuat kembali untuk ditampilkan dalam dialog.

o	Menampilkan dialog "Berhasil Login" dengan username, dan ketika menekan "OK", pengguna diarahkan ke halaman HomePage.

•	Jika Salah: Menampilkan dialog "Login Gagal" dengan pesan kesalahan.

6.	Scaffold & Layout:

•	AppBar: Menampilkan judul "Login" di bagian atas halaman.

•	Body: Dua field input (username, password), dan tombol login ditampilkan di tengah layar.

Penjelasan menu Side menu:

1.	Paket yang Diimpor

•	package:flutter/material.dart: Digunakan untuk komponen UI berbasis Material Design di Flutter.
•	package:tugas3/home_page.dart: Mengimpor halaman HomePage yang akan ditampilkan saat pengguna memilih opsi "Home".
•	package:tugas3/list_data.dart: Mengimpor halaman ListData yang akan ditampilkan saat pengguna memilih opsi "Data Mahasiswa".

2.	Kelas SideMenu

•	StatelessWidget: SideMenu tidak memiliki state yang berubah, hanya bertanggung jawab menampilkan menu navigasi.
•	Drawer: Widget yang digunakan untuk membuat menu samping yang bisa digeser dari kiri layar.
•	ListView: Menampilkan daftar elemen menu.

3.	Drawer Components:
 
•	DrawerHeader: Menampilkan judul di bagian atas menu, yaitu "Menu Aplikasi".
•	ListTile: Item navigasi di dalam drawer. Ada dua ListTile di sini:
1.	Home: Mengarahkan ke HomePage.
2.	Data Mahasiswa: Mengarahkan ke ListData.

4.	Navigasi

•	Navigator.pushReplacement(): Mengganti halaman saat ini dengan halaman baru tanpa menambahkan halaman lama ke tumpukan navigasi. Ini memastikan bahwa pengguna tidak dapat kembali ke halaman sebelumnya menggunakan tombol back.
•	MaterialPageRoute: Membuat rute baru untuk halaman yang dituju, baik HomePage maupun ListData.

Screenshoot tampilan:
![Screenshot 2024-09-24 074340](https://github.com/user-attachments/assets/566f969d-de06-4881-87fe-233c8ede6534)
![Screenshot 2024-09-24 074511](https://github.com/user-attachments/assets/2924e377-f082-4ade-9a32-bcdec8d2161a)
![Screenshot 2024-09-24 074548](https://github.com/user-attachments/assets/19f1800e-02e4-4ecf-96f7-a87c81457c02)
![Screenshot 2024-09-24 074615](https://github.com/user-attachments/assets/9b7ece46-c525-40e7-9756-0768b002a452)
![Screenshot 2024-09-24 074628](https://github.com/user-attachments/assets/50736491-033a-44df-b6db-1cd8bdadb8f6)


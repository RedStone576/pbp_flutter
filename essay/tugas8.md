# Tugas 8

## Requirements
- Tugas 7
- Tutorial 9
- Tidak demam

## TL;DR

Forms, drawers, and navigator stacks. Welcome to mobile dev???

## Checklist

Halaman Formulir Baru
    - [X] Membuat halaman formulir baru dalam berkas Dart tersendiri di lib/screens/. Gunakan StatefulWidget, Form, dan GlobalKey<FormState>.
    - [X] Menyediakan minimal tiga input yang sesuai dengan model bagian portofolio yang dipilih. Gunakan widget input yang sesuai dengan tipe datanya. Misalnya, gunakan TextFormField untuk nama institusi atau showDatePicker() untuk tanggal jika model memiliki atribut tanggal.
    - [X] Memvalidasi setiap input sesuai aturan model. Tolak isian wajib yang kosong atau hanya berisi spasi. Periksa batas panjang, format URL, atau urutan tanggal jika aturan tersebut berlaku untuk input yang digunakan.
    - [X] Menggunakan Scaffold dan AppBar dengan tema yang konsisten dengan halaman utama. Susun formulir agar semua input dan tombol Simpan tetap dapat dijangkau pada layar sempit atau saat papan ketik tampil.
Navigasi dari Halaman Utama dan Drawer
    - [X] Menambahkan kartu aksi di halaman utama untuk membuka formulir baru menggunakan Navigator.push(). Setelah formulir dibuka dari kartu aksi, pengguna dapat kembali dengan tombol kembali bawaan perangkat jika tersedia.
    - [X] Menambahkan opsi untuk membuka formulir baru pada drawer dari Tutorial 09. Pertahankan opsi Home dan Add Project, lalu gunakan drawer yang sama di halaman formulir baru.
    - [X] Memastikan opsi baru di drawer membuka formulir yang sesuai dan opsi Home dari halaman formulir membawa pengguna ke halaman utama. Gunakan opsi Home untuk menguji alur kembali saat menjalankan aplikasi di Chrome.
Validasi dan Dialog Ringkasan
    - [X] Menyediakan tombol Simpan yang memanggil FormState.validate(). Jika ada input yang tidak valid, tampilkan pesan kesalahan pada kolom terkait.
    - [X] Menampilkan semua isian dalam AlertDialog melalui showDialog() hanya setelah seluruh input lolos validasi.
    - [X] Menyediakan tombol Tutup atau OK untuk menutup dialog dan kembali ke formulir.
Kualitas Kode dan Repositori
    - [X] Menguji akses formulir dari kartu dan drawer, penyimpanan dengan input valid dan tidak valid, serta navigasi kembali ke halaman utama.
    - [X] Menjalankan flutter analyze dari direktori utama proyek dan menyelesaikan temuan analisis.

## Pertanyaan

> 1. Jelaskan perbedaan antara `Navigator.push()`, `Navigator.pushReplacement()`, dan `Navigator.pop()`. Metode apa yang digunakan untuk membuka formulir dari kartu aksi? Jelaskan juga bagaimana opsi Home di drawer membawa pengguna kembali ke halaman utama.

- `Navigator.push()`: stacking route baru di atas stack navigasi
- `Navigator.pushReplacement()`: replace route yang sedang aktif sekarang dengan route baru
- `Navigator.pop()`: mengeluarkan route paling atas dari stack, kembali ke route persis di bawahnya

- `Navigator.push()`

- `Navigator.pushReplacement()` karena kita tidak mau men-stacking `MyHomePage` tanpa menghapus instance sebelumnya

> 2. Bagaimana susunan Scaffold, AppBar, dan Drawer membantu menjaga struktur halaman tetap konsisten? Berikan satu contoh penggunaan warna tema portofolio di lebih dari satu halaman.

`Scaffold` adalah basic structure-nya dengan material, `AppBar` itu headernya, dan `Drawer` itu sidebarn-ya. Ketiganya digunakan untuk layout widget lain sehingga seragam.

Ex: `Colors.indigo` digunakan sebagai background `AppBar` di semua halaman.

> 3. Mengapa tata letak tersebut dipilih untuk formulir? Jelaskan peran widget pengatur jarak dan widget penggulir ketika ruang layar terbatas.

Form menggunakan `Column` karena lebih mudah dibaca dan diisi top to bottom

- `Padding` dan `SizedBox`: mengatur jarak antar-widget 
- `SingleChildScrollView`: memungkinkan form scrolling ketika tidak muat di layar. Ex: saat keyboard muncul

> 4. Apa peran GlobalKey<FormState>, validator, dan validate() saat tombol Simpan ditekan? Berikan satu contoh nilai yang ditolak oleh validasi dan jelaskan mengapa memilih jenis input atau papan ketik saja belum cukup.

- GlobalKey<FormState>: access form state
- validator: validate input
- validate(): run validator
- Ex: `"    "` ditolak karena akan menjadi string kosong setelah trim().

Karena user bisa copas / dibiarkan kosong.

## Referensi
- https://docs.flutter.dev/learn
- https://docs.flutter.dev/ui/navigation
- https://docs.flutter.dev/ui/widgets/material

## AI Disclosure

AI:R (code auditing di `./lib/screens/*.dart` dengan Gemini 3.8-flash di Agy CLI); https://0rwx.com/

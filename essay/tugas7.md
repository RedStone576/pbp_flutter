# Tugas 7

## Requirements
- Tugas 6
- Tutorial 8
- Bisa meng-install Dart dan Flutter di Red Hat-based distro walaupun tutorial hanya menyediakan langkah instalasi di Debian

## TL;DR

I guess we're doing Dart now

## Development Setup

### Meng-install Dart dan Flutter di RPM-based Linux distro (Fedora, RHEL, Rocky, Alma, etc.); Debian tidak diundang.

Buat sebuah directory untuk menyimpan runtime Dart dan Flutter, dan mungkin runtime lainnya (PHP, Go, Haskell, etc.), saya sarankan di `~/Dev/.runtimes/`.
```sh
λ cd ~
λ mkdir Dev
λ cd Dev
λ mkdir .runtimes
λ cd .runtimes
```

Pastikan packages berikut ada pada sistem yang sedang dijalankan:
- git
- zip
- curl
- unzip
- xz-utils
- libglu1-mesa
- chrome

Download tarball runtime Dart dan Flutter untuk Linux: 
https://docs.flutter.dev/install/manual#install-flutter

Ekstrak tarball tersebut
```sh
λ tar -xf ~/Downloads/flutter_linux_3.50.0-stable.tar.xz -C ~/Dev/.runtimes/
```

atau gunakan GUI dari file manager yang tersedia.

Tambahkan Flutter ke PATH

```sh
# zsh
λ echo 'export PATH="$HOME/Dev/.runtimes/flutter_linux_3.50.0-stable/bin:$PATH"' >> ~/.zshenv
# bash 
λ echo 'export PATH="$HOME/Dev/.runtimes/flutter_linux_3.50.0-stable/bin:$PATH"' >> ~/.bashrc

# Selain bash dan zsh juga shell-shell yang non-POSIX tidak diundang.
# Terutama Fish.
```

Check instalasi
```sh
λ flutter --version
λ dart --version
λ flutter doctor
```

### Clone repository ini ke local

```sh
λ git clone https://github.com/RedStone576/pbp_flutter.git
λ cd pbp_flutter
```

### Jalankan development build untuk web
```sh
λ flutter run -d chrome
```

### Build untuk web
```sh
λ flutter build web
```

Maka akan terbuat `./build/web/` dengan (mungkin js mungkin wasm) binaries untuk deployment web.


## Checklist

- [X] **Setup dan Inisialisasi Proyek:**
    - [X] Melanjutkan proyek Flutter `myportofolio_mobile` yang kamu buat pada Tutorial 08.
    - [X] Memisahkan kode widget halaman utama ke dalam berkas terpisah, yaitu menu.dart di dalam folder lib/, terpisah dari berkas bootstrap `main.dart`.
    - [X] Mengubah sifat widget halaman menu utama (`MyHomePage`) menjadi `StatelessWidget`.
- [X] **Informasi Profil Pemilik Portofolio (`InfoCard`):**
    - [X] Menampilkan 3 kartu informasi (`InfoCard`) di bagian atas halaman yang memuat identitas kamu sendiri secara akurat (bukan data contoh Burhan):
    - [X] Kartu NPM: menampilkan NPM kamu.
    - [X] Kartu Name: menampilkan nama lengkap kamu.
    - [X] Kartu Class: menampilkan kelas PBP kamu.
- [X] **Menu Aksi Portofolio (`ItemCard`) & Kustomisasi Warna:**
    - [X] Membuat minimal 3 tombol aksi sederhana dalam bentuk kartu (`ItemCard`) dengan ikon dan teks yang relevan untuk portofolio kamu, misalnya:
    - [X] Tombol untuk melihat daftar item portofolio (misalnya `Lihat Portofolio`, `Lihat Proyek`, atau bagian pilihan kamu seperti `Lihat Education` / `Lihat Skills`).
    - [X] Tombol untuk menambah item portofolio (misalnya `Tambah Proyek` atau `Tambah Item`).
    - [X] Tombol `Logout`.
- [X] **Mengimplementasikan warna latar (background color) yang berbeda untuk setiap tombol aksi:**
    - [X] Setiap tombol memiliki warna yang unik dan kontras satu sama lain (misalnya: tombol pertama berwarna biru, tombol kedua berwarna hijau, dan tombol ketiga berwarna merah atau oranye).
    - [X] Memunculkan `SnackBar` saat tombol ditekan dengan pesan yang interaktif dan sesuai dengan nama tombol yang ditekan:
    - [X] Menampilkan tulisan “Kamu telah menekan tombol [Nama Tombol]!” ketika tombol terkait ditekan.
- [X] **Kualitas Kode & Analisis:**
    - [X] Memastikan tidak ada isu atau kesalahan pada kode dengan menjalankan perintah flutter analyze pada root folder proyek (No issues found).
- [X] **Repositori Git:**
    - [X] Menyimpan proyek di repositori GitHub publik yang sama dengan Tutorial 08, terpisah dari repositori Django.
    - [X] Melakukan commit dan push secara bertahap untuk setiap perubahan.

## Pertanyaan

> 1. Jelaskan apa yang dimaksud dengan widget tree pada Flutter dan bagaimana hubungan induk-anak (parent-child) bekerja antar-widget!

Widget tree adalah struktur kontainer yang menyatakan hubungan antar-widget dalam Flutter. Setiap widget dapat memiliki widget lain sebagai children. Widget parent mengatur bagaimana widget children disusun dan di-display.

> 2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya masing-masing!

- `MaterialApp`: config tema
- `Scaffold`: struktur dasar halaman
- `AppBar`: menampilkan header aplikasi
- `Text`: menampilkan teks
- `Column` dan `Row`: menyusun widget secara vertikal dan horizontal
- `Container` dan `Padding`: mengatur ukuran, jarak, dan tampilan
- `Card`: menampilkan kartu informasi
- `GridView.count`: menampilkan menu dalam bentuk... ya, grid
- `Center`: memposisikan widget di tengah
- `SizedBox`: memberi jarak
- `Icon`: menampilkan ikon
- `Material` dan `InkWell`: kartu interaktif ketika ditekan
- `SnackBar`: menampilkan pesan sementara di bawah layar

> 3. Apa fungsi dari widget `MaterialApp`? Jelaskan mengapa widget ini umumnya digunakan sebagai root widget pada aplikasi Flutter!

struktur dan "konfigurasi" dasar app, digunakan agar widget yang dibawahinya akan mengikuti design language yang sama.

> 4. Jelaskan perbedaan antara `StatelessWidget` dan `StatefulWidget`! Kapan kita sebaiknya memilih `StatelessWidget` dan kapan harus menggunakan `StatefulWidget`?

- `StatelessWidget`: widget tanpa internal state
- `StatefulWidget`: wiget dengan internal state

`StatelessWidget` digunakan untuk component statis, sedangkan `StatefulWidget` digunakan untuk komponen interaktif (ex: button).

> 5. Apa itu `BuildContext` dan mengapa penting di Flutter? Bagaimana penggunaannya di dalam metode `build`?

`BuildContext` adalah referensi posisi sebuah widget dalam tree-nya widget. Context digunakan untuk mem-fetch informasi seperti tema dan navigasi.

> 6. Jelaskan konsep hot reload di Flutter dan apa perbedaannya dengan hot restart! Kapan kita tidak bisa hanya mengandalkan hot reload dan harus melakukan hot restart atau full restart?

- Hot Reload: memperbarui kode dan tampilan tetapi mem-preserve state yang sedang digunakan.
- Hot Restart: memulai ulang aplikasi dari awal.

Ketika semua state perlu kembali ke initial value mereka. Full restart bila config keseluruhan codebase berubah.

## Referensi
- https://docs.flutter.dev/learn

## AI Disclosure

AI:0; https://0rwx.com/

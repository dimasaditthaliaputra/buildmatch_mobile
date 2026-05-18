# BuildMatch 🏗️

> Platform Marketplace Jasa Konstruksi & Desain Bangunan Terintegrasi

## 📖 Project Overview
BuildMatch adalah sebuah platform inovatif yang dirancang untuk mempertemukan klien dengan arsitek dan kontraktor profesional secara transparan, aman, dan efisien. Aplikasi ini memberikan solusi atas permasalahan umum dalam industri konstruksi, seperti kurangnya transparansi perkembangan (progres) proyek, miskomunikasi antara tahap desain dan eksekusi fisik, serta kebutuhan akan keamanan transaksi finansial. BuildMatch memfasilitasi komunikasi yang lancar, pemantauan proyek real-time, dan sistem pembayaran yang terintegrasi (berbasis tahap/milestone) untuk memastikan keberhasilan setiap tahap pembangunan properti.

## ✨ Fitur Utama & Aktor
Sistem BuildMatch melibatkan empat aktor utama, dengan masing-masing peran dan fitur yang disesuaikan dengan Spesifikasi Kebutuhan Perangkat Lunak (SKPL):

### 1. Klien (Client)
Aktor yang membutuhkan jasa perancangan desain gedung atau pembangunan fisik.
- **Manajemen Proyek:** Membuat proyek baru dengan spesifikasi detail (lokasi, luas tanah/bangunan, tipe rumah, budget) atau mengunggah draf desain mandiri.
- **Konsultasi & Persetujuan:** Melakukan konsultasi opsional, meninjau hasil desain/penawaran, serta memberikan persetujuan (approval) resmi ke dalam sistem.
- **Transaksi & Pemantauan:** Melakukan pembayaran uang muka (DP) dan pembayaran termin berbasis milestone pengerjaan. Memantau perkembangan proyek secara visual dan real-time.
- **Ulasan:** Memberikan rating dan ulasan objektif kepada arsitek atau kontraktor setelah proyek diselesaikan.

### 2. Arsitek (Architect)
Profesional yang menyediakan layanan perancangan desain bangunan dan konsultasi.
- **Profil Profesional:** Mengelola profil, keahlian/spesialisasi, serta portofolio desain.
- **Penawaran & Iterasi:** Menerima permintaan konsultasi, mengirimkan proposal penawaran (harga & estimasi waktu), dan melakukan iterasi revisi cetak biru (blueprint) hingga disetujui klien.
- **Reputasi:** Memberikan ulasan balik kepada klien untuk menjaga kualitas komunitas platform.

### 3. Kontraktor (Contractor)
Penyedia jasa (badan usaha) yang bertanggung jawab mengeksekusi konstruksi fisik di lapangan.
- **Verifikasi Legalitas:** Wajib mendaftar menggunakan akun perusahaan dan melampirkan dokumen legalitas (NPWP Perusahaan, NIB) untuk diverifikasi sistem.
- **Bidding & Perencanaan:** Mengajukan proposal (bidding) pada lowongan proyek klien, dan menyusun perencanaan milestone pengerjaan beserta nilai termin pembayarannya.
- **Manajemen Progres:** Melaporkan kemajuan fisik per tahap dengan mengunggah foto, deskripsi, serta validasi lokasi (otomatisasi koordinat GPS/watermark).
- **Reputasi:** Memberikan rating dan ulasan balik terhadap klien.

### 4. Admin
Pengelola sistem sentral (Web Portal) yang menjaga integritas platform dan keamanan transaksi seluruh aktor.
- **Verifikasi & Audit:** Meninjau keabsahan dokumen legalitas kontraktor serta memvalidasi proyek yang dibuat klien.
- **Sistem Escrow:** Bertindak sebagai penengah transaksi (Escrow Service). Menampung dana klien dengan aman dan melepaskan (release payout) kepada mitra pekerja hanya setelah tahapan progres tervalidasi.
- **Manajemen Sengketa (Dispute):** Menengahi perselisihan antara klien dan pekerja, serta memproses pengembalian dana (refund) berdasarkan bukti visual dan log komunikasi (audit trail chat).
- **Pengawasan & Platform Fee:** Memberikan sanksi pembekuan akun bagi pelanggar ketentuan, dan mengelola pendapatan dari potongan biaya layanan (platform fee 5.0%).

## 🏗️ Teknologi & Arsitektur
Aplikasi BuildMatch dikembangkan menggunakan pendekatan **Feature-First Clean Architecture**, yang memisahkan kode fitur untuk memudahkan skalabilitas tim dan perawatan aplikasi.

### Arsitektur Utama
Aplikasi ini dipecah ke dalam 3 layer utama:
- **Presentation Layer:** Berisi UI (Pages, Screens, Widgets) dan State Management.
- **Domain Layer:** Berisi Business Logic (Entities, Usecases, dan Repositories Interface).
- **Data Layer:** Berisi Data Sources (Remote/Local), Models (DTOs), dan implementasi dari Repository.

### Teknologi Inti (Tech Stack)
- **Framework Aplikasi:** Flutter (Mendukung Platform Target iOS & Android).
- **Dependency Injection:** `get_it` (Diinisialisasi secara terpusat pada `lib/config/injection_container.dart`).
- **Routing:** `go_router` (Dikelola secara terpusat di `lib/core/routes/app_router.dart`).
- **Backend & Database:** PostgreSQL terpusat yang dikelola melalui **Supabase** (menangani autentikasi, penyimpanan data, dan real-time synchronization).
- **Payment Gateway:** Integrasi API (seperti Midtrans) untuk memfasilitasi sistem pembayaran bertahap dan escrow.
- **Notifikasi:** Push Notifications menggunakan Firebase / Local Notifications.

## ⚙️ Panduan Instalasi (Getting Started)
Ikuti panduan berikut untuk menjalankan source code proyek BuildMatch secara lokal di environment Anda.

### Prasyarat (Prerequisites)
Pastikan perangkat lunak berikut telah terinstal pada mesin Anda:
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (versi stable terbaru direkomendasikan).
- [Dart SDK](https://dart.dev/get-dart).
- IDE (Misal: [Visual Studio Code](https://code.visualstudio.com/) atau [Android Studio](https://developer.android.com/studio)).
- Emulator Android / Simulator iOS, atau perangkat fisik yang sudah mengaktifkan USB Debugging.
- Project aktif di Supabase untuk sinkronisasi Database.

### Langkah-langkah Instalasi

1. **Kloning Repositori**
   Buka terminal atau command prompt, lalu clone proyek aplikasi ke direktori pilihan Anda:
   ```bash
   git clone <URL_REPOSITORY_ANDA>
   cd buildmatch_mobile
   ```

2. **Unduh Dependensi (Dependencies)**
   Jalankan perintah berikut untuk mengunduh seluruh library yang didefinisikan pada `pubspec.yaml`:
   ```bash
   flutter pub get
   ```

3. **Konfigurasi Lingkungan (Supabase Configuration)**
   Aplikasi ini membutuhkan integrasi dengan Supabase. Masukkan URL dan Anon Key Supabase Anda. Apabila dikelola via `lib/core/constants/supabase_constants.dart`, perbarui file tersebut:
   ```dart
   // Contoh file lib/core/constants/supabase_constants.dart
   const String supabaseUrl = 'URL_PROYEK_SUPABASE_ANDA';
   const String supabaseAnonKey = 'ANON_KEY_SUPABASE_ANDA';
   ```
   *(Pastikan kredensial sesungguhnya tidak terunggah ke version control seperti GitHub)*

4. **Jalankan Aplikasi**
   Pastikan Anda terhubung dengan internet yang stabil, mengingat aplikasi bergantung pada layanan cloud Supabase. Untuk menjalankan aplikasi, ketikkan perintah:
   ```bash
   flutter run
   ```

## 🚧 Batasan Sistem (System Boundaries)
Berdasarkan dokumen spesifikasi awal, ruang lingkup implementasi dan batasan sistem adalah sebagai berikut:
1. **Peran Penghubung Platform:** Aplikasi hanya berperan sebagai platform media penghubung, pemantauan, dan manajemen dana escrow. Eksekusi konstruksi fisik sepenuhnya di luar sistem aplikasi dan sepenuhnya menjadi tanggung jawab pihak kontraktor pelaksana.
2. **Ruang Lingkup Material:** Sistem berfokus secara ketat pada manajemen jasa desain dan proses pembangunan properti. Pengadaan komoditas terpisah, belanja, atau layanan pengiriman material konstruksi mandiri tidak didukung di dalam sistem ini.
3. **Cakupan Wilayah Geografis:** Demi menjaga kesesuaian dengan regulasi, standarisasi bangunan lokal, serta kemampuan verifikasi legalitas, layanan pengajuan proyek klien dan jangkauan pengerjaan arsitek/kontraktor saat ini dibatasi hanya pada **wilayah hukum Indonesia**.

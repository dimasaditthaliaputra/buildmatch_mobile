# BuildMatch - Model Context Protocol (MCP) / Project Architecture

Dokumen ini berisi informasi konteks dari project aplikasi mobile **BuildMatch** untuk membantu AI Agents atau developer baru memahami arsitektur, struktur folder, dan standar koding yang diterapkan pada project ini.

## 1. Arsitektur Utama
Aplikasi ini menggunakan pendekatan **Feature-First Clean Architecture**. Setiap fitur utama diisolasi dalam foldernya masing-masing dan dipecah ke dalam 3 layer utama:
- **Presentation Layer**: Berisi UI (Pages, Screens, Widgets) dan State Management.
- **Domain Layer**: Berisi Business Logic (Entities, Usecases, dan Repositories Interface).
- **Data Layer**: Berisi Data Sources (Remote/Local), Models (DTOs), dan implementasi dari Repository.

### Teknologi Inti
- **Framework**: Flutter
- **Dependency Injection**: `get_it` (diinisialisasi pada `lib/config/injection_container.dart`)
- **Routing**: `go_router` (dikelola di `lib/core/routes/app_router.dart`)
- **Backend Service (BaaS)**: Supabase
- **Push Notifications**: Firebase/Local Notifications (via `push_notification_service.dart`)

---

## 2. Struktur Folder (`lib/`)
```text
lib/
├── app.dart                   # Entry point konfigurasi MaterialApp, Theme, dan Router
├── main.dart                  # Entry point utama (inisialisasi Supabase, DI, dan Run App)
├── config/                    
│   └── injection_container.dart # Setup Dependensi Injection untuk meregistrasi service & usecase
├── core/                      # Modul inti (Shared logic, UI, utils yang digunakan lintas fitur)
│   ├── constants/             # Konstanta global (Supabase config, App string)
│   ├── error/                 # Definisi Exception dan Failure standar
│   ├── network/               # Utils cek koneksi internet (NetworkInfo)
│   ├── routes/                # Pengaturan rute aplikasi
│   ├── theme/                 # Konfigurasi gaya (Warna, Typography, ThemeData)
│   ├── utils/                 # Class bantuan (Validator, Formatter)
│   └── widgets/               # Komponen UI global/reusable
├── features/                  # Modul fitur-fitur aplikasi (Clean Architecture)
│   ├── auth/                  # Otentikasi (Login, Register, OTP, Pilih Role)
│   ├── client/                # Layanan Klien
│   ├── home/                  # Layanan Home/Dashboard
│   ├── notification/          # Daftar Notifikasi
│   ├── onboarding/            # Layanan Onboarding user baru
│   └── splash/                # Splash screen awal aplikasi
└── services/                  # Pembungkus (wrapper) untuk layanan pihak ke-3
    ├── local_storage_service.dart
    ├── push_notification_service.dart
    └── supabase_service.dart
```

---

## 3. Komponen Penting pada `core/`

Folder `core/` adalah tulang punggung dari aplikasi yang menyimpan semua elemen lintas fitur agar tidak terjadi pengulangan kode (DRY).

1. **`core/constants/` (Konstanta Global)**
   - `app_constants.dart`: Menyimpan konfigurasi konstan aplikasi.
     - `appName`: 'BuildMatch'
     - `defaultPageSize`: 20
     - `requestTimeout`: 30 detik
   - `supabase_constants.dart`: Menyimpan URL dan Anon Key Supabase.

2. **`core/theme/` (Desain Sistem)**
   - `app_colors.dart`: Daftar palet warna standar aplikasi. Selalu gunakan warna dari sini untuk konsistensi.
   - `app_text_styles.dart`: Daftar style tipografi (ukuran font, ketebalan) yang mengacu pada desain sistem.
   - `app_theme.dart`: Menyatukan warna dan font ke dalam `ThemeData` untuk `MaterialApp`.

3. **`core/routes/` (Routing)**
   - `app_router.dart`: Sentralisasi navigasi menggunakan `go_router`. Semua path rute dan pengalihan (redirection) didaftarkan di dalam file ini.

4. **`core/utils/` (Utilitas Ekstra)**
   - `validators.dart`: Fungsi-fungsi validasi input form (seperti email, password, empty check).
   - `date_formatter.dart`: Standarisasi konversi/format tanggal (DateTime ke String atau sebaliknya).
   - `screen_size.dart`: Utils pendukung responsivitas layar (mendapatkan width/height device).

5. **`core/widgets/` (Reusable UI Components)**
   - `main_button.dart`: Tombol utama aplikasi dengan loading state dan styling standar.
   - `logo.dart`: Widget logo aplikasi.
   - `global_background.dart`: Background dasar aplikasi agar UI seragam di semua layar.
   - `circle_button.dart`: Tombol melingkar untuk icon atau aksi sederhana.

6. **`core/error/` (Penanganan Error)**
   - `failures.dart`: Representasi error pada layer Domain yang bersifat user-friendly.
   - `exceptions.dart`: Representasi error mentah dari pemanggilan API (Data layer).

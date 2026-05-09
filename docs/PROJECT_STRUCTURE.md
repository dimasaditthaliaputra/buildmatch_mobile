# 📂 BuildMatch Mobile — Panduan Struktur Direktori `/lib`

> **Audiens:** AI Assistant (LLM), Anggota Tim Baru, Developer  
> **Project:** BuildMatch Mobile (Flutter)  
> **Terakhir Diperbarui:** 2026-05-05

---

## 🗺️ Tree Graph — Struktur Direktori `/lib`

```
lib/
├── main.dart                          # Entry point aplikasi
├── app.dart                           # Root widget (MaterialApp.router)
│
├── config/
│   └── injection_container.dart       # Dependency Injection (GetIt)
│
├── core/
│   ├── constants/
│   │   ├── app_constants.dart         # Konstanta umum aplikasi
│   │   └── supabase_constants.dart    # Konstanta Supabase (table names, dll.)
│   │
│   ├── error/
│   │   ├── exceptions.dart            # Custom exception classes
│   │   └── failures.dart              # Failure classes (Either pattern)
│   │
│   ├── network/
│   │   └── network_info.dart          # Abstraksi pengecekan koneksi internet
│   │
│   ├── routes/
│   │   └── app_router.dart            # Konfigurasi routing (GoRouter)
│   │
│   ├── theme/
│   │   ├── app_colors.dart            # Palet warna global
│   │   ├── app_text_styles.dart       # Definisi typography global
│   │   └── app_theme.dart             # ThemeData light/dark
│   │
│   ├── utils/
│   │   ├── date_formatter.dart        # Helper pemformatan tanggal
│   │   ├── screen_size.dart           # Helper ukuran layar
│   │   └── validators.dart            # Fungsi validasi form
│   │
│   └── widgets/
│       ├── circle_button.dart         # Tombol bulat reusable
│       ├── global_background.dart     # Widget latar belakang global
│       ├── logo.dart                  # Widget logo aplikasi
│       └── main_button.dart           # Tombol utama reusable
│
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   ├── auth_local_data_source.dart
│   │   │   │   └── auth_remote_data_source.dart
│   │   │   ├── models/
│   │   │   │   └── user_model.dart
│   │   │   └── repositories/
│   │   │       └── auth_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── user_entity.dart
│   │   │   ├── repositories/
│   │   │   │   └── auth_repository.dart
│   │   │   └── usecases/
│   │   │       ├── login_usecase.dart
│   │   │       ├── logout_usecase.dart
│   │   │       └── register_usecase.dart
│   │   └── presentation/
│   │       ├── bloc/
│   │       │   ├── auth_bloc.dart
│   │       │   ├── auth_event.dart
│   │       │   └── auth_state.dart
│   │       ├── pages/
│   │       │   ├── login_page.dart
│   │       │   └── choose_roles.dart
│   │       └── widgets/
│   │           ├── auth_form_field.dart
│   │           ├── email_login_form_view.dart
│   │           ├── login_options_view.dart
│   │           └── register_form_view.dart
│   │
│   ├── client/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── home_remote_data_source.dart
│   │   │   └── repositories/
│   │   │       └── home_repository_impl.dart
│   │   ├── domain/
│   │   │   └── repositories/
│   │   │       └── home_repository.dart
│   │   └── presentation/
│   │       └── pages/
│   │           └── home_page.dart
│   │
│   ├── home/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── home_remote_data_source.dart
│   │   │   └── repositories/
│   │   │       └── home_repository_impl.dart
│   │   ├── domain/
│   │   │   └── repositories/
│   │   │       └── home_repository.dart
│   │   └── presentation/
│   │       └── pages/
│   │           └── home_page.dart
│   │
│   ├── notification/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── notification_remote_data_source.dart
│   │   │   ├── models/
│   │   │   │   └── notification_model.dart
│   │   │   └── repositories/
│   │   │       └── notification_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── notification_entity.dart
│   │   │   ├── repositories/
│   │   │   │   └── notification_repository.dart
│   │   │   └── usecases/
│   │   │       └── get_notifications_usecase.dart
│   │   └── presentation/
│   │       └── pages/
│   │           └── notification_page.dart
│   │
│   ├── onboarding/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── onboarding_local_data_source.dart
│   │   │   └── repositories/
│   │   │       └── onboarding_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── onboarding_entity.dart
│   │   │   ├── repositories/
│   │   │   │   └── onboarding_repository.dart
│   │   │   └── usecases/
│   │   │       └── get_onboarding_pages.dart
│   │   └── presentation/
│   │       ├── bloc/
│   │       │   ├── onboarding_bloc.dart
│   │       │   ├── onboarding_event.dart
│   │       │   └── onboarding_state.dart
│   │       └── pages/
│   │           └── onboarding_page.dart
│   │
│   └── splash/
│       └── presentation/
│           └── pages/
│               └── splash_page.dart
│
└── services/
    ├── local_storage_service.dart     # Abstraksi penyimpanan lokal
    ├── push_notification_service.dart # Inisialisasi push notification (FCM)
    └── supabase_service.dart          # Inisialisasi koneksi Supabase
```

---

## 🏛️ Filosofi Foldering — Clean Architecture + Feature-First

Proyek ini mengadopsi **dua prinsip arsitektur secara bersamaan:**

### 1. Feature-First (Horizontal Slicing)
Setiap fitur produk (auth, onboarding, home, dll.) dikelompokkan dalam satu folder tersendiri di bawah `features/`. Pendekatan ini memudahkan tim untuk:
- **Menemukan kode** berdasarkan domain bisnis, bukan berdasarkan tipe file.
- **Mengembangkan fitur secara paralel** tanpa konflik antar developer.
- **Menghapus atau mengarsipkan fitur** dengan mudah tanpa mengubah bagian lain.

### 2. Clean Architecture (Vertical Layering)
Di dalam setiap fitur, terdapat tiga lapisan yang dipisahkan secara ketat:

```
Feature
  ├── data/         ← Lapisan paling luar: sumber data eksternal
  ├── domain/       ← Inti bisnis: murni Dart, tanpa dependensi Flutter
  └── presentation/ ← Tampilan: UI + state management (BLoC)
```

**Aturan ketergantungan (Dependency Rule):**
> Lapisan dalam **tidak boleh** mengetahui lapisan luar.
> `domain` tidak mengimpor dari `data` atau `presentation`.

```
presentation  →  domain  ←  data
```

### 3. Separation of Concerns Global
Kode yang bersifat **cross-feature** (dipakai lebih dari satu fitur) diletakkan di:
- `core/` — Utilitas, tema, routing, penanganan error
- `services/` — Inisialisasi platform (Supabase, FCM, local storage)
- `config/` — Dependency injection (GetIt)

---

## 📁 Directory Breakdown — Penjelasan Detail

### `lib/main.dart`
Entry point aplikasi. Bertanggung jawab untuk:
- Menginisialisasi binding Flutter (`WidgetsFlutterBinding.ensureInitialized`)
- Menginisialisasi layanan platform: `SupabaseService`, `PushNotificationService`
- Memanggil `di.init()` untuk mendaftarkan seluruh dependensi
- Menjalankan `App()` sebagai root widget

> ⚠️ **Jangan tambahkan logika bisnis di sini.** File ini hanya boleh berisi inisialisasi dan bootstrap.

---

### `lib/app.dart`
Root widget yang membungkus `MaterialApp.router`. Bertanggung jawab untuk:
- Menyediakan `AppTheme.lightTheme` sebagai tema global
- Menghubungkan `AppRouter.router` (GoRouter) ke aplikasi
- Menjadi titik komposisi Provider/BLoC global jika diperlukan

---

### `lib/config/`
| File | Fungsi |
|---|---|
| `injection_container.dart` | Mendaftarkan semua dependensi menggunakan `GetIt`. Ini adalah **Service Locator** yang menjadi satu-satunya tempat instansiasi kelas konkret. |

> 📌 **Setiap kali menambahkan fitur baru**, pastikan BLoC, UseCase, Repository, dan DataSource fitur tersebut didaftarkan di sini.

---

### `lib/core/`
Berisi kode yang **digunakan secara lintas fitur**. Tidak ada logika bisnis domain-spesifik di sini.

#### `core/constants/`
Menyimpan nilai-nilai tetap (magic strings, konfigurasi statis).

| File | Isi |
|---|---|
| `app_constants.dart` | Konstanta umum (nama app, durasi animasi, dsb.) |
| `supabase_constants.dart` | Nama tabel, bucket, atau key Supabase |

#### `core/error/`
Mekanisme penanganan error menggunakan pola **Either**.

| File | Isi |
|---|---|
| `exceptions.dart` | Custom exception yang dilempar oleh lapisan `data` |
| `failures.dart` | `Failure` class yang dikembalikan oleh lapisan `domain` ke `presentation` |

> **Aturan:** Lapisan `data` melempar `Exception`. Lapisan `domain` menangkap dan mengubahnya menjadi `Failure`.

#### `core/network/`
| File | Isi |
|---|---|
| `network_info.dart` | Interface dan implementasi untuk mengecek status koneksi internet menggunakan `connectivity_plus` |

#### `core/routes/`
| File | Isi |
|---|---|
| `app_router.dart` | Definisi seluruh rute aplikasi menggunakan `GoRouter`. Semua rute baru harus didaftarkan di sini. |

**Daftar rute yang ada:**
| Path | Name | Halaman |
|---|---|---|
| `/splash` | `splash` | `SplashScreen` |
| `/onboarding` | `onboarding` | `OnboardingPage` |
| `/auth` | `auth` | `AuthPage` |
| `/choose-roles` | `choose-roles` | `ChooseRolesPage` |
| `/home` | `home` | `HomePage` |

#### `core/theme/`
Satu sumber kebenaran (*single source of truth*) untuk seluruh tampilan visual.

| File | Isi |
|---|---|
| `app_colors.dart` | Seluruh palet warna (primary, secondary, neutral, error, dsb.) |
| `app_text_styles.dart` | Definisi `TextStyle` untuk heading, body, caption, dsb. |
| `app_theme.dart` | `ThemeData` untuk light mode (dan dark mode jika ada) |

> ⚠️ **Jangan gunakan warna atau ukuran font hardcoded** di dalam widget. Selalu referensikan dari `AppColors` atau `AppTextStyles`.

#### `core/utils/`
Fungsi-fungsi *stateless* pembantu yang bisa dipanggil dari mana saja.

| File | Fungsi |
|---|---|
| `date_formatter.dart` | Memformat objek `DateTime` menjadi string yang ramah pengguna |
| `screen_size.dart` | Mengambil dimensi layar (width, height) dengan mudah |
| `validators.dart` | Fungsi validasi form (email, password, dll.) |

#### `core/widgets/`
Komponen UI yang **generik dan reusable** di seluruh fitur.

| File | Widget |
|---|---|
| `circle_button.dart` | Tombol berbentuk lingkaran (biasanya untuk aksi ikon) |
| `global_background.dart` | Widget latar belakang dekoratif yang dipakai di banyak halaman |
| `logo.dart` | Widget logo BuildMatch |
| `main_button.dart` | Tombol CTA utama dengan style yang konsisten |

> 📌 Jika sebuah widget dipakai di **lebih dari satu fitur**, pindahkan ke sini.

---

### `lib/features/`
Inti dari aplikasi. Setiap sub-folder merepresentasikan **satu fitur produk** yang mandiri.

#### Anatomi Standar Setiap Fitur

```
feature_name/
  ├── data/
  │   ├── datasources/     ← Komunikasi dengan API/DB/LocalStorage
  │   ├── models/          ← DTO: serialisasi/deserialisasi JSON
  │   └── repositories/    ← Implementasi konkret dari kontrak domain
  │
  ├── domain/
  │   ├── entities/        ← Objek bisnis murni (plain Dart class)
  │   ├── repositories/    ← Kontrak/interface repository (abstrak)
  │   └── usecases/        ← Satu use case = satu aksi bisnis
  │
  └── presentation/
      ├── bloc/            ← State management (Event, State, Bloc)
      ├── pages/           ← Halaman penuh (Screen/Page)
      └── widgets/         ← Widget spesifik fitur ini (bukan reusable global)
```

---

#### `features/auth/`
Mengelola seluruh alur autentikasi pengguna.

| Lapisan | File Utama | Keterangan |
|---|---|---|
| **data** | `auth_remote_data_source.dart` | Komunikasi login/register ke Supabase Auth |
| **data** | `auth_local_data_source.dart` | Menyimpan/membaca sesi dari storage lokal |
| **data** | `user_model.dart` | DTO User dengan `fromJson`/`toJson` |
| **domain** | `user_entity.dart` | Entitas User murni (tanpa logika serialisasi) |
| **domain** | `auth_repository.dart` | Interface: `login()`, `register()`, `logout()` |
| **domain** | `login_usecase.dart` | Eksekusi alur login |
| **domain** | `register_usecase.dart` | Eksekusi alur registrasi |
| **domain** | `logout_usecase.dart` | Eksekusi alur logout |
| **presentation** | `auth_bloc.dart` | State management untuk auth flow |
| **presentation** | `login_page.dart` | Halaman login (container page) |
| **presentation** | `choose_roles.dart` | Halaman pemilihan peran pengguna |
| **presentation** | `email_login_form_view.dart` | View form login dengan email |
| **presentation** | `register_form_view.dart` | View form registrasi |
| **presentation** | `login_options_view.dart` | View pilihan metode login |

---

#### `features/onboarding/`
Mengelola tampilan pengenalan aplikasi (onboarding carousel) untuk pengguna baru.

| Lapisan | File Utama | Keterangan |
|---|---|---|
| **data** | `onboarding_local_data_source.dart` | Membaca data slide onboarding dan status "sudah ditampilkan" dari local storage |
| **domain** | `onboarding_entity.dart` | Entitas yang merepresentasikan satu slide onboarding |
| **domain** | `get_onboarding_pages.dart` | Use case: ambil daftar halaman onboarding |
| **presentation** | `onboarding_bloc.dart` | Mengelola state (halaman aktif, navigasi antar slide) |
| **presentation** | `onboarding_page.dart` | Halaman utama carousel onboarding |

---

#### `features/home/`
Halaman utama (dashboard) setelah pengguna berhasil masuk.

> ⚠️ **Catatan:** Fitur ini masih dalam tahap pengembangan awal. DataSource dan Repository masih berisi kode placeholder.

---

#### `features/client/`
Fitur khusus yang mengelola tampilan dan data dari perspektif peran **Client** (pemilik proyek yang mencari jasa konstruksi).

> ⚠️ **Catatan:** Fitur ini sedang dalam pengembangan. Belum memiliki domain entities, usecases, dan BLoC.

---

#### `features/notification/`
Mengelola tampilan dan pengambilan data notifikasi untuk pengguna.

| Lapisan | File Utama | Keterangan |
|---|---|---|
| **data** | `notification_remote_data_source.dart` | Mengambil notifikasi dari Supabase |
| **data** | `notification_model.dart` | DTO Notification dengan serialisasi JSON |
| **domain** | `notification_entity.dart` | Entitas Notification murni |
| **domain** | `notification_repository.dart` | Interface: `getNotifications()` |
| **domain** | `get_notifications_usecase.dart` | Use case: ambil daftar notifikasi |
| **presentation** | `notification_page.dart` | Halaman daftar notifikasi |

---

#### `features/splash/`
Layar pembuka aplikasi. Menentukan navigasi awal (ke onboarding atau home) berdasarkan status sesi pengguna.

> 📌 Fitur ini **sengaja tidak memiliki lapisan data dan domain** karena hanya menjalankan logika routing sederhana.

---

### `lib/services/`
Berisi wrapper/abstraksi untuk layanan platform tingkat rendah yang diinisialisasi saat startup.

| File | Fungsi |
|---|---|
| `supabase_service.dart` | Inisialisasi klien Supabase (URL, anon key). Dipanggil di `main()`. |
| `push_notification_service.dart` | Inisialisasi Firebase Cloud Messaging (FCM) untuk push notification. |
| `local_storage_service.dart` | Abstraksi untuk operasi baca/tulis data lokal (SharedPreferences atau Hive). |

> 📌 `services/` berbeda dari `core/`. Services adalah tentang **inisialisasi platform**, sedangkan `core/` adalah tentang **utilitas aplikasi**.

---

## 📝 File Guidelines — Aturan Penamaan & Penempatan File

### Konvensi Penamaan
Semua file menggunakan **`snake_case`**, mengikuti konvensi Dart/Flutter.

| Tipe File | Pola Nama | Contoh |
|---|---|---|
| Page / Screen | `[nama]_page.dart` | `login_page.dart` |
| Widget (lokal) | `[nama]_widget.dart` atau `[nama]_view.dart` | `register_form_view.dart` |
| BLoC | `[nama]_bloc.dart` | `auth_bloc.dart` |
| Event BLoC | `[nama]_event.dart` | `auth_event.dart` |
| State BLoC | `[nama]_state.dart` | `auth_state.dart` |
| Use Case | `[aksi]_[entitas]_usecase.dart` | `login_usecase.dart`, `get_notifications_usecase.dart` |
| Entity | `[nama]_entity.dart` | `user_entity.dart` |
| Model (DTO) | `[nama]_model.dart` | `user_model.dart` |
| Repository (interface) | `[nama]_repository.dart` | `auth_repository.dart` |
| Repository (impl) | `[nama]_repository_impl.dart` | `auth_repository_impl.dart` |
| DataSource | `[nama]_[remote/local]_data_source.dart` | `auth_remote_data_source.dart` |
| Konstanta | `[nama]_constants.dart` | `supabase_constants.dart` |
| Utilitas | `[nama].dart` | `date_formatter.dart`, `validators.dart` |

---

### Panduan Menambahkan Fitur Baru

Ikuti langkah-langkah berikut saat membuat fitur baru, misalnya **`project`**:

**Step 1 — Buat struktur folder:**
```
lib/features/project/
  ├── data/
  │   ├── datasources/
  │   ├── models/
  │   └── repositories/
  ├── domain/
  │   ├── entities/
  │   ├── repositories/
  │   └── usecases/
  └── presentation/
      ├── bloc/
      ├── pages/
      └── widgets/
```

**Step 2 — Implementasi dari dalam ke luar (Domain → Data → Presentation):**
1. `domain/entities/project_entity.dart`
2. `domain/repositories/project_repository.dart`
3. `domain/usecases/get_projects_usecase.dart`
4. `data/models/project_model.dart`
5. `data/datasources/project_remote_data_source.dart`
6. `data/repositories/project_repository_impl.dart`
7. `presentation/bloc/project_bloc.dart`, `project_event.dart`, `project_state.dart`
8. `presentation/pages/project_page.dart`

**Step 3 — Daftarkan di DI Container (`config/injection_container.dart`):**
```dart
sl.registerFactory(() => ProjectBloc(sl()));
sl.registerLazySingleton(() => GetProjectsUseCase(sl()));
sl.registerLazySingleton<ProjectRepository>(
  () => ProjectRepositoryImpl(remoteDataSource: sl()),
);
sl.registerLazySingleton<ProjectRemoteDataSource>(
  () => ProjectRemoteDataSourceImpl(),
);
```

**Step 4 — Daftarkan rute baru (`core/routes/app_router.dart`):**
```dart
GoRoute(
  path: '/project',
  name: 'project',
  pageBuilder: (context, state) => buildFadeTransitionPage(
    key: state.pageKey,
    child: const ProjectPage(),
  ),
),
```

---

### Aturan Penempatan: Di Mana File Baru Harus Diletakkan?

| Situasi | Letakkan di |
|---|---|
| Widget dipakai hanya dalam satu fitur | `features/[nama_fitur]/presentation/widgets/` |
| Widget dipakai di dua fitur atau lebih | `core/widgets/` |
| Fungsi helper murni (stateless, no widget) | `core/utils/` |
| Nilai statis / magic string | `core/constants/` |
| Inisialisasi layanan pihak ketiga | `services/` |
| Definisi rute baru | `core/routes/app_router.dart` |
| Registrasi dependensi baru | `config/injection_container.dart` |

---

## 🔑 Ringkasan Prinsip Utama

> 1. **Feature-first:** Semua kode fitur hidup dalam `features/[nama_fitur]/`.
> 2. **Lapisan domain adalah raja:** `domain/` tidak boleh mengimpor dari `data/` atau `presentation/`.
> 3. **Satu use case, satu file:** Setiap aksi bisnis = satu file use case tersendiri.
> 4. **DI terpusat:** Semua instansiasi kelas konkret ada di `injection_container.dart`.
> 5. **Routing terpusat:** Semua rute ada di `app_router.dart`.
> 6. **Desain terpusat:** Warna, tipografi, dan tema hanya didefinisikan di `core/theme/`.

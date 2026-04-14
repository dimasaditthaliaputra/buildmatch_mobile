# 📐 Flutter Clean Architecture — BuildMatch Mobile

Dokumentasi struktur project Flutter menggunakan **Clean Architecture** dengan integrasi **Supabase** dan **Push Notification (OneSignal)**.

---

## 📁 Struktur Folder

```
lib/
├── main.dart                          # Entry point aplikasi
├── app.dart                           # MaterialApp / root widget
│
├── core/                              # Shared utilities & config
│   ├── constants/
│   │   ├── app_constants.dart         # Konstanta umum (nama app, dsb)
│   │   └── supabase_constants.dart    # Supabase URL & anon key
│   ├── error/
│   │   ├── exceptions.dart            # Custom exception classes
│   │   └── failures.dart              # Failure classes (Either pattern)
│   ├── network/
│   │   └── network_info.dart          # Cek koneksi internet
│   ├── theme/
│   │   ├── app_colors.dart            # Palet warna
│   │   ├── app_text_styles.dart       # Text styles
│   │   └── app_theme.dart             # ThemeData (Material 3)
│   ├── utils/
│   │   ├── date_formatter.dart        # Helper format tanggal
│   │   └── validators.dart            # Validasi form (email, password, dsb)
│   └── routes/
│       └── app_router.dart            # Route definitions (GoRouter)
│
├── config/
│   └── injection_container.dart       # Dependency Injection (GetIt)
│
├── features/                          # Fitur-fitur (per module)
│   ├── auth/                          # ── Autentikasi ──
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   ├── auth_remote_data_source.dart
│   │   │   │   └── auth_local_data_source.dart
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
│   │   │       ├── register_usecase.dart
│   │   │       └── logout_usecase.dart
│   │   └── presentation/
│   │       ├── bloc/
│   │       │   ├── auth_bloc.dart
│   │       │   ├── auth_event.dart
│   │       │   └── auth_state.dart
│   │       ├── pages/
│   │       │   ├── login_page.dart
│   │       │   └── register_page.dart
│   │       └── widgets/
│   │           └── auth_form_field.dart
│   │
│   ├── home/                          # ── Home ──
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
│   └── notification/                  # ── Notifikasi ──
│       ├── data/
│       │   ├── datasources/
│       │   │   └── notification_remote_data_source.dart
│       │   ├── models/
│       │   │   └── notification_model.dart
│       │   └── repositories/
│       │       └── notification_repository_impl.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   └── notification_entity.dart
│       │   ├── repositories/
│       │   │   └── notification_repository.dart
│       │   └── usecases/
│       │       └── get_notifications_usecase.dart
│       └── presentation/
│           └── pages/
│               └── notification_page.dart
│
└── services/                          # Servis global
    ├── supabase_service.dart           # Init & akses Supabase client
    ├── push_notification_service.dart  # OneSignal init & handler
    └── local_storage_service.dart      # SharedPreferences wrapper
```

---

## 🧠 Clean Architecture — 3 Layer

```
┌─────────────────────────────────────────┐
│           PRESENTATION                  │
│   (BLoC/Cubit, Pages, Widgets)          │
│       ↓ depends on Domain              │
├─────────────────────────────────────────┤
│             DOMAIN                      │
│   (Entities, UseCases, Repository ∅)    │
│       ↑ implemented by Data            │
├─────────────────────────────────────────┤
│              DATA                       │
│   (Models, DataSources, Repository ✓)   │
│       → Supabase, API, Local DB        │
└─────────────────────────────────────────┘
```

| Layer            | Isi                                             | Aturan                                       |
| ---------------- | ----------------------------------------------- | -------------------------------------------- |
| **Domain**       | `entities`, `usecases`, `repository (abstract)` | **Tidak import Flutter / package eksternal** |
| **Data**         | `models`, `datasources`, `repository (impl)`    | Implementasi detail: Supabase, API, local DB |
| **Presentation** | `bloc/cubit`, `pages`, `widgets`                | UI dan state management                      |

---

## 📂 Penjelasan Folder

### `core/`

Shared code yang dipakai di **semua feature**:

- `constants/` → Nilai tetap (URL Supabase, API key, dsb)
- `error/` → `Failure` dan `Exception` class untuk error handling konsisten
- `network/` → Cek status internet sebelum API call
- `theme/` → Design system (warna, typography, ThemeData)
- `utils/` → Helper functions (format tanggal, validasi form)
- `routes/` → Semua route didefinisikan di satu tempat

### `config/`

Setup **Dependency Injection** menggunakan `get_it`. Semua wiring repository → datasource → usecase → BLoC didaftarkan di sini.

### `features/<nama_fitur>/`

Setiap fitur punya **3 sub-folder** (data, domain, presentation) yang independen:

- `data/datasources/` → Komunikasi langsung ke Supabase/API/local DB
- `data/models/` → Class dengan `fromJson()` / `toJson()` (extends entity)
- `data/repositories/` → Implementasi repository. Error handling di sini
- `domain/entities/` → Object bisnis murni (plain Dart, no framework)
- `domain/repositories/` → Kontrak (abstract class)
- `domain/usecases/` → Satu class = satu aksi bisnis
- `presentation/bloc/` → State management. Panggil usecase, kelola state
- `presentation/pages/` → Halaman/screen
- `presentation/widgets/` → Widget reusable dalam fitur tersebut

### `services/`

Global services yang di-init 1x dan dipakai di mana saja via DI.

---

## 🔌 Integrasi Supabase

### Inisialisasi

```dart
// lib/services/supabase_service.dart
await Supabase.initialize(url: '...', anonKey: '...');
```

### Auth (Login/Register/Logout)

```dart
// Login
await client.auth.signInWithPassword(email: email, password: password);

// Register
await client.auth.signUp(email: email, password: password, data: {'name': name});

// Logout
await client.auth.signOut();
```

### Database Query

```dart
final data = await client
    .from('projects')
    .select('*, users(*)')
    .eq('status', 'active')
    .order('created_at', ascending: false)
    .limit(20);
```

### Alur Data (Auth Login)

```
LoginPage → AuthBloc → LoginUseCase → AuthRepository (abstract)
                                              ↓ (impl)
                                    AuthRepositoryImpl → AuthRemoteDataSource
                                                              ↓
                                                     Supabase.auth.signInWithPassword()
```

---

## 🔔 Push Notification (OneSignal)

### Inisialisasi

```dart
// lib/services/push_notification_service.dart
OneSignal.initialize('YOUR_APP_ID');
OneSignal.Notifications.requestPermission(true);
```

### Set User ID (setelah login)

```dart
await OneSignal.login(userId);
```

### Handle Notifikasi

```dart
// Saat tap notifikasi
OneSignal.Notifications.addClickListener((event) { ... });

// Saat notifikasi masuk (foreground)
OneSignal.Notifications.addForegroundWillDisplayListener((event) { ... });
```

---

## 📎 Dependencies (`pubspec.yaml`)

| Package              | Kegunaan                         |
| -------------------- | -------------------------------- |
| `supabase_flutter`   | Auth, database, storage          |
| `flutter_bloc`       | BLoC state management            |
| `get_it`             | Dependency injection             |
| `go_router`          | Deklaratif routing               |
| `dartz`              | Either pattern (error handling)  |
| `equatable`          | Value equality untuk model/state |
| `onesignal_flutter`  | Push notification                |
| `connectivity_plus`  | Cek koneksi internet             |
| `shared_preferences` | Local storage sederhana          |
| `intl`               | Format tanggal/angka             |

---

## ✅ Setup Awal

```bash
# 1. Install semua dependencies
flutter pub get

# 2. Ganti konfigurasi di:
#    - lib/core/constants/supabase_constants.dart  (URL & anon key)
#    - lib/services/push_notification_service.dart  (OneSignal App ID)

# 3. Jalankan
flutter run
```

---

## 📚 Referensi

| Sumber                          | Link                                                                                       |
| ------------------------------- | ------------------------------------------------------------------------------------------ |
| Reso Coder's Clean Architecture | [github.com/ResoCoder](https://github.com/ResoCoder/flutter-tdd-clean-architecture-course) |
| Very Good Ventures              | [github.com/VeryGoodOpenSource](https://github.com/VeryGoodOpenSource/very_good_cli)       |
| Flutter BLoC Library            | [bloclibrary.dev](https://bloclibrary.dev)                                                 |
| Supabase Flutter Docs           | [supabase.com/docs](https://supabase.com/docs/reference/dart/introduction)                 |
| OneSignal Flutter SDK           | [onesignal.com/docs](https://documentation.onesignal.com/docs/flutter-sdk-setup)           |

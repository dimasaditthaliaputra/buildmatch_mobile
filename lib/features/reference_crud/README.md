# Reference CRUD Feature

Fitur ini merupakan template/referensi best practice untuk implementasi fitur CRUD pada project ini menggunakan Clean Architecture, BLoC, dan Supabase.

## Arsitektur & Struktur Folder

```text
lib/features/reference_crud/
├── data/
│   ├── datasources/
│   │   └── category_remote_data_source.dart  (Supabase Implementation)
│   ├── models/
│   │   └── category_model.dart               (JSON Serialization)
│   └── repositories/
│       └── category_repository_impl.dart     (Repository Implementation)
├── domain/
│   ├── entities/
│   │   └── category_entity.dart              (Business Object)
│   ├── repositories/
│   │   └── category_repository.dart          (Contract)
│   └── usecases/
│       └── category_usecases.dart            (Business Logic)
└── presentation/
    ├── bloc/
    │   ├── category_bloc.dart
    │   ├── category_event.dart
    │   └── category_state.dart
    └── pages/
        ├── category_list_page.dart           (Read List with Pagination)
        ├── category_detail_page.dart         (Read Detail & Delete)
        └── category_form_page.dart           (Create & Update)
```

## Flow Data
`UI` ↔ `Bloc` ↔ `Use Case` ↔ `Repository` ↔ `Remote Data Source` ↔ `Supabase`

1. **Presentation (UI + BLoC)**: Menerima input user, trigger event, dan me-render UI berdasarkan state. Tidak ada business logic di layer ini.
2. **Domain (Entities + Use Cases + Repository Contract)**: Pusat business logic. Tidak bergantung pada package eksternal selain `dartz` (untuk `Either`) dan `equatable`.
3. **Data (Models + Repository Impl + Remote Data Source)**: Mengambil data dari external service (Supabase), mapping JSON ke Model, dan handling Exception menjadi Failure.

## Pagination Flow
1. **Initial Load**: BLoC menerima `LoadCategoriesEvent(isRefresh: true)`. Page di-set ke 0. Skeleton Loading muncul.
2. **Pull to Refresh**: Sama seperti Initial Load, memanggil `LoadCategoriesEvent(isRefresh: true)`.
3. **Load More**: Saat user scroll ke bawah `ScrollController` mendeteksi (threshold > max - 200), BLoC menerima `LoadMoreCategoriesEvent`. Page bertambah 1. `isLoadingMore` menjadi true. Data baru di-append ke list lama.
4. **End of Data**: Jika data yang di-return Supabase lebih kecil dari `limit`, maka `hasReachedMax` diset ke true. Load More dihentikan.

## Best Practice Developer
1. **Gunakan UseCase**: Semua pemanggilan fungsi repository dari BLoC wajib menggunakan UseCase.
2. **Skeleton Loading**: Gunakan `GlobalSkeleton` yang sudah ada, jangan membuat custom indicator sendiri.
3. **Error Handling**: Tangkap Exception di Data Source, konversi menjadi Failure di Repository Impl.

## Supabase SQL & Seed Data

Jalankan query ini di SQL Editor Supabase untuk setup tabel:

```sql
-- 1. Create Table
CREATE TABLE public.categories (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL
);

-- 2. Add Index for search and pagination
CREATE INDEX idx_categories_name ON public.categories (name);
CREATE INDEX idx_categories_created_at ON public.categories (created_at DESC);

-- 3. Trigger for Auto Update updated_at
CREATE OR REPLACE FUNCTION update_modified_column()   
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;   
END;
$$ language 'plpgsql';

CREATE TRIGGER update_categories_modtime
BEFORE UPDATE ON public.categories
FOR EACH ROW EXECUTE PROCEDURE update_modified_column();

-- 4. Insert Dummy Seed Data (10 records)
INSERT INTO public.categories (name, description) VALUES
('Konstruksi Baja', 'Kategori khusus untuk material dan pekerjaan struktur baja berat maupun ringan.'),
('Arsitektur Modern', 'Desain dan pengerjaan berkonsep modern minimalis dengan material inovatif.'),
('Plumbing & Sanitasi', 'Segala jenis pekerjaan terkait perpipaan air bersih, kotor, dan instalasi sanitasi.'),
('Instalasi Listrik', 'Pekerjaan kelistrikan, pemasangan kabel, panel, dan pencahayaan bangunan.'),
('Lanskap & Taman', 'Pembuatan taman, hardscape, softscape, dan penataan ruang terbuka hijau.'),
('Pengecatan', 'Kategori untuk pekerjaan finishing dinding, kayu, besi, interior dan eksterior.'),
('Plafon & Partisi', 'Pekerjaan langit-langit bangunan, partisi gypsum, dan material akustik.'),
('Lantai & Keramik', 'Pekerjaan pemasangan lantai keramik, granit, marmer, hingga epoxy flooring.'),
('HVAC', 'Pemasangan Heating, Ventilation, dan Air Conditioning untuk gedung dan perumahan.'),
('Perawatan Gedung', 'Jasa maintenance rutin, pembersihan fasad, dan perbaikan minor.');
```

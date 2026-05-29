import '../models/rating_stat_model.dart';
import '../models/review_model.dart';

abstract class RatingLocalDataSource {
  Future<RatingStatModel> getRatingStats();
  Future<List<ReviewModel>> getReviews();
}

class RatingLocalDataSourceImpl implements RatingLocalDataSource {
  @override
  Future<RatingStatModel> getRatingStats() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    return const RatingStatModel(
      averageRating: 4.9,
      totalReviews: 589,
      totalSatisfied: 491,
      totalWithPhotos: 124,
      ratingCounts: {
        5: 500,
        4: 60,
        3: 15,
        2: 10,
        1: 4,
      },
    );
  }

  @override
  Future<List<ReviewModel>> getReviews() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    return [
      ReviewModel(
        id: '1',
        clientName: 'Pengguna Anonim',
        clientAvatarUrl: null,
        rating: 5.0,
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        content:
            'Sangat puas dengan hasil renovasi dapurnya! Tim dari UrbanCore Construction sangat profesional dan detail. Pekerjaan selesai 2 hari lebih cepat dari jadwal. Sangat direkomendasikan untuk proyek rumah tinggal.',
        tags: const ['Tepat Waktu', 'Kualitas Tinggi', 'Komunikatif'],
        photos: const [
          'https://images.unsplash.com/photo-1556910103-1c02745a872f?q=80&w=600&auto=format&fit=crop',
          'https://images.unsplash.com/photo-1556911220-e15b29be8c8f?q=80&w=600&auto=format&fit=crop',
          'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?q=80&w=600&auto=format&fit=crop',
          'https://images.unsplash.com/photo-1556912173-3bb406ef7e77?q=80&w=600&auto=format&fit=crop',
        ],
      ),
      ReviewModel(
        id: '2',
        clientName: 'Pengguna Anonim',
        clientAvatarUrl: null,
        rating: 4.5,
        createdAt: DateTime.now().subtract(const Duration(days: 7)),
        content:
            'Hasil pengecatan rapi sekali. Komunikasi dengan mandor lancar. Hanya sedikit ada keterlambatan di awal karena cuaca, tapi tertutupi dengan hasil akhir.',
        tags: const [],
        photos: const [],
      ),
      ReviewModel(
        id: '3',
        clientName: 'Budi Santoso',
        clientAvatarUrl: 'https://i.pravatar.cc/150?u=budi',
        rating: 4.5,
        createdAt: DateTime.now().subtract(const Duration(days: 7)),
        content:
            'Hasil pengerjaan sangat memuaskan. Terima kasih banyak atas kerja kerasnya.',
        tags: const ['Komunikatif'],
        photos: const [],
      ),
    ];
  }
}

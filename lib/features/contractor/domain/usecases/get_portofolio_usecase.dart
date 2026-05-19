import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/portofolio_entity.dart';
import '../repositories/portofolio_repository.dart';

class TambahPortofolioUsecase {
  final PortofolioRepository repository;

  const TambahPortofolioUsecase(this.repository);

  Future<Either<Failure, PortofolioEntity>> call(
    TambahPortofolioParams params,
  ) {
    return repository.tambahPortofolio(
      judul: params.judul,
      deskripsi: params.deskripsi,
      imagePaths: params.imagePaths,
    );
  }
}

class TambahPortofolioParams {
  final String judul;
  final String deskripsi;
  final List<String> imagePaths;

  const TambahPortofolioParams({
    required this.judul,
    required this.deskripsi,
    required this.imagePaths,
  });
}

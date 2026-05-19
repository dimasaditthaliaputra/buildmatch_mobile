import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/portofolio_entity.dart';

abstract class PortofolioRepository {
  Future<Either<Failure, PortofolioEntity>> tambahPortofolio({
    required String judul,
    required String deskripsi,
    required List<String> imagePaths,
  });
}

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/penawaran_entity.dart';

abstract class PenawaranRepository {
  Future<Either<Failure, PenawaranEntity>> ajukanPenawaran({
    required String projectId,
    required int budgetMin,
    required int budgetMax,
    required String pesan,
    required DateTime estimasiWaktu,
  });
}
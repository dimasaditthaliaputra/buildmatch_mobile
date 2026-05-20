import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/contractor_project_offer_entity.dart';

abstract class ContractorProjectOfferRepository {
  Future<Either<Failure, ContractorProjectOfferEntity>> ajukanPenawaran({
    required String projectId,
    required int budgetMin,
    required int budgetMax,
    required String pesan,
    required DateTime estimasiWaktu,
  });
}
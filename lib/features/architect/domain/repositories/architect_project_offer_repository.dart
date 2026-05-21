import 'package:buildmatch_mobile/features/architect/domain/entities/architect_project_offer_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';


abstract class ArchitectProjectOfferRepository {
  Future<Either<Failure, ArchitectProjectOfferEntity>> ajukanPenawaran({
    required String projectId,
    required int budgetMin,
    required int budgetMax,
    required String pesan,
    required DateTime estimasiWaktu,
  });
}
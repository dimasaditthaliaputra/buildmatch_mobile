import 'package:buildmatch_mobile/features/architect/domain/entities/architect_project_offer_entity.dart';
import 'package:buildmatch_mobile/features/architect/domain/repositories/architect_project_offer_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';


class GetArchitectProjectOfferUsecase {
  final ArchitectProjectOfferRepository repository;

  const GetArchitectProjectOfferUsecase(this.repository);
  Future<Either<Failure, ArchitectProjectOfferEntity>> call(
    GetPenawaranParams params,
  ) {
    return repository.ajukanPenawaran(
      projectId: params.projectId,
      budgetMin: params.budgetMin,
      budgetMax: params.budgetMax,
      pesan: params.pesan,
      estimasiWaktu: params.estimasiWaktu,
    );
  }
}

class GetPenawaranParams {
  final String projectId;
  final int budgetMin;
  final int budgetMax;
  final String pesan;
  final DateTime estimasiWaktu;

  const GetPenawaranParams({
    required this.projectId,
    required this.budgetMin,
    required this.budgetMax,
    required this.pesan,
    required this.estimasiWaktu,
  });
}
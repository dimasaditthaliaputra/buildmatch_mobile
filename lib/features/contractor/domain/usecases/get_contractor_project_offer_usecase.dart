import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/contractor_project_offer_entity.dart';
import '../repositories/contractor_project_offer_repository.dart';

class GetContractorProjectOfferUsecase {
  final ContractorProjectOfferRepository repository;

  const GetContractorProjectOfferUsecase(this.repository);
  Future<Either<Failure, ContractorProjectOfferEntity>> call(
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
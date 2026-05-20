import '../entities/contractor_progres_entity.dart';
import '../repositories/contractor_progres_repository.dart';

class GetJenisPekerjaanUseCase {
  final ContractorProgressRepository repository;
  GetJenisPekerjaanUseCase(this.repository);

  Future<List<JenisPekerjaanEntity>> call() => repository.getJenisPekerjaan();
}

class SimpanProgresUseCase {
  final ContractorProgressRepository repository;
  SimpanProgresUseCase(this.repository);

  Future<void> call(ContractorProgressEntity progres) => repository.simpanProgres(progres);
}
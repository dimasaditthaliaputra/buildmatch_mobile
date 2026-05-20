import '../entities/contractor_progres_entity.dart';

abstract class ContractorProgressRepository {
  Future<List<JenisPekerjaanEntity>> getJenisPekerjaan();
  Future<void> simpanProgres(ContractorProgressEntity progres);
}
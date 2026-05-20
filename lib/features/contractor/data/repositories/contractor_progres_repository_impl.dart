import '../../domain/entities/contractor_progres_entity.dart';
import '../../domain/repositories/contractor_progres_repository.dart';
import '../datasources/contractor_progres_local_data_source.dart';
import '../models/contractor_progres_model.dart';

class ContractorProgresRepositoryImpl implements ContractorProgressRepository {
  final ContractorProgresLocalDataSource localDataSource;

  ContractorProgresRepositoryImpl({required this.localDataSource});

  @override
  Future<List<JenisPekerjaanEntity>> getJenisPekerjaan() {
    return localDataSource.getJenisPekerjaan();
  }

  @override
  Future<void> simpanProgres(ContractorProgressEntity progres) {
    return localDataSource.simpanProgres(
      ContractorProgresModel(
        jenisPekerjaanId: progres.jenisPekerjaanId,
        jenisPekerjaanNama: progres.jenisPekerjaanNama,
        persentase: progres.persentase,
        isDariSistem: progres.isDariSistem,
      ),
    );
  }
}
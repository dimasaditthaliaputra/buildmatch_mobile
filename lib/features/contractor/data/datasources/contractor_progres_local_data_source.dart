import '../models/contractor_progres_model.dart';

abstract class ContractorProgresLocalDataSource {
  Future<List<JenisPekerjaanModel>> getJenisPekerjaan();
  Future<void> simpanProgres(ContractorProgresModel progres);
}

class ProgresLocalDataSourceImpl implements ContractorProgresLocalDataSource {
  static const List<Map<String, dynamic>> _dummyJenisPekerjaan = [
    {'id': '1', 'nama': 'Survei & Pondasi', 'persentase_otomatis': 0.25},
    {'id': '2', 'nama': 'Struktur Beton', 'persentase_otomatis': 0.45},
    {'id': '3', 'nama': 'Pemasangan Atap', 'persentase_otomatis': 0.60},
    {'id': '4', 'nama': 'Instalasi Listrik', 'persentase_otomatis': 0.70},
    {'id': '5', 'nama': 'Plesteran & Acian', 'persentase_otomatis': 0.80},
    {'id': '6', 'nama': 'Pemasangan Keramik', 'persentase_otomatis': 0.90},
    {'id': '7', 'nama': 'Finishing & Cat', 'persentase_otomatis': 1.0},
  ];

  @override
  Future<List<JenisPekerjaanModel>> getJenisPekerjaan() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return _dummyJenisPekerjaan
        .map((e) => JenisPekerjaanModel.fromJson(e))
        .toList();
  }

  @override
  Future<void> simpanProgres(ContractorProgresModel progres) async {
    await Future.delayed(const Duration(milliseconds: 800));
    // await supabaseClient.from('progres').insert(progres.toJson());
  }
}
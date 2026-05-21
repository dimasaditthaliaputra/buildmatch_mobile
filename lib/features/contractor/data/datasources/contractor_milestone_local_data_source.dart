import 'package:uuid/uuid.dart';
import '../models/contractor_milestone_model.dart';
import '../../domain/entities/contractor_milestone_entity.dart';

abstract class ContractorMilestoneLocalDataSource {
  Future<List<ContractorMilestoneModel>> getSystemMilestones(double totalNilaiKontrak);
}

class ContractorMilestoneLocalDataSourceImpl
    implements ContractorMilestoneLocalDataSource {
  final _uuid = const Uuid();

  @override
  Future<List<ContractorMilestoneModel>> getSystemMilestones(
      double totalNilaiKontrak) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final List<Map<String, dynamic>> templates = [
      {
        'nama': 'Down Payment (DP)',
        'persentase': 0.20,
        'tipe': MilestoneTipe.nonPembangunan,
      },
      {
        'nama': 'Design & Permitting',
        'persentase': 0.15,
        'tipe': MilestoneTipe.nonPembangunan,
      },
      {
        'nama': 'Main Construction Phase',
        'persentase': 0.40,
        'tipe': MilestoneTipe.pembangunan,
      },
      {
        'nama': 'Handover & Completion',
        'persentase': 0.25,
        'tipe': MilestoneTipe.pembangunan,
      },
    ];

    return templates.map((t) {
      final persentase = t['persentase'] as double;
      return ContractorMilestoneModel(
        id: _uuid.v4(),
        nama: t['nama'] as String,
        persentase: persentase,
        jumlahUang: totalNilaiKontrak * persentase,
        tipe: t['tipe'] as MilestoneTipe,
        isFromSystem: true,
      );
    }).toList();
  }
}

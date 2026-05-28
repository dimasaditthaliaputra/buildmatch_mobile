import 'package:uuid/uuid.dart';
import '../models/architect_milestone_model.dart';
import '../../domain/entities/architect_milestone_entity.dart';

abstract class ArchitectMilestoneLocalDataSource {
  Future<List<ArchitectMilestoneModel>> getSystemMilestones(double totalNilaiKontrak);
}

class ArchitectMilestoneLocalDataSourceImpl
    implements ArchitectMilestoneLocalDataSource {
  final _uuid = const Uuid();

  @override
  Future<List<ArchitectMilestoneModel>> getSystemMilestones(
      double totalNilaiKontrak) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final List<Map<String, dynamic>> templates = [
      {
        'nama': 'Down Payment (DP)',
        'persentase': 0.50,
        'tipe': MilestoneTipe.nonPembangunan,
      },
      {
        'nama': 'Design & Permitting',
        'persentase': 0.20,
        'tipe': MilestoneTipe.nonPembangunan,
      },
    ];

    return templates.map((t) {
      final persentase = t['persentase'] as double;
      return ArchitectMilestoneModel(
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

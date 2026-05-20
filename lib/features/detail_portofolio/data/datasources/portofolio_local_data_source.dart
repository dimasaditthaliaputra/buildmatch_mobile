import '../../../../core/error/exceptions.dart';
import '../models/portofolio_model.dart';

abstract class PortofolioLocalDataSource {
  Future<PortofolioModel> tambahPortofolio(Map<String, dynamic> data);
}

class PortofolioLocalDataSourceImpl implements PortofolioLocalDataSource {
  final List<PortofolioModel> _portofolioList = [];

  @override
  Future<PortofolioModel> tambahPortofolio(Map<String, dynamic> data) async {
    try {
      final model = PortofolioModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        judul: data['judul'] as String,
        deskripsi: data['deskripsi'] as String,
        imagePaths: List<String>.from(data['image_paths'] ?? []),
        createdAt: DateTime.now(),
      );

      _portofolioList.add(model);
      return model;
    } catch (e) {
      throw ServerException('Gagal menyimpan portofolio: ${e.toString()}');
    }
  }
}

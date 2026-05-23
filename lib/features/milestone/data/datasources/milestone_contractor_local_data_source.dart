import '../models/milestone_model.dart';
import '../models/progress_model.dart';

abstract class MilestoneContractorLocalDataSource {
  Future<List<MilestoneModel>> getMilestones();
}

class MilestoneContractorLocalDataSourceImpl implements MilestoneContractorLocalDataSource {
  @override
  Future<List<MilestoneModel>> getMilestones() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    return [
      const MilestoneModel(
        id: '1',
        title: 'Survei Lokasi & Pondasi',
        description: 'Jun 12 - Konfirmasi batas lokasi & survei tanah',
        status: 'SELESAI',
        isConstruction: false,
        paymentAmount: 210000000,
        paymentStatus: 'LUNAS',
        evidencePhotos: [],
        completionPercentage: 1.0,
      ),
      const MilestoneModel(
        id: '2',
        title: 'Desain & Konsep',
        description: 'Penyempurnaan denah & pemilihan material',
        status: 'SELESAI',
        isConstruction: false,
        paymentAmount: 310000000,
        paymentStatus: 'LUNAS',
        evidencePhotos: [
          'assets/images/flutter_01.png',
          'assets/images/flutter_01.png',
          'assets/images/flutter_01.png',
          'assets/images/flutter_01.png'
        ],
        completionPercentage: 1.0,
      ),
      const MilestoneModel(
        id: '3',
        title: 'Revisi Desain',
        description: 'Kontraktor tidak cocok dengan desain',
        status: 'SELESAI',
        isConstruction: false,
        paymentAmount: 0,
        paymentStatus: '',
        evidencePhotos: [],
        completionPercentage: 1.0,
      ),
      const MilestoneModel(
        id: '4',
        title: 'Surat Perjanjian Kerja',
        description: 'Persetujuan Perjanjian Kerja',
        status: 'SELESAI',
        isConstruction: false,
        paymentAmount: 0,
        paymentStatus: '',
        evidencePhotos: [
          'assets/images/buktiperjanjian.png'
        ],
        completionPercentage: 1.0,
      ),
      const MilestoneModel(
        id: '5',
        title: 'Konstruksi & Pengawasan',
        description: 'Pembangunan struktur utama & pengawasan lapangan',
        status: 'MENUNGGU',
        isConstruction: true,
        paymentAmount: 0,
        paymentStatus: '',
        evidencePhotos: [],
        completionPercentage: 0.4,
        progressList: [
          ProgressModel(
            id: 'p1',
            title: 'Progres 1',
            description: 'Meratakan Tanah',
            percentage: 0.1,
            evidencePhotos: [
              'assets/images/progres1bukti1.png',
              'assets/images/progres1bukti2.png',
              'assets/images/progres1bukti3.png'
            ],
            paymentStatus: 'LUNAS',
            paymentAmount: 70000000,
          ),
          ProgressModel(
            id: 'p2',
            title: 'Progres 2',
            description: 'Pondasi & Sloof',
            percentage: 0.3,
            evidencePhotos: [
              'assets/images/progres2bukti1.png',
              'assets/images/progres2bukti2.png'
            ],
            paymentStatus: 'MENUNGGU',
            paymentAmount: 105000000,
          ),
        ],
      ),
      const MilestoneModel(
        id: '6',
        title: 'Finishing & Serah Terima',
        description: 'Interior, eksterior, dan serah terima kunci',
        status: 'BELUM MULAI',
        isConstruction: false,
        paymentAmount: 0,
        paymentStatus: '',
        evidencePhotos: [],
        completionPercentage: 0.0,
      ),
    ];
  }
}

import 'package:flutter/material.dart';

abstract class MilestoneDocumentLocalDataSource {
  Future<List<Map<String, dynamic>>> getDocuments();
}

class MilestoneDocumentLocalDataSourceImpl implements MilestoneDocumentLocalDataSource {
  @override
  Future<List<Map<String, dynamic>>> getDocuments() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      {
        'title': 'Surat Perjanjian Kerja (SPK)',
        'subtitle': 'PDF • 2.4 MB',
        'date': '12 Jun 2025',
        'icon': Icons.description_outlined,
        'category': 'KONTRAK',
      },
      {
        'title': 'Invoice Termin 1 (DP 30%)',
        'subtitle': 'PDF • 1.1 MB',
        'date': '15 Jun 2025',
        'icon': Icons.receipt_long_outlined,
        'category': 'INVOICE',
      },
      {
        'title': 'Desain Arsitektur & Rendering 3D',
        'subtitle': 'PDF • 15.2 MB',
        'date': '10 Jun 2025',
        'icon': Icons.architecture_outlined,
        'category': 'DESAIN',
      },
      {
        'title': 'Laporan Progres Fase 1 (Pondasi)',
        'subtitle': 'PDF • 4.8 MB',
        'date': '20 Jun 2025',
        'icon': Icons.assignment_outlined,
        'category': 'LAPORAN',
      },
      {
        'title': 'Invoice Termin 2 (Pondasi Selesai)',
        'subtitle': 'PDF • 1.2 MB',
        'date': '24 Jun 2025',
        'icon': Icons.receipt_long_outlined,
        'category': 'INVOICE',
      },
      {
        'title': 'Dokumen IMB & Perizinan Lokasi',
        'subtitle': 'PDF • 3.5 MB',
        'date': '08 Jun 2025',
        'icon': Icons.gavel_outlined,
        'category': 'DOKUMEN HUKUM',
      },
    ];
  }
}

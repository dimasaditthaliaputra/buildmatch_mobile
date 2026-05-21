import 'package:flutter/material.dart';

class ContractorTambahMilestoneButton extends StatelessWidget { // <-- Pastikan berupa CLASS
  final bool isEnabled;
  final VoidCallback onTap;

  const ContractorTambahMilestoneButton({
    super.key,
    required this.isEnabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled ? onTap : null,
      child: const Text('Tambah Milestone'),
    );
  }
}
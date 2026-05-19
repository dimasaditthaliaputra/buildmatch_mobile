import 'package:equatable/equatable.dart';

class VerificationStatus extends Equatable {
  final String status;
  final String? remarks;
  final String companyName;
  final DateTime? verifiedAt;

  const VerificationStatus({
    required this.status,
    this.remarks,
    required this.companyName,
    this.verifiedAt,
  });

  @override
  List<Object?> get props => [status, remarks, companyName, verifiedAt];
}

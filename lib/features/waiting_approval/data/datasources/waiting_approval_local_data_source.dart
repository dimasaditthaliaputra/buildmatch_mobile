import '../../domain/entities/verification_status.dart';

abstract class WaitingApprovalLocalDataSource {
  Future<VerificationStatus> getVerificationStatus();
}

class WaitingApprovalLocalDataSourceImpl implements WaitingApprovalLocalDataSource {
  @override
  Future<VerificationStatus> getVerificationStatus() async {
    // Simulate API network call delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Return dummy verification status: 'pending' as shown in the mockup
    return VerificationStatus(
      status: 'pending',
      companyName: 'PT BuildMatch Indonesia',
      remarks: 'Menunggu dokumen Anda divalidasi oleh Tim Admin kami.',
      verifiedAt: null,
    );
  }
}

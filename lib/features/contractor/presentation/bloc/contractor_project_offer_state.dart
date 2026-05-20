part of 'contractor_project_offer_bloc.dart';

enum ProjectOfferSubmitStatus {
  initial,
  loading,
  success,
  failure,
}

class ContractorProjectOfferState extends Equatable {
  final int? budgetMin;
  final int? budgetMax;
  final String pesan;
  final DateTime? estimasiWaktu;
  final ProjectOfferSubmitStatus submitStatus;
  final String? errorMessage;

  const ContractorProjectOfferState({
    this.budgetMin,
    this.budgetMax,
    this.pesan = '',
    this.estimasiWaktu,
    this.submitStatus = ProjectOfferSubmitStatus.initial,
    this.errorMessage,
  });

  factory ContractorProjectOfferState.initial() => const ContractorProjectOfferState();

  ContractorProjectOfferState copyWith({
    int? budgetMin,
    int? budgetMax,
    String? pesan,
    DateTime? estimasiWaktu,
    ProjectOfferSubmitStatus? submitStatus,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ContractorProjectOfferState(
      budgetMin: budgetMin ?? this.budgetMin,
      budgetMax: budgetMax ?? this.budgetMax,
      pesan: pesan ?? this.pesan,
      estimasiWaktu: estimasiWaktu ?? this.estimasiWaktu,
      submitStatus: submitStatus ?? this.submitStatus,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  bool get isFormValid {
    final minOk = budgetMin != null && budgetMin! > 0;
    final maxOk = budgetMax != null && budgetMax! > 0;
    final rangeOk = minOk && maxOk && budgetMax! >= budgetMin!;
    final pesanOk = pesan.trim().length >= 10;
    final tanggalOk = estimasiWaktu != null;

    return rangeOk && pesanOk && tanggalOk;
  }

  bool get isLoading => submitStatus == ProjectOfferSubmitStatus.loading;

  @override
  List<Object?> get props => [
        budgetMin,
        budgetMax,
        pesan,
        estimasiWaktu,
        submitStatus,
        errorMessage,
      ];
}
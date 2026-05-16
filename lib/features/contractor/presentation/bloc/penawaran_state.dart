part of 'penawaran_bloc.dart';

enum PenawaranSubmitStatus {
  initial,
  loading,
  success,
  failure,
}

class PenawaranState extends Equatable {
  final int? budgetMin;
  final int? budgetMax;
  final String pesan;
  final DateTime? estimasiWaktu;
  final PenawaranSubmitStatus submitStatus;
  final String? errorMessage;

  const PenawaranState({
    this.budgetMin,
    this.budgetMax,
    this.pesan = '',
    this.estimasiWaktu,
    this.submitStatus = PenawaranSubmitStatus.initial,
    this.errorMessage,
  });

  factory PenawaranState.initial() => const PenawaranState();

  PenawaranState copyWith({
    int? budgetMin,
    int? budgetMax,
    String? pesan,
    DateTime? estimasiWaktu,
    PenawaranSubmitStatus? submitStatus,
    String? errorMessage,
    bool clearError = false,
  }) {
    return PenawaranState(
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

  bool get isLoading => submitStatus == PenawaranSubmitStatus.loading;

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
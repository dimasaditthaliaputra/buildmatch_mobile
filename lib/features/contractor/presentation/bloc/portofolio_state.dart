part of 'portofolio_bloc.dart';

enum PortofolioSubmitStatus { initial, loading, success, failure }

class PortofolioState extends Equatable {
  final String judul;
  final String deskripsi;
  final List<String> imagePaths;
  final PortofolioSubmitStatus submitStatus;
  final String? errorMessage;

  const PortofolioState({
    this.judul = '',
    this.deskripsi = '',
    this.imagePaths = const [],
    this.submitStatus = PortofolioSubmitStatus.initial,
    this.errorMessage,
  });

  factory PortofolioState.initial() => const PortofolioState();

  PortofolioState copyWith({
    String? judul,
    String? deskripsi,
    List<String>? imagePaths,
    PortofolioSubmitStatus? submitStatus,
    String? errorMessage,
    bool clearError = false,
  }) {
    return PortofolioState(
      judul: judul ?? this.judul,
      deskripsi: deskripsi ?? this.deskripsi,
      imagePaths: imagePaths ?? this.imagePaths,
      submitStatus: submitStatus ?? this.submitStatus,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  bool get isFormValid {
    final judulOk = judul.trim().isNotEmpty;
    final deskripsiOk = deskripsi.trim().length >= 10;
    return judulOk && deskripsiOk;
  }

  bool get isLoading => submitStatus == PortofolioSubmitStatus.loading;

  @override
  List<Object?> get props => [
        judul,
        deskripsi,
        imagePaths,
        submitStatus,
        errorMessage,
      ];
}

part of 'contractor_add_progres_bloc.dart';

enum InputMode { dariSistem, manual }

class ContractorAddProgresState extends Equatable {
  final InputMode inputMode;
  final List<JenisPekerjaanEntity> daftarJenisPekerjaan;
  final JenisPekerjaanEntity? selectedJenisPekerjaan;
  final String jenisPekerjaanManual;
  final double persentaseManual;
  final bool isLoadingJenisPekerjaan;
  final bool isSimpanLoading;
  final bool isSimpanSuccess;
  final String? errorMessage;
  final double? totalAlokasi;

  const ContractorAddProgresState({
    this.inputMode = InputMode.dariSistem,
    this.daftarJenisPekerjaan = const [],
    this.selectedJenisPekerjaan,
    this.jenisPekerjaanManual = '',
    this.persentaseManual = 0.0,
    this.isLoadingJenisPekerjaan = false,
    this.isSimpanLoading = false,
    this.isSimpanSuccess = false,
    this.errorMessage,
    this.totalAlokasi,
  });

  double get persentaseAktif {
    if (inputMode == InputMode.dariSistem) {
      return selectedJenisPekerjaan?.persentaseOtomatis ?? 0.0;
    }
    return persentaseManual;
  }

  bool get canSimpan {
    if (inputMode == InputMode.dariSistem) {
      return selectedJenisPekerjaan != null;
    }
    return jenisPekerjaanManual.trim().isNotEmpty;
  }

  ContractorAddProgresState copyWith({
    InputMode? inputMode,
    List<JenisPekerjaanEntity>? daftarJenisPekerjaan,
    JenisPekerjaanEntity? selectedJenisPekerjaan,
    bool clearSelected = false,
    String? jenisPekerjaanManual,
    double? persentaseManual,
    bool? isLoadingJenisPekerjaan,
    bool? isSimpanLoading,
    bool? isSimpanSuccess,
    String? errorMessage,
    bool clearError = false,
    double? totalAlokasi,
  }) {
    return ContractorAddProgresState(
      inputMode: inputMode ?? this.inputMode,
      daftarJenisPekerjaan: daftarJenisPekerjaan ?? this.daftarJenisPekerjaan,
      selectedJenisPekerjaan: clearSelected
          ? null
          : selectedJenisPekerjaan ?? this.selectedJenisPekerjaan,
      jenisPekerjaanManual:
          jenisPekerjaanManual ?? this.jenisPekerjaanManual,
      persentaseManual: persentaseManual ?? this.persentaseManual,
      isLoadingJenisPekerjaan:
          isLoadingJenisPekerjaan ?? this.isLoadingJenisPekerjaan,
      isSimpanLoading: isSimpanLoading ?? this.isSimpanLoading,
      isSimpanSuccess: isSimpanSuccess ?? this.isSimpanSuccess,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      totalAlokasi: totalAlokasi ?? this.totalAlokasi,
    );
  }

  @override
  List<Object?> get props => [
        inputMode,
        daftarJenisPekerjaan,
        selectedJenisPekerjaan,
        jenisPekerjaanManual,
        persentaseManual,
        isLoadingJenisPekerjaan,
        isSimpanLoading,
        isSimpanSuccess,
        errorMessage,
        totalAlokasi,
      ];
}
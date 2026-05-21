part of 'contractor_add_progres_bloc.dart';

enum InputMode { dariSistem, manual }

class ContractorAddProgresState extends Equatable {
  final InputMode inputMode;
  final List<JenisPekerjaanEntity> daftarJenisPekerjaan;
  final JenisPekerjaanEntity? selectedJenisPekerjaan;
  final String jenisPekerjaanManual;
  final double persentaseManual;
  final double progresSebelumnya; // TAHAP 1: Tambahkan ini
  final bool isLoadingJenisPekerjaan;
  final bool isSimpanLoading;
  final bool isSimpanSuccess;
  final String? errorMessage;

  const ContractorAddProgresState({
    this.inputMode = InputMode.dariSistem,
    this.daftarJenisPekerjaan = const [],
    this.selectedJenisPekerjaan,
    this.jenisPekerjaanManual = '',
    this.persentaseManual = 0.0,
    this.progresSebelumnya = 0.0, // Default 0.0, sesuaikan jika ada fetch dari API
    this.isLoadingJenisPekerjaan = false,
    this.isSimpanLoading = false,
    this.isSimpanSuccess = false,
    this.errorMessage,
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
    double? progresSebelumnya,
    bool? isLoadingJenisPekerjaan,
    bool? isSimpanLoading,
    bool? isSimpanSuccess,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ContractorAddProgresState(
      inputMode: inputMode ?? this.inputMode,
      daftarJenisPekerjaan: daftarJenisPekerjaan ?? this.daftarJenisPekerjaan,
      selectedJenisPekerjaan: clearSelected
          ? null
          : selectedJenisPekerjaan ?? this.selectedJenisPekerjaan,
      jenisPekerjaanManual: jenisPekerjaanManual ?? this.jenisPekerjaanManual,
      persentaseManual: persentaseManual ?? this.persentaseManual,
      progresSebelumnya: progresSebelumnya ?? this.progresSebelumnya,
      isLoadingJenisPekerjaan: isLoadingJenisPekerjaan ?? this.isLoadingJenisPekerjaan,
      isSimpanLoading: isSimpanLoading ?? this.isSimpanLoading,
      isSimpanSuccess: isSimpanSuccess ?? this.isSimpanSuccess,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        inputMode,
        daftarJenisPekerjaan,
        selectedJenisPekerjaan,
        jenisPekerjaanManual,
        persentaseManual,
        progresSebelumnya,
        isLoadingJenisPekerjaan,
        isSimpanLoading,
        isSimpanSuccess,
        errorMessage,
      ];
}
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/contractor_progres_entity.dart';
import '../../domain/usecases/get_contractor_progres_usecases.dart';

part 'contractor_add_progres_event.dart';
part 'contractor_add_progres_state.dart';

class ContractorAddProgresBloc
    extends Bloc<ContractorAddProgresEvent, ContractorAddProgresState> {
  final GetJenisPekerjaanUseCase getJenisPekerjaanUseCase;
  final SimpanProgresUseCase simpanProgresUseCase;

  static const double _stepPersentase = 0.05;

  ContractorAddProgresBloc({
    required this.getJenisPekerjaanUseCase,
    required this.simpanProgresUseCase,
  }) : super(const ContractorAddProgresState()) {
    on<TambahProgresInitialized>(_onInitialized);
    on<TambahProgresTabChanged>(_onTabChanged);
    on<TambahProgresJenisPekerjaanDipilih>(_onJenisPekerjaanDipilih);
    on<TambahProgresJenisPekerjaanManualChanged>(_onJenisPekerjaanManualChanged);
    on<TambahProgresPersentaseDitambah>(_onPersentaseDitambah);
    on<TambahProgresPersentaseDikurangi>(_onPersentaseDikurangi);
    on<TambahProgresPersentaseDiubah>(_onPersentaseDiubah);
    on<TambahProgresDiSimpan>(_onDiSimpan);
  }

  Future<void> _onInitialized(
    TambahProgresInitialized event,
    Emitter<ContractorAddProgresState> emit,
  ) async {
    emit(state.copyWith(isLoadingJenisPekerjaan: true, clearError: true));
    try {
      final list = await getJenisPekerjaanUseCase();
      emit(state.copyWith(
        daftarJenisPekerjaan: list,
        isLoadingJenisPekerjaan: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoadingJenisPekerjaan: false,
        errorMessage: 'Gagal memuat data jenis pekerjaan.',
      ));
    }
  }

  void _onTabChanged(
    TambahProgresTabChanged event,
    Emitter<ContractorAddProgresState> emit,
  ) {
    emit(state.copyWith(
      inputMode: event.mode,
      clearSelected: true,
      jenisPekerjaanManual: '',
      persentaseManual: 0.0,
      clearError: true,
    ));
  }

  void _onJenisPekerjaanDipilih(
    TambahProgresJenisPekerjaanDipilih event,
    Emitter<ContractorAddProgresState> emit,
  ) {
    emit(state.copyWith(selectedJenisPekerjaan: event.jenisPekerjaan));
  }

  void _onJenisPekerjaanManualChanged(
    TambahProgresJenisPekerjaanManualChanged event,
    Emitter<ContractorAddProgresState> emit,
  ) {
    emit(state.copyWith(jenisPekerjaanManual: event.nilai));
  }

  void _onPersentaseDitambah(
    TambahProgresPersentaseDitambah event,
    Emitter<ContractorAddProgresState> emit,
  ) {
    final newVal = (state.persentaseManual + _stepPersentase).clamp(0.0, 1.0);
    
    final double progresLama = 0.00;
    final double newTotalAlokasi = progresLama + newVal;

    emit(state.copyWith(
      persentaseManual: newVal,
      totalAlokasi: newTotalAlokasi, 
    ));
  }

  void _onPersentaseDikurangi(
    TambahProgresPersentaseDikurangi event,
    Emitter<ContractorAddProgresState> emit,
  ) {
    final newVal = (state.persentaseManual - _stepPersentase).clamp(0.0, 1.0);
    
    final double progresLama = 0.00;
    final double newTotalAlokasi = progresLama + newVal;

    emit(state.copyWith(
      persentaseManual: newVal,
      totalAlokasi: newTotalAlokasi, 
    ));
  }

  void _onPersentaseDiubah(
    TambahProgresPersentaseDiubah event,
    Emitter<ContractorAddProgresState> emit,
  ) {
    final newVal = event.nilai.clamp(0.0, 1.0);
    
    final double progresLama = 0.00;
    final double newTotalAlokasi = progresLama + newVal;

    emit(state.copyWith(
      persentaseManual: newVal,
      totalAlokasi: newTotalAlokasi, 
    ));
  }

  Future<void> _onDiSimpan(
    TambahProgresDiSimpan event,
    Emitter<ContractorAddProgresState> emit,
  ) async {
    if (!state.canSimpan) return;
    emit(state.copyWith(isSimpanLoading: true, clearError: true));
    try {
      final progres = ContractorProgressEntity(
        jenisPekerjaanId: state.inputMode == InputMode.dariSistem
            ? state.selectedJenisPekerjaan!.id
            : 'manual',
        jenisPekerjaanNama: state.inputMode == InputMode.dariSistem
            ? state.selectedJenisPekerjaan!.nama
            : state.jenisPekerjaanManual,
        persentase: state.persentaseAktif,
        isDariSistem: state.inputMode == InputMode.dariSistem,
      );
      await simpanProgresUseCase(progres);
      emit(state.copyWith(isSimpanLoading: false, isSimpanSuccess: true));
    } catch (e) {
      emit(state.copyWith(
        isSimpanLoading: false,
        errorMessage: 'Gagal menyimpan progres. Coba lagi.',
      ));
    }
  }
}
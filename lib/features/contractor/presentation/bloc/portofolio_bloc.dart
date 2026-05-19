import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_portofolio_usecase.dart';
part 'portofolio_event.dart';
part 'portofolio_state.dart';

class PortofolioBloc extends Bloc<PortofolioEvent, PortofolioState> {
  final TambahPortofolioUsecase tambahPortofolioUsecase;

  PortofolioBloc({required this.tambahPortofolioUsecase})
      : super(PortofolioState.initial()) {
    on<JudulChanged>(_onJudulChanged);
    on<DeskripsiChanged>(_onDeskripsiChanged);
    on<ImagesAdded>(_onImagesAdded);
    on<ImageRemoved>(_onImageRemoved);
    on<PortofolioSubmitted>(_onPortofolioSubmitted);
    on<PortofolioReset>(_onPortofolioReset);
  }

  void _onJudulChanged(JudulChanged event, Emitter<PortofolioState> emit) {
    emit(state.copyWith(judul: event.value, clearError: true));
  }

  void _onDeskripsiChanged(
    DeskripsiChanged event,
    Emitter<PortofolioState> emit,
  ) {
    emit(state.copyWith(deskripsi: event.value, clearError: true));
  }

  void _onImagesAdded(ImagesAdded event, Emitter<PortofolioState> emit) {
    emit(
      state.copyWith(
        imagePaths: [...state.imagePaths, ...event.paths],
        clearError: true,
      ),
    );
  }

  void _onImageRemoved(ImageRemoved event, Emitter<PortofolioState> emit) {
    final updated = List<String>.from(state.imagePaths)..removeAt(event.index);
    emit(state.copyWith(imagePaths: updated));
  }

  Future<void> _onPortofolioSubmitted(
    PortofolioSubmitted event,
    Emitter<PortofolioState> emit,
  ) async {
    if (!state.isFormValid || state.isLoading) return;

    emit(state.copyWith(submitStatus: PortofolioSubmitStatus.loading));

    final result = await tambahPortofolioUsecase(
      TambahPortofolioParams(
        judul: state.judul.trim(),
        deskripsi: state.deskripsi.trim(),
        imagePaths: state.imagePaths,
      ),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        submitStatus: PortofolioSubmitStatus.failure,
        errorMessage: failure.message,
      )),
      (_) => emit(state.copyWith(
        submitStatus: PortofolioSubmitStatus.success,
        clearError: true,
      )),
    );
  }

  void _onPortofolioReset(
    PortofolioReset event,
    Emitter<PortofolioState> emit,
  ) {
    emit(PortofolioState.initial());
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/contractor_milestone_entity.dart';
import '../../domain/usecases/contractor_get_system_milestones_usecase.dart';
import '../../domain/usecases/contractor_publikasi_milestone_usecase.dart';
import 'contractor_milestone_event.dart';
import 'contractor_milestone_state.dart';

class ContractorMilestoneBloc
    extends Bloc<ContractorMilestoneEvent, ContractorMilestoneState> {
  final ContractorGetSystemMilestonesUseCase getSystemMilestones;
  final ContractorPublikasiMilestoneUseCase publikasiMilestone;
  final double totalNilaiKontrak;

  final _uuid = Uuid();

  ContractorMilestoneBloc({
    required this.getSystemMilestones,
    required this.publikasiMilestone,
    required this.totalNilaiKontrak,
  }) : super(const ContractorMilestoneInitial()) {
    on<ContractorMilestoneInputModeChanged>(_onInputModeChanged);
    on<ContractorMilestoneLoadSystem>(_onLoadSystem);
    on<ContractorMilestoneAdded>(_onAdded);
    on<ContractorMilestoneUpdated>(_onUpdated);
    on<ContractorMilestoneDeleted>(_onDeleted);
    on<ContractorMilestoneReordered>(_onReordered);
    on<ContractorMilestoneSystemDeadlineUpdated>(_onSystemDeadlineUpdated);
    on<ContractorMilestonePublished>(_onPublished);

    // Boot: start on "Dari Sistem"
    add(ContractorMilestoneInputModeChanged(MilestoneInputMode.dariSistem));
  }

  // ─── handlers ───────────────────────────────────────────────────────────

  void _onInputModeChanged(
    ContractorMilestoneInputModeChanged event,
    Emitter<ContractorMilestoneState> emit,
  ) {
    if (event.mode == MilestoneInputMode.dariSistem) {
      add(ContractorMilestoneLoadSystem(totalNilaiKontrak));
    } else {
      // Switch to manual — keep existing manual list if already there
      final currentList =
          (state is ContractorMilestoneLoaded &&
              (state as ContractorMilestoneLoaded).inputMode ==
                  MilestoneInputMode.manual)
          ? (state as ContractorMilestoneLoaded).milestones
          : <ContractorMilestoneEntity>[];

      emit(
        ContractorMilestoneLoaded(
          inputMode: MilestoneInputMode.manual,
          milestones: currentList,
          totalNilaiKontrak: totalNilaiKontrak,
        ),
      );
    }
  }

  Future<void> _onLoadSystem(
    ContractorMilestoneLoadSystem event,
    Emitter<ContractorMilestoneState> emit,
  ) async {
    emit(const ContractorMilestoneLoading());
    try {
      final milestones = await getSystemMilestones(event.totalNilaiKontrak);
      emit(
        ContractorMilestoneLoaded(
          inputMode: MilestoneInputMode.dariSistem,
          milestones: milestones,
          totalNilaiKontrak: event.totalNilaiKontrak,
        ),
      );
    } catch (e) {
      emit(ContractorMilestoneError(e.toString()));
    }
  }

  void _onAdded(
    ContractorMilestoneAdded event,
    Emitter<ContractorMilestoneState> emit,
  ) {
    if (state is! ContractorMilestoneLoaded) return;
    final current = state as ContractorMilestoneLoaded;
    if (current.totalAlokasi >= 1.0) return;

    final newItem = ContractorMilestoneEntity(
      id: _uuid.v4(),
      nama: 'Initial Milestone',
      persentase: 0.0,
      jumlahUang: 0.0,
      tipe: MilestoneTipe.nonPembangunan,
    );

    emit(current.copyWith(milestones: [...current.milestones, newItem]));
  }

  void _onUpdated(
    ContractorMilestoneUpdated event,
    Emitter<ContractorMilestoneState> emit,
  ) {
    if (state is! ContractorMilestoneLoaded) return;
    final current = state as ContractorMilestoneLoaded;
    final updated = current.milestones
        .map((m) => m.id == event.milestone.id ? event.milestone : m)
        .toList();
    emit(current.copyWith(milestones: updated));
  }

  void _onDeleted(
    ContractorMilestoneDeleted event,
    Emitter<ContractorMilestoneState> emit,
  ) {
    if (state is! ContractorMilestoneLoaded) return;
    final current = state as ContractorMilestoneLoaded;
    emit(
      current.copyWith(
        milestones: current.milestones
            .where((m) => m.id != event.milestoneId)
            .toList(),
      ),
    );
  }

  void _onReordered(
    ContractorMilestoneReordered event,
    Emitter<ContractorMilestoneState> emit,
  ) {
    if (state is! ContractorMilestoneLoaded) return;
    final current = state as ContractorMilestoneLoaded;
    final list = List<ContractorMilestoneEntity>.from(current.milestones);
    final item = list.removeAt(event.oldIndex);
    final insertIdx = event.newIndex > event.oldIndex
        ? event.newIndex - 1
        : event.newIndex;
    list.insert(insertIdx, item);
    emit(current.copyWith(milestones: list));
  }

  void _onSystemDeadlineUpdated(
    ContractorMilestoneSystemDeadlineUpdated event,
    Emitter<ContractorMilestoneState> emit,
  ) {
    if (state is! ContractorMilestoneLoaded) return;
    final current = state as ContractorMilestoneLoaded;
    final updated = current.milestones
        .map(
          (m) => m.id == event.milestoneId
              ? m.copyWith(deadline: event.deadline)
              : m,
        )
        .toList();
    emit(current.copyWith(milestones: updated));
  }

  Future<void> _onPublished(
    ContractorMilestonePublished event,
    Emitter<ContractorMilestoneState> emit,
  ) async {
    if (state is! ContractorMilestoneLoaded) return;
    final current = state as ContractorMilestoneLoaded;
    emit(const ContractorMilestonePublishing());
    try {
      await publikasiMilestone(current.milestones);
      emit(const ContractorMilestonePublishSuccess());
    } catch (e) {
      emit(ContractorMilestoneError(e.toString()));
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/architect_milestone_entity.dart';
import '../../domain/usecases/get_architect_system_milestones_usecase.dart';
import '../../domain/usecases/get_architect_publikasi_milestone_usecase.dart';
import 'architect_milestone_event.dart';
import 'architect_milestone_state.dart';

class ArchitectMilestoneBloc
    extends Bloc<ArchitectMilestoneEvent, ArchitectMilestoneState> {
  final ArchitectGetSystemMilestonesUseCase getSystemMilestones;
  final ArchitectPublikasiMilestoneUseCase publikasiMilestone;
  final double totalNilaiKontrak;

  final _uuid = Uuid();

  ArchitectMilestoneBloc({
    required this.getSystemMilestones,
    required this.publikasiMilestone,
    required this.totalNilaiKontrak,
  }) : super(const ArchitectMilestoneInitial()) {
    on<ArchitectMilestoneInputModeChanged>(_onInputModeChanged);
    on<ArchitectMilestoneLoadSystem>(_onLoadSystem);
    on<ArchitectMilestoneAdded>(_onAdded);
    on<ArchitectMilestoneUpdated>(_onUpdated);
    on<ArchitectMilestoneDeleted>(_onDeleted);
    on<ArchitectMilestoneReordered>(_onReordered);
    on<ArchitectMilestoneSystemDeadlineUpdated>(_onSystemDeadlineUpdated);
    on<ArchitectMilestonePublished>(_onPublished);

    // Boot: start on "Dari Sistem"
    add(ArchitectMilestoneInputModeChanged(MilestoneInputMode.dariSistem));
  }

  // ─── handlers ───────────────────────────────────────────────────────────

  void _onInputModeChanged(
    ArchitectMilestoneInputModeChanged event,
    Emitter<ArchitectMilestoneState> emit,
  ) {
    if (event.mode == MilestoneInputMode.dariSistem) {
      add(ArchitectMilestoneLoadSystem(totalNilaiKontrak));
    } else {
      // Switch to manual — keep existing manual list if already there
      final currentList =
          (state is ArchitectMilestoneLoaded &&
              (state as ArchitectMilestoneLoaded).inputMode ==
                  MilestoneInputMode.manual)
          ? (state as ArchitectMilestoneLoaded).milestones
          : <ArchitectMilestoneEntity>[];

      emit(
        ArchitectMilestoneLoaded(
          inputMode: MilestoneInputMode.manual,
          milestones: currentList,
          totalNilaiKontrak: totalNilaiKontrak,
        ),
      );
    }
  }

  Future<void> _onLoadSystem(
    ArchitectMilestoneLoadSystem event,
    Emitter<ArchitectMilestoneState> emit,
  ) async {
    emit(const ArchitectMilestoneLoading());
    try {
      final milestones = await getSystemMilestones(event.totalNilaiKontrak);
      emit(
        ArchitectMilestoneLoaded(
          inputMode: MilestoneInputMode.dariSistem,
          milestones: milestones,
          totalNilaiKontrak: event.totalNilaiKontrak,
        ),
      );
    } catch (e) {
      emit(ArchitectMilestoneError(e.toString()));
    }
  }

  void _onAdded(
    ArchitectMilestoneAdded event,
    Emitter<ArchitectMilestoneState> emit,
  ) {
    if (state is! ArchitectMilestoneLoaded) return;
    final current = state as ArchitectMilestoneLoaded;
    if (current.totalAlokasi >= 1.0) return;

    final newItem = ArchitectMilestoneEntity(
      id: _uuid.v4(),
      nama: 'Initial Milestone',
      persentase: 0.0,
      jumlahUang: 0.0,
      tipe: MilestoneTipe.nonPembangunan,
    );

    emit(current.copyWith(milestones: [...current.milestones, newItem]));
  }

  void _onUpdated(
    ArchitectMilestoneUpdated event,
    Emitter<ArchitectMilestoneState> emit,
  ) {
    if (state is! ArchitectMilestoneLoaded) return;
    final current = state as ArchitectMilestoneLoaded;
    final updated = current.milestones
        .map((m) => m.id == event.milestone.id ? event.milestone : m)
        .toList();
    emit(current.copyWith(milestones: updated));
  }

  void _onDeleted(
    ArchitectMilestoneDeleted event,
    Emitter<ArchitectMilestoneState> emit,
  ) {
    if (state is! ArchitectMilestoneLoaded) return;
    final current = state as ArchitectMilestoneLoaded;
    emit(
      current.copyWith(
        milestones: current.milestones
            .where((m) => m.id != event.milestoneId)
            .toList(),
      ),
    );
  }

  void _onReordered(
    ArchitectMilestoneReordered event,
    Emitter<ArchitectMilestoneState> emit,
  ) {
    if (state is! ArchitectMilestoneLoaded) return;
    final current = state as ArchitectMilestoneLoaded;
    final list = List<ArchitectMilestoneEntity>.from(current.milestones);
    final item = list.removeAt(event.oldIndex);
    final insertIdx = event.newIndex > event.oldIndex
        ? event.newIndex - 1
        : event.newIndex;
    list.insert(insertIdx, item);
    emit(current.copyWith(milestones: list));
  }

  void _onSystemDeadlineUpdated(
    ArchitectMilestoneSystemDeadlineUpdated event,
    Emitter<ArchitectMilestoneState> emit,
  ) {
    if (state is! ArchitectMilestoneLoaded) return;
    final current = state as ArchitectMilestoneLoaded;
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
    ArchitectMilestonePublished event,
    Emitter<ArchitectMilestoneState> emit,
  ) async {
    if (state is! ArchitectMilestoneLoaded) return;
    final current = state as ArchitectMilestoneLoaded;
    emit(const ArchitectMilestonePublishing());
    try {
      await publikasiMilestone(current.milestones);
      emit(const ArchitectMilestonePublishSuccess());
    } catch (e) {
      emit(ArchitectMilestoneError(e.toString()));
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/getdata_roles_usecase.dart';
import 'roles_event.dart';
import 'roles_state.dart';

class RolesBloc extends Bloc<RolesEvent, RolesState> {
  final GetRolesDataUseCase getRolesDataUseCase;

  RolesBloc({required this.getRolesDataUseCase}) : super(RolesInitial()) {
    on<GetRolesEvent>(_onGetRoles);
    on<SelectRoleEvent>(_onSelectRole);
    on<SubmitRoleEvent>(_onSubmitRole);
  }

  void _onGetRoles(GetRolesEvent event, Emitter<RolesState> emit) {
    emit(RolesLoading());
    try {
      final roles = getRolesDataUseCase();
      emit(RolesLoaded(roles: roles, selectedRole: null));
    } catch (e) {
      emit(RolesFailure("Gagal memuat peran user: ${e.toString()}"));
    }
  }

  void _onSelectRole(SelectRoleEvent event, Emitter<RolesState> emit) {
    final currentState = state;
    if (currentState is RolesLoaded) {
      emit(currentState.copyWith(selectedRole: event.selectedRole));
    }
  }

  void _onSubmitRole(SubmitRoleEvent event, Emitter<RolesState> emit) async {
    final currentState = state;
    List<dynamic> rolesList = [];
    if (currentState is RolesLoaded) {
      rolesList = currentState.roles;
    }
    
    emit(RolesSubmitting(
      roles: rolesList.cast(),
      selectedRole: event.chosenRole,
    ));

    try {
      // Simulasi loading / penyimpanan data (misal ke local storage/remote DB)
      await Future.delayed(const Duration(milliseconds: 1500));
      emit(RolesSubmitSuccess(event.chosenRole));
    } catch (e) {
      emit(RolesFailure("Gagal menyimpan pilihan peran: ${e.toString()}"));
    }
  }
}

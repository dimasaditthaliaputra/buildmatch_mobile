import 'package:flutter_bloc/flutter_bloc.dart';

class ArchitectDashboardCubit extends Cubit<int> {
  ArchitectDashboardCubit() : super(0);

  void changeTab(int index) {
    emit(index);
  }
}
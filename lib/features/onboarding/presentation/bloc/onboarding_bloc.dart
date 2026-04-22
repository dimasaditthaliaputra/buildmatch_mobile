import 'package:buildmatch_mobile/features/onboarding/domain/usecases/get_onboarding_pages.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final GetOnboardingPages getOnboardingPages;

  OnboardingBloc(this.getOnboardingPages) : super(OnboardingState(pages: [])) {
    on<LoadOnboardingPages>((event, emit) {
      final pages = getOnboardingPages.execute();
      emit(OnboardingState(pages: pages, currentIndex: 0));
    });

    on<PageChanged>((event, emit) {
      emit(OnboardingState(pages: state.pages, currentIndex: event.index));
    });
  }
}
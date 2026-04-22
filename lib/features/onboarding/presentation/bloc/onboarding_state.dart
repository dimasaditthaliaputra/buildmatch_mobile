import 'package:buildmatch_mobile/features/onboarding/domain/entities/onboarding_entity.dart';

class OnboardingState {
  final List<OnboardingEntity> pages;
  final int currentIndex;

  OnboardingState({required this.pages, this.currentIndex = 0});
}
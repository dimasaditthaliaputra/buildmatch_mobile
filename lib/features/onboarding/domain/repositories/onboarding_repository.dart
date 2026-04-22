import 'package:buildmatch_mobile/features/onboarding/domain/entities/onboarding_entity.dart';

abstract class OnboardingRepository {
  List<OnboardingEntity> getPages();
}
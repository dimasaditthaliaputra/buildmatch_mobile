import 'package:buildmatch_mobile/features/onboarding/domain/entities/onboarding_entity.dart';
import 'package:buildmatch_mobile/features/onboarding/domain/repositories/onboarding_repository.dart';

class GetOnboardingPages {
  final OnboardingRepository repository;
  GetOnboardingPages(this.repository);

  List<OnboardingEntity> execute() => repository.getPages();
}
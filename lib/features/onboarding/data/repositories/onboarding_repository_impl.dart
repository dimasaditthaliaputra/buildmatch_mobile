import 'package:buildmatch_mobile/features/onboarding/domain/repositories/onboarding_repository.dart';

import '../../domain/entities/onboarding_entity.dart';
import '../datasources/onboarding_local_data_source.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingLocalDataSource localDataSource;

  OnboardingRepositoryImpl({required this.localDataSource});

  @override
  List<OnboardingEntity> getPages() {
    return localDataSource.getOnboardingData();
  }
}
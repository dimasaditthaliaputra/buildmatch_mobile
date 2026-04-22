import 'package:buildmatch_mobile/features/onboarding/domain/entities/onboarding_entity.dart';

abstract class OnboardingLocalDataSource {
  List<OnboardingEntity> getOnboardingData();
}

class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  @override
  List<OnboardingEntity> getOnboardingData() {
    return const [
      OnboardingEntity(
        image: 'assets/lottie/onboarding1.json',
        title: 'Rancang\n',
        titleHighlight: 'Impian ',
        titleEnd: 'Anda',
        description: 'Temukan arsitek profesional yang siap mengubah ide Anda menjadi desain nyata.',
      ),
      OnboardingEntity(
        image: 'assets/lottie/onboarding2.json',
        title: 'Bangun ',
        titleHighlight: 'dengan\n',
        titleEnd: 'Terpercaya',
        description: 'Pilih kontraktor terbaik dengan sistem pembayaran aman melalui Escrow.',
      ),
      OnboardingEntity(
        image: 'assets/lottie/onboarding3.json',
        title: '',
        titleHighlight: '',
        titleEnd: 'Mulai Sekarang',
        description: 'Platform marketplace konstruksi terlengkap untuk hasil yang maksimal.',
      ),
    ];
  }
}
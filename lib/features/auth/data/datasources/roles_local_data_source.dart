import 'package:buildmatch_mobile/features/auth/domain/entities/roles_entity.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

abstract class RolesLocalDataSource {
  List<RolesEntity> getOnboardingData();
}

class RolesLocalDataSourceImpl implements RolesLocalDataSource {
  @override
  List<RolesEntity> getOnboardingData() {
    return const [
      RolesEntity(
        id: 1,
        rolesName: 'Client',
        icon: LucideIcons.house,
        title: 'Saya ingin membangun',
        description: 'Mulai proyek hunian atau bisnis impian Anda bersama profesional terbaik',
      ),
      RolesEntity(
        id: 2,
        rolesName: 'Architect',
        icon: LucideIcons.draftingCompass,
        title: 'Saya ingin mendesain',
        description: 'Ciptakan blueprint masa dengan dan temukan klien yang menghargai visi Anda.',
      ),
      RolesEntity(
        id: 3,
        rolesName: 'Contractor',
        icon: LucideIcons.hammer,
        title: 'Saya ingin membangun konstruksi',
        description: 'Eksekusi proyek dengan standar kualitas tinggi dan manajemen yang presisi.',
      ),
    ];
  }
}

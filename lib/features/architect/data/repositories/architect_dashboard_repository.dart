import '../../domain/entities/architect_dashboard_entity.dart';

abstract class ArchitectDashboardRepository {
  Future<ArchitectDashboardEntity> getDashboardData(String architectId);
}
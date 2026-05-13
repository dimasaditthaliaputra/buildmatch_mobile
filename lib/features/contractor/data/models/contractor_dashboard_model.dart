import '../../domain/entities/contractor_dashboard_entity.dart';

class ContractorDashboardModel extends ContractorDashboardEntity {
  const ContractorDashboardModel({
    required super.contractorName,
    required super.contractorRole,
    super.avatarUrl,
    required super.financialSummary,
    required super.activeProjects,
    required super.projectListings,
    required super.financialChartData,
    required super.projectStats,
  });

  factory ContractorDashboardModel.fromJson(Map<String, dynamic> json) {
    return ContractorDashboardModel(
      contractorName: json['contractor_name'] ?? '',
      contractorRole: json['contractor_role'] ?? '',
      avatarUrl: json['avatar_url'],
      financialSummary: FinancialSummaryModel.fromJson(
        json['financial_summary'] ?? {},
      ),
      activeProjects:
          (json['active_projects'] as List<dynamic>? ?? [])
              .map((e) => ActiveProjectModel.fromJson(e))
              .toList(),
      projectListings:
          (json['project_listings'] as List<dynamic>? ?? [])
              .map((e) => ProjectListingModel.fromJson(e))
              .toList(),
      financialChartData:
          (json['financial_chart_data'] as List<dynamic>? ?? [])
              .map((e) => FinancialDataModel.fromJson(e))
              .toList(),
      projectStats: ProjectStatsModel.fromJson(json['project_stats'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'contractor_name': contractorName,
      'contractor_role': contractorRole,
      'avatar_url': avatarUrl,
    };
  }
}

class FinancialSummaryModel extends FinancialSummaryEntity {
  const FinancialSummaryModel({
    required super.totalIncome,
    required super.disbursed,
    required super.notDisbursed,
    required super.disbursedTransactions,
    required super.pendingTransactions,
    required super.disbursedCount,
    required super.notDisbursedCount,
    required super.period,
  });

  factory FinancialSummaryModel.fromJson(Map<String, dynamic> json) {
    return FinancialSummaryModel(
      totalIncome: (json['total_income'] ?? 0).toDouble(),
      disbursed: (json['disbursed'] ?? 0).toDouble(),
      notDisbursed: (json['not_disbursed'] ?? 0).toDouble(),
      disbursedTransactions: json['disbursed_transactions'] ?? 0,
      pendingTransactions: json['pending_transactions'] ?? 0,
      disbursedCount: json['disbursed_count'] ?? 0,
      notDisbursedCount: json['not_disbursed_count'] ?? 0,
      period: json['period'] ?? '',
    );
  }
}

class ActiveProjectModel extends ActiveProjectEntity {
  const ActiveProjectModel({
    required super.id,
    required super.name,
    required super.location,
    required super.phase,
    required super.progressPercent,
    required super.status,
    super.targetDate,
    super.startDate,
    super.imageUrl,
  });

  factory ActiveProjectModel.fromJson(Map<String, dynamic> json) {
    return ActiveProjectModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      phase: json['phase'] ?? '',
      progressPercent: (json['progress_percent'] ?? 0).toDouble(),
      status: json['status'] ?? '',
      targetDate: json['target_date'],
      startDate: json['start_date'],
      imageUrl: json['image_url'],
    );
  }
}

class ProjectListingModel extends ProjectListingEntity {
  const ProjectListingModel({
    required super.id,
    required super.name,
    required super.location,
    required super.minPrice,
    required super.maxPrice,
    required super.buildingArea,
    required super.isNew,
  });

  factory ProjectListingModel.fromJson(Map<String, dynamic> json) {
    return ProjectListingModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      minPrice: (json['min_price'] ?? 0).toDouble(),
      maxPrice: (json['max_price'] ?? 0).toDouble(),
      buildingArea: (json['building_area'] ?? 0).toDouble(),
      isNew: json['is_new'] ?? false,
    );
  }
}

class FinancialDataModel extends FinancialDataEntity {
  const FinancialDataModel({
    required super.month,
    required super.income,
    required super.expense,
  });

  factory FinancialDataModel.fromJson(Map<String, dynamic> json) {
    return FinancialDataModel(
      month: json['month'] ?? '',
      income: (json['income'] ?? 0).toDouble(),
      expense: (json['expense'] ?? 0).toDouble(),
    );
  }
}

class ProjectStatsModel extends ProjectStatsEntity {
  const ProjectStatsModel({
    required super.total,
    required super.active,
    required super.review,
    required super.pending,
    required super.averageRating,
  });

  factory ProjectStatsModel.fromJson(Map<String, dynamic> json) {
    return ProjectStatsModel(
      total: json['total'] ?? 0,
      active: json['active'] ?? 0,
      review: json['review'] ?? 0,
      pending: json['pending'] ?? 0,
      averageRating: (json['average_rating'] ?? 0).toDouble(),
    );
  }
}
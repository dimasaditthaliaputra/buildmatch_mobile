class ContractorDashboardEntity {
  final String contractorName;
  final String contractorRole;
  final String? avatarUrl;
  final FinancialSummaryEntity financialSummary;
  final List<ActiveProjectEntity> activeProjects;
  final List<ProjectListingEntity> projectListings;
  final List<FinancialDataEntity> financialChartData;
  final ProjectStatsEntity projectStats;

  const ContractorDashboardEntity({
    required this.contractorName,
    required this.contractorRole,
    this.avatarUrl,
    required this.financialSummary,
    required this.activeProjects,
    required this.projectListings,
    required this.financialChartData,
    required this.projectStats,
  });
}

class FinancialSummaryEntity {
  final double totalIncome;
  final double disbursed;
  final double notDisbursed;
  final int disbursedTransactions;
  final int pendingTransactions;
  final int disbursedCount;
  final int notDisbursedCount;
  final String period;

  const FinancialSummaryEntity({
    required this.totalIncome,
    required this.disbursed,
    required this.notDisbursed,
    required this.disbursedTransactions,
    required this.pendingTransactions,
    required this.disbursedCount,
    required this.notDisbursedCount,
    required this.period,
  });
}

class ActiveProjectEntity {
  final String id;
  final String name;
  final String location;
  final String phase;
  final double progressPercent;
  final String status;
  final String? targetDate;
  final String? startDate;
  final String? imageUrl;

  const ActiveProjectEntity({
    required this.id,
    required this.name,
    required this.location,
    required this.phase,
    required this.progressPercent,
    required this.status,
    this.targetDate,
    this.startDate,
    this.imageUrl,
  });
}

class ProjectListingEntity {
  final String id;
  final String name;
  final String location;
  final double minPrice;
  final double maxPrice;
  final double buildingArea;
  final bool isNew;

  const ProjectListingEntity({
    required this.id,
    required this.name,
    required this.location,
    required this.minPrice,
    required this.maxPrice,
    required this.buildingArea,
    required this.isNew,
  });
}

class FinancialDataEntity {
  final String month;
  final double income;
  final double expense;

  const FinancialDataEntity({
    required this.month,
    required this.income,
    required this.expense,
  });
}

class ProjectStatsEntity {
  final int total;
  final int active;
  final int review;
  final int pending;
  final double averageRating;

  const ProjectStatsEntity({
    required this.total,
    required this.active,
    required this.review,
    required this.pending,
    required this.averageRating,
  });
}
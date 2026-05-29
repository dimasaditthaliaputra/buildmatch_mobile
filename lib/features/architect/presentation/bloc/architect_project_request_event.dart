import '../../domain/entities/architect_project_request_entity.dart';

abstract class ArchitectProjectRequestEvent {}

class LoadArchitectProjectRequests extends ArchitectProjectRequestEvent {}

class FilterArchitectProjectRequestsByStatus extends ArchitectProjectRequestEvent {
  final ProjectRequestStatus status;
  FilterArchitectProjectRequestsByStatus(this.status);
}

class SearchArchitectProjectRequests extends ArchitectProjectRequestEvent {
  final String query;
  SearchArchitectProjectRequests(this.query);
}

class ApplyArchitectProjectFilter extends ArchitectProjectRequestEvent {
  final int? minBudget;
  final int? maxBudget;
  final String sortOption;
  final String location;

  ApplyArchitectProjectFilter({
    this.minBudget,
    this.maxBudget,
    required this.sortOption,
    required this.location,
  });
}
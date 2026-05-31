import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object?> get props => [];
}

class LoadCategoriesEvent extends CategoryEvent {
  final bool isRefresh;
  final String? searchQuery;

  const LoadCategoriesEvent({this.isRefresh = false, this.searchQuery});

  @override
  List<Object?> get props => [isRefresh, searchQuery];
}

class LoadMoreCategoriesEvent extends CategoryEvent {}

class GetCategoryDetailEvent extends CategoryEvent {
  final String id;
  const GetCategoryDetailEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class CreateCategoryEvent extends CategoryEvent {
  final String name;
  final String description;

  const CreateCategoryEvent({required this.name, required this.description});

  @override
  List<Object?> get props => [name, description];
}

class UpdateCategoryEvent extends CategoryEvent {
  final String id;
  final String? name;
  final String? description;

  const UpdateCategoryEvent({required this.id, this.name, this.description});

  @override
  List<Object?> get props => [id, name, description];
}

class DeleteCategoryEvent extends CategoryEvent {
  final String id;
  const DeleteCategoryEvent(this.id);

  @override
  List<Object?> get props => [id];
}

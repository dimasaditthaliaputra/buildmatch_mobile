import 'package:equatable/equatable.dart';
import '../../domain/entities/category_entity.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();
  
  @override
  List<Object?> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<CategoryEntity> categories;
  final bool hasReachedMax;
  final bool isLoadingMore;

  const CategoryLoaded({
    required this.categories,
    required this.hasReachedMax,
    this.isLoadingMore = false,
  });

  CategoryLoaded copyWith({
    List<CategoryEntity>? categories,
    bool? hasReachedMax,
    bool? isLoadingMore,
  }) {
    return CategoryLoaded(
      categories: categories ?? this.categories,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [categories, hasReachedMax, isLoadingMore];
}

class CategoryEmpty extends CategoryState {}

class CategoryError extends CategoryState {
  final String message;
  const CategoryError(this.message);

  @override
  List<Object?> get props => [message];
}

class CategoryDetailLoaded extends CategoryState {
  final CategoryEntity category;
  const CategoryDetailLoaded(this.category);

  @override
  List<Object?> get props => [category];
}

class CategorySubmitting extends CategoryState {}

class CategorySubmitSuccess extends CategoryState {
  final String message;
  const CategorySubmitSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class CategorySubmitError extends CategoryState {
  final String message;
  const CategorySubmitError(this.message);

  @override
  List<Object?> get props => [message];
}

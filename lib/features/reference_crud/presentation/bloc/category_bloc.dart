import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/category_usecases.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetCategoryDetailUseCase getCategoryDetailUseCase;
  final CreateCategoryUseCase createCategoryUseCase;
  final UpdateCategoryUseCase updateCategoryUseCase;
  final DeleteCategoryUseCase deleteCategoryUseCase;

  int _currentPage = 0;
  final int _limit = 10;
  String? _currentSearchQuery;

  CategoryBloc({
    required this.getCategoriesUseCase,
    required this.getCategoryDetailUseCase,
    required this.createCategoryUseCase,
    required this.updateCategoryUseCase,
    required this.deleteCategoryUseCase,
  }) : super(CategoryInitial()) {
    on<LoadCategoriesEvent>(_onLoadCategories);
    on<LoadMoreCategoriesEvent>(_onLoadMoreCategories);
    on<GetCategoryDetailEvent>(_onGetCategoryDetail);
    on<CreateCategoryEvent>(_onCreateCategory);
    on<UpdateCategoryEvent>(_onUpdateCategory);
    on<DeleteCategoryEvent>(_onDeleteCategory);
  }

  Future<void> _onLoadCategories(
    LoadCategoriesEvent event,
    Emitter<CategoryState> emit,
  ) async {
    if (event.isRefresh) {
      _currentPage = 0;
    } else {
      emit(CategoryLoading());
    }

    _currentSearchQuery = event.searchQuery ?? _currentSearchQuery;

    final result = await getCategoriesUseCase(
      limit: _limit,
      offset: _currentPage * _limit,
      searchQuery: _currentSearchQuery,
    );

    result.fold(
      (failure) => emit(CategoryError(failure.message)),
      (categories) {
        if (categories.isEmpty) {
          emit(CategoryEmpty());
        } else {
          emit(CategoryLoaded(
            categories: categories,
            hasReachedMax: categories.length < _limit,
          ));
        }
      },
    );
  }

  Future<void> _onLoadMoreCategories(
    LoadMoreCategoriesEvent event,
    Emitter<CategoryState> emit,
  ) async {
    if (state is CategoryLoaded) {
      final currentState = state as CategoryLoaded;
      if (currentState.hasReachedMax || currentState.isLoadingMore) return;

      emit(currentState.copyWith(isLoadingMore: true));
      _currentPage++;

      final result = await getCategoriesUseCase(
        limit: _limit,
        offset: _currentPage * _limit,
        searchQuery: _currentSearchQuery,
      );

      result.fold(
        (failure) {
          emit(currentState.copyWith(isLoadingMore: false));
          // Could emit a side effect or log error here
        },
        (categories) {
          if (categories.isEmpty) {
            emit(currentState.copyWith(
              hasReachedMax: true,
              isLoadingMore: false,
            ));
          } else {
            emit(CategoryLoaded(
              categories: currentState.categories + categories,
              hasReachedMax: categories.length < _limit,
              isLoadingMore: false,
            ));
          }
        },
      );
    }
  }

  Future<void> _onGetCategoryDetail(
    GetCategoryDetailEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());
    final result = await getCategoryDetailUseCase(event.id);
    result.fold(
      (failure) => emit(CategoryError(failure.message)),
      (category) => emit(CategoryDetailLoaded(category)),
    );
  }

  Future<void> _onCreateCategory(
    CreateCategoryEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategorySubmitting());
    final result = await createCategoryUseCase(
      name: event.name,
      description: event.description,
    );
    result.fold(
      (failure) => emit(CategorySubmitError(failure.message)),
      (_) => emit(const CategorySubmitSuccess('Kategori berhasil ditambahkan')),
    );
  }

  Future<void> _onUpdateCategory(
    UpdateCategoryEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategorySubmitting());
    final result = await updateCategoryUseCase(
      id: event.id,
      name: event.name,
      description: event.description,
    );
    result.fold(
      (failure) => emit(CategorySubmitError(failure.message)),
      (_) => emit(const CategorySubmitSuccess('Kategori berhasil diperbarui')),
    );
  }

  Future<void> _onDeleteCategory(
    DeleteCategoryEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategorySubmitting());
    final result = await deleteCategoryUseCase(event.id);
    result.fold(
      (failure) => emit(CategorySubmitError(failure.message)),
      (_) => emit(const CategorySubmitSuccess('Kategori berhasil dihapus')),
    );
  }
}

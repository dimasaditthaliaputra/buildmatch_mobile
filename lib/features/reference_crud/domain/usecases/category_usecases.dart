import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/category_entity.dart';
import '../repositories/category_repository.dart';

class GetCategoriesUseCase {
  final CategoryRepository repository;

  GetCategoriesUseCase(this.repository);

  Future<Either<Failure, List<CategoryEntity>>> call({
    required int limit,
    required int offset,
    String? searchQuery,
  }) async {
    return await repository.getCategories(
      limit: limit,
      offset: offset,
      searchQuery: searchQuery,
    );
  }
}

class GetCategoryDetailUseCase {
  final CategoryRepository repository;

  GetCategoryDetailUseCase(this.repository);

  Future<Either<Failure, CategoryEntity>> call(String id) async {
    return await repository.getCategoryDetail(id);
  }
}

class CreateCategoryUseCase {
  final CategoryRepository repository;

  CreateCategoryUseCase(this.repository);

  Future<Either<Failure, CategoryEntity>> call({
    required String name,
    required String description,
  }) async {
    return await repository.createCategory(name: name, description: description);
  }
}

class UpdateCategoryUseCase {
  final CategoryRepository repository;

  UpdateCategoryUseCase(this.repository);

  Future<Either<Failure, CategoryEntity>> call({
    required String id,
    String? name,
    String? description,
  }) async {
    return await repository.updateCategory(id: id, name: name, description: description);
  }
}

class DeleteCategoryUseCase {
  final CategoryRepository repository;

  DeleteCategoryUseCase(this.repository);

  Future<Either<Failure, void>> call(String id) async {
    return await repository.deleteCategory(id);
  }
}

import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/category_entity.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<CategoryEntity>>> getCategories({
    required int limit,
    required int offset,
    String? searchQuery,
  });

  Future<Either<Failure, CategoryEntity>> getCategoryDetail(String id);

  Future<Either<Failure, CategoryEntity>> createCategory({
    required String name,
    required String description,
  });

  Future<Either<Failure, CategoryEntity>> updateCategory({
    required String id,
    String? name,
    String? description,
  });

  Future<Either<Failure, void>> deleteCategory(String id);
}

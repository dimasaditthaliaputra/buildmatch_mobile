import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/error/exceptions.dart';
import '../models/category_model.dart';

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getCategories({
    required int limit,
    required int offset,
    String? searchQuery,
  });
  Future<CategoryModel> getCategoryDetail(String id);
  Future<CategoryModel> createCategory({
    required String name,
    required String description,
  });
  Future<CategoryModel> updateCategory({
    required String id,
    String? name,
    String? description,
  });
  Future<void> deleteCategory(String id);
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final SupabaseClient client;

  CategoryRemoteDataSourceImpl({SupabaseClient? client})
      : client = client ?? Supabase.instance.client;

  @override
  Future<List<CategoryModel>> getCategories({
    required int limit,
    required int offset,
    String? searchQuery,
  }) async {
    try {
      var query = client.from('categories').select();

      if (searchQuery != null && searchQuery.isNotEmpty) {
        query = query.ilike('name', '%$searchQuery%');
      }

      final response = await query
          .order('created_at', ascending: false)
          .range(offset, offset + limit - 1);
      return (response as List).map((json) => CategoryModel.fromJson(json)).toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<CategoryModel> getCategoryDetail(String id) async {
    try {
      final response = await client
          .from('categories')
          .select()
          .eq('id', id)
          .single();
      return CategoryModel.fromJson(response);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<CategoryModel> createCategory({
    required String name,
    required String description,
  }) async {
    try {
      final response = await client
          .from('categories')
          .insert({
            'name': name,
            'description': description,
          })
          .select()
          .single();
      return CategoryModel.fromJson(response);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<CategoryModel> updateCategory({
    required String id,
    String? name,
    String? description,
  }) async {
    try {
      final updates = <String, dynamic>{
        'updated_at': DateTime.now().toUtc().toIso8601String(),
      };

      if (name != null) updates['name'] = name;
      if (description != null) updates['description'] = description;

      final response = await client
          .from('categories')
          .update(updates)
          .eq('id', id)
          .select()
          .single();
      return CategoryModel.fromJson(response);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> deleteCategory(String id) async {
    try {
      await client.from('categories').delete().eq('id', id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}

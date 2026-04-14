import '../../../../core/error/exceptions.dart';
import '../../../../services/supabase_service.dart';
import '../models/notification_model.dart';

abstract class NotificationRemoteDataSource {
  Future<List<NotificationModel>> getNotifications();
  Future<void> markAsRead(String id);
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final _client = SupabaseService.client;

  @override
  Future<List<NotificationModel>> getNotifications() async {
    try {
      final data = await _client
          .from('notifications')
          .select()
          .order('created_at', ascending: false);

      return (data as List)
          .map((json) => NotificationModel.fromJson(json))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> markAsRead(String id) async {
    try {
      await _client
          .from('notifications')
          .update({'is_read': true})
          .eq('id', id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}

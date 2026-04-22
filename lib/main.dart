import 'package:flutter/material.dart';
import 'services/supabase_service.dart';
import 'services/push_notification_service.dart';
import 'config/injection_container.dart' as di;
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SupabaseService.initialize();

  // await PushNotificationService.initialize();

  await di.init();

  runApp(const App());
}
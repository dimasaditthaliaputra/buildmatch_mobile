import 'package:flutter/material.dart';
import 'services/supabase_service.dart';
import 'services/push_notification_service.dart';
import 'config/injection_container.dart' as di;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await SupabaseService.initialize();

  // await PushNotificationService.initialize();

  await di.init();

  runApp(const App());
}
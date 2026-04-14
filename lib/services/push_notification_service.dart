import 'package:onesignal_flutter/onesignal_flutter.dart';

class PushNotificationService {
  PushNotificationService._();

  static Future<void> initialize() async {
    OneSignal.initialize('YOUR_ONESIGNAL_APP_ID');

    OneSignal.Notifications.requestPermission(true);

    OneSignal.Notifications.addClickListener((event) {
      final data = event.notification.additionalData;
      print('Notification tapped: $data');
    });

    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      event.preventDefault();
      event.notification.display();
    });
  }

  static Future<void> setUserId(String userId) async {
    await OneSignal.login(userId);
  }

  static Future<void> removeUserId() async {
    await OneSignal.logout();
  }
}
